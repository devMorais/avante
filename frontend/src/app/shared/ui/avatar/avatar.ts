import { Component, Input, computed, signal } from '@angular/core';
import { CommonModule } from '@angular/common';

export type AvatarSize = 'sm' | 'md' | 'lg';

// Paleta de cores para iniciais — combina com o tom roxo (--accent) já usado no projeto
const PALETTE: { bg: string; fg: string }[] = [
  { bg: '#EEF2FF', fg: '#4F46E5' }, // índigo (cor padrão já usada em .assignee-avatar)
  { bg: '#FCE7F3', fg: '#BE185D' }, // rosa
  { bg: '#DBEAFE', fg: '#1D4ED8' }, // azul
  { bg: '#D1FAE5', fg: '#047857' }, // verde
  { bg: '#FEF3C7', fg: '#B45309' }, // âmbar
  { bg: '#E0E7FF', fg: '#4338CA' }, // violeta
  { bg: '#FFE4E6', fg: '#BE123C' }, // vermelho-rosado
  { bg: '#CFFAFE', fg: '#0E7490' }, // ciano
];

@Component({
  selector: 'app-avatar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './avatar.html',
  styleUrl: './avatar.scss',
})
export class Avatar {
  @Input() name: string | null | undefined = '';
  @Input() photoUrl: string | null | undefined = null;
  @Input() size: AvatarSize = 'md';

  // Erro de carregamento de imagem (ex: URL quebrada) cai pra iniciais
  imageFailed = signal(false);

  ngOnChanges() {
    this.imageFailed.set(false);
  }

  onImageError() {
    this.imageFailed.set(true);
  }

  get showImage(): boolean {
    return !!this.photoUrl && !this.imageFailed();
  }

  get initials(): string {
    const name = (this.name ?? '').trim();
    if (!name) return '?';
    const words = name.split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  get colors(): { bg: string; fg: string } {
    const name = (this.name ?? '?').trim() || '?';
    let hash = 0;
    for (let i = 0; i < name.length; i++) {
      hash = (hash * 31 + name.charCodeAt(i)) >>> 0;
    }
    return PALETTE[hash % PALETTE.length];
  }
}
