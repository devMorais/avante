import { Component, EventEmitter, HostListener, Input, Output, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Auth } from '../../../services/auth';
import { Theme } from '../../../services/theme';
import { Notifications } from '../../../services/notifications';
import { Avatar } from '../avatar/avatar';

@Component({
  selector: 'app-sidebar',
  imports: [CommonModule, Avatar],
  templateUrl: './sidebar.html',
  styleUrl: './sidebar.scss'
})
export class Sidebar {
  @Input() collapsed = false;
  @Output() toggle = new EventEmitter<void>();

  notifOpen = signal(false);

  constructor(
    protected auth: Auth,
    private router: Router,
    protected theme: Theme,
    protected notifications: Notifications,
  ) { }

  onToggle() { this.toggle.emit(); }
  toggleTheme() { this.theme.toggle(); }
  logout() { this.auth.logout(); }
  goToProfile() { this.router.navigate(['/profile']); }

  onBellClick(event: Event) {
    event.stopPropagation();
    const opening = !this.notifOpen();
    this.notifOpen.set(opening);
    if (opening) this.notifications.loadList();
  }

  openNotification(n: any) {
    if (!n.read_at) this.notifications.markRead(n.id);
    this.notifOpen.set(false);
    if (n.task?.board_id) this.router.navigate(['/board', n.task.board_id]);
  }

  @HostListener('document:click')
  onDocumentClick() {
    if (this.notifOpen()) this.notifOpen.set(false);
  }

  initialsFor(name: string | undefined | null): string {
    if (!name) return '?';
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}
