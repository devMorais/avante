import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Auth } from '../../../services/auth';

@Component({
  selector: 'app-sidebar',
  imports: [CommonModule],
  templateUrl: './sidebar.html',
  styleUrl: './sidebar.scss'
})
export class Sidebar {
  @Input() collapsed = false;
  @Output() toggle = new EventEmitter<void>();

  constructor(protected auth: Auth, private router: Router) { }

  onToggle() { this.toggle.emit(); }
  logout() { this.auth.logout(); }
  goToProfile() { this.router.navigate(['/profile']); }

  initialsFor(name: string | undefined | null): string {
    if (!name) return '?';
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}
