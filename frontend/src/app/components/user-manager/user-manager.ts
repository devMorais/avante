import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

import { Button } from '../../shared/ui/button/button';
import { Modal } from '../../shared/ui/modal/modal';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';

@Component({
  selector: 'app-user-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, Button, Modal, ConfirmDialog],
  templateUrl: './user-manager.html',
  styleUrl: './user-manager.scss'
})
export class UserManager implements OnInit {
  users = signal<any[]>([]);
  loading = signal(true);

  // ---------- Modal criar/editar ----------
  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingUser: any = null;
  saving = signal(false);

  form = {
    name: '',
    email: '',
    password: '',
    role: 'Usuário' as 'Usuário' | 'Administrador',
  };

  // ---------- Modal excluir ----------
  deleteDialogOpen = signal(false);
  userPendingDelete: any = null;
  deleting = signal(false);

  constructor(private apiService: ApiService) { }

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers() {
    this.loading.set(true);
    this.apiService.getUsers().subscribe({
      next: (data) => {
        this.users.set(data);
        this.loading.set(false);
      },
      error: (err) => {
        console.error('Erro ao carregar usuários:', err);
        this.loading.set(false);
      }
    });
  }

  // ---------- Criar ----------

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingUser = null;
    this.form = { name: '', email: '', password: '', role: 'Usuário' };
    this.dialogOpen.set(true);
  }

  // ---------- Editar ----------

  openEditDialog(user: any) {
    this.dialogMode = 'edit';
    this.editingUser = user;
    this.form = {
      name: user.name,
      email: user.email,
      password: '',
      role: user.role,
    };
    this.dialogOpen.set(true);
  }

  closeDialog() {
    this.dialogOpen.set(false);
  }

  confirmSave() {
    if (!this.form.name.trim() || !this.form.email.trim() || this.saving()) return;
    if (this.dialogMode === 'create' && !this.form.password.trim()) return;

    this.saving.set(true);

    const payload: any = {
      name: this.form.name.trim(),
      email: this.form.email.trim(),
      role: this.form.role,
    };

    if (this.form.password.trim()) {
      payload.password = this.form.password.trim();
    }

    const request$ = this.dialogMode === 'edit' && this.editingUser
      ? this.apiService.updateUser(this.editingUser.id, payload)
      : this.apiService.createUser({ ...payload, password: this.form.password.trim() });

    request$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadUsers();
      },
      error: (err) => {
        console.error('Erro ao salvar usuário:', err);
        this.saving.set(false);
      }
    });
  }

  // ---------- Excluir ----------

  askDelete(user: any) {
    this.userPendingDelete = user;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.userPendingDelete = null;
  }

  confirmDelete() {
    if (!this.userPendingDelete || this.deleting()) return;

    this.deleting.set(true);
    this.apiService.deleteUser(this.userPendingDelete.id).subscribe({
      next: () => {
        this.users.set(this.users().filter(u => u.id !== this.userPendingDelete.id));
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.userPendingDelete = null;
      },
      error: (err) => {
        console.error('Erro ao excluir usuário:', err);
        this.deleting.set(false);
      }
    });
  }

  initialsFor(name: string): string {
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  roleLabel(role: string): string {
    return role === 'Administrador' ? 'Administrador' : 'Usuário';
  }
}
