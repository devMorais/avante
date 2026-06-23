import { Injectable, signal } from '@angular/core';
import { Router } from '@angular/router';
import { tap } from 'rxjs';
import { resolveAvatarUrl } from './api';
import { ApiService } from './api';

const TOKEN_KEY = 'avante_token';
const USER_KEY = 'avante_user';

@Injectable({
  providedIn: 'root',
})
export class Auth {
  currentUser = signal<any>(this.loadUser());

  constructor(private api: ApiService, private router: Router) { }

  private loadUser(): any {
    const raw = localStorage.getItem(USER_KEY);
    if (!raw) return null;
    const u = JSON.parse(raw);
    return { ...u, avatar_url: resolveAvatarUrl(u.avatar_url) };
  }

  getToken(): string | null {
    return localStorage.getItem(TOKEN_KEY);
  }

  isAuthenticated(): boolean {
    return !!this.getToken();
  }

  login(email: string, password: string) {
    return this.api.login({ email, password }).pipe(
      tap((response: any) => {
        localStorage.setItem(TOKEN_KEY, response.token);
        localStorage.setItem(USER_KEY, JSON.stringify(response.user));
        this.currentUser.set(response.user);
      })
    );
  }

  logout() {
    this.api.logout().subscribe({
      complete: () => this.clearSession(),
      error: () => this.clearSession(),
    });
  }

  private clearSession() {
    localStorage.removeItem(TOKEN_KEY);
    localStorage.removeItem(USER_KEY);
    this.currentUser.set(null);
    this.router.navigate(['/login']);
  }
}
