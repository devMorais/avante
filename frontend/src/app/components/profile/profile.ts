import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Auth } from '../../services/auth';
import { ApiService, resolveAvatarUrl } from '../../services/api';
import { Sidebar } from '../../shared/ui/sidebar/sidebar';


@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, FormsModule, Sidebar],
  templateUrl: './profile.html',
  styleUrl: './profile.scss'
})
export class ProfileComponent implements OnInit {
  user = signal<any>(null);
  loading = signal(true);
  sidebarCollapsed = signal(false);
  toggleSidebar() { this.sidebarCollapsed.set(!this.sidebarCollapsed()); }
  goToBoards() { this.router.navigate(['/']); }
  saving = signal(false);
  savingPassword = signal(false);
  uploadingAvatar = signal(false);

  activeTab = signal<'info' | 'password'>('info');

  form = { name: '', email: '', bio: '', position: '' };
  passwordForm = { current_password: '', password: '', password_confirmation: '' };

  successMsg = signal('');
  errorMsg = signal('');
  passwordSuccessMsg = signal('');
  passwordErrorMsg = signal('');
  avatarPreview = signal<string | null>(null);

  constructor(
    private api: ApiService,
    private auth: Auth,
    private router: Router
  ) { }

  ngOnInit() {
    this.api.getProfile().subscribe({
      next: (u) => {
        const normalized = { ...u, avatar_url: resolveAvatarUrl(u.avatar_url) };
        this.user.set(normalized);
        this.form = {
          name: u.name ?? '',
          email: u.email ?? '',
          bio: u.bio ?? '',
          position: u.position ?? '',
        };
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  private syncUser(u: any) {
    this.user.set(u);
    this.auth.currentUser.set(u);
    localStorage.setItem('avante_user', JSON.stringify(u));
  }

  saveProfile() {
    this.saving.set(true);
    this.successMsg.set('');
    this.errorMsg.set('');
    this.api.updateProfile(this.form).subscribe({
      next: (u) => {
        this.syncUser(u);
        this.saving.set(false);
        this.successMsg.set('Perfil atualizado com sucesso!');
        setTimeout(() => this.successMsg.set(''), 3000);
      },
      error: (err) => {
        this.saving.set(false);
        this.errorMsg.set(err?.error?.message ?? 'Erro ao salvar perfil.');
      }
    });
  }

  savePassword() {
    this.savingPassword.set(true);
    this.passwordSuccessMsg.set('');
    this.passwordErrorMsg.set('');
    this.api.updatePassword(this.passwordForm).subscribe({
      next: () => {
        this.savingPassword.set(false);
        this.passwordSuccessMsg.set('Senha atualizada com sucesso!');
        this.passwordForm = { current_password: '', password: '', password_confirmation: '' };
        setTimeout(() => this.passwordSuccessMsg.set(''), 3000);
      },
      error: (err) => {
        this.savingPassword.set(false);
        this.passwordErrorMsg.set(err?.error?.message ?? 'Erro ao atualizar senha.');
      }
    });
  }

  onAvatarChange(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => this.avatarPreview.set(e.target?.result as string);
    reader.readAsDataURL(file);

    this.uploadingAvatar.set(true);
    this.api.uploadAvatar(file).subscribe({
      next: (res) => {
        const absoluteUrl = resolveAvatarUrl(res.avatar_url);
        const updated = { ...this.user(), avatar_url: absoluteUrl };
        this.syncUser(updated);
        this.avatarPreview.set(null); // limpa preview; agora usa avatar_url real
        this.uploadingAvatar.set(false);
      },
      error: () => this.uploadingAvatar.set(false)
    });
  }

  initialsFor(name: string | undefined | null): string {
    if (!name) return '?';
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  goBack() { this.router.navigate(['/']); }
}
