import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

export interface ConstructionFeature {
  title: string;
  desc: string;
  icon: string; // chave do ícone (ver template)
}

/**
 * Página "em construção" profissional, reutilizável.
 * Mostra um herói com o que está por vir e um grid de funcionalidades planejadas.
 */
@Component({
  selector: 'app-construction',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './construction.html',
  styleUrl: './construction.scss'
})
export class ConstructionComponent {
  @Input() title = 'Em construção';
  @Input() subtitle = 'Estamos preparando algo especial para você.';
  @Input() accent = '#4F46E5';
  @Input() features: ConstructionFeature[] = [];
}
