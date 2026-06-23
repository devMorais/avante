import {
  Component,
  Input,
  Output,
  EventEmitter,
  HostListener
} from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-modal',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './modal.html',
  styleUrl: './modal.scss',
})
export class Modal {
  @Input() isOpen = false;
  @Input() width = '440px';
  @Output() closeModal = new EventEmitter<void>();

  requestClose() {
    this.closeModal.emit();
  }

  // Fecha com a tecla ESC, mas só se o modal estiver aberto
  @HostListener('document:keydown.escape')
  onEscape() {
    if (this.isOpen) {
      this.requestClose();
    }
  }
}
