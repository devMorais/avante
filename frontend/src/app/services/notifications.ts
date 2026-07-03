import { Injectable, signal } from '@angular/core';
import { ApiService } from './api';

const POLL_MS = 45000;

@Injectable({ providedIn: 'root' })
export class Notifications {
  items = signal<any[]>([]);
  unreadCount = signal(0);

  constructor(private api: ApiService) {
    this.refreshCount();
    setInterval(() => this.refreshCount(), POLL_MS);
  }

  refreshCount() {
    this.api.getUnreadNotificationCount().subscribe({
      next: (res: any) => this.unreadCount.set(res.count ?? 0),
      error: () => {},
    });
  }

  loadList() {
    this.api.getNotifications().subscribe({
      next: (list: any[]) => this.items.set(list),
      error: () => {},
    });
  }

  markRead(id: number) {
    this.api.markNotificationRead(id).subscribe(() => {
      this.items.set(this.items().map(n => n.id === id ? { ...n, read_at: new Date().toISOString() } : n));
      this.refreshCount();
    });
  }

  markAllRead() {
    this.api.markAllNotificationsRead().subscribe(() => {
      this.items.set(this.items().map(n => ({ ...n, read_at: n.read_at ?? new Date().toISOString() })));
      this.unreadCount.set(0);
    });
  }
}
