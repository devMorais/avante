import { Component, Input, computed, signal } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-badge',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './badge.html',
  styleUrl: './badge.scss',
})
export class Badge {
  // Cor base do badge (hex). Se não vier, usa um cinza neutro.
  @Input() set color(value: string | null | undefined) {
    this._color.set(value || '#6B6B70');
  }
  private _color = signal('#6B6B70');

  bgColor = computed(() => this.hexToRgba(this._color(), 0.14));
  textColor = computed(() => this._color());

  private hexToRgba(hex: string, alpha: number): string {
    const sanitized = hex.replace('#', '');
    const bigint = parseInt(sanitized.length === 3
      ? sanitized.split('').map(c => c + c).join('')
      : sanitized, 16);

    if (isNaN(bigint)) {
      return `rgba(107, 107, 112, ${alpha})`;
    }

    const r = (bigint >> 16) & 255;
    const g = (bigint >> 8) & 255;
    const b = bigint & 255;

    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}
