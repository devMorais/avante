import { Injectable, signal, effect } from '@angular/core';

export type ThemeMode = 'light' | 'dark' | 'system';

const STORAGE_KEY = 'avante_theme';

@Injectable({ providedIn: 'root' })
export class Theme {
  mode = signal<ThemeMode>(this.loadMode());

  private media = window.matchMedia('(prefers-color-scheme: dark)');

  constructor() {
    this.media.addEventListener('change', () => {
      if (this.mode() === 'system') this.apply();
    });

    effect(() => {
      const mode = this.mode();
      localStorage.setItem(STORAGE_KEY, mode);
      this.apply();
    });
  }

  private loadMode(): ThemeMode {
    const saved = localStorage.getItem(STORAGE_KEY) as ThemeMode | null;
    return saved === 'light' || saved === 'dark' || saved === 'system' ? saved : 'system';
  }

  isDark(): boolean {
    const mode = this.mode();
    return mode === 'dark' || (mode === 'system' && this.media.matches);
  }

  private apply() {
    document.documentElement.classList.toggle('dark', this.isDark());
  }

  setMode(mode: ThemeMode) {
    this.mode.set(mode);
  }

  toggle() {
    this.setMode(this.isDark() ? 'light' : 'dark');
  }
}
