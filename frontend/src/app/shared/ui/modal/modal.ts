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
  /** Quando false, não fecha por clique fora nem ESC (apenas via botão X). */
  @Input() dismissable = true;
  @Output() closeModal = new EventEmitter<void>();

  requestClose() {
    this.closeModal.emit();
  }

  onBackdropClick() {
    if (this.dismissable) this.requestClose();
  }

  // Fecha com ESC apenas quando dismissable
  @HostListener('document:keydown.escape')
  onEscape() {
    if (this.isOpen && this.dismissable) {
      this.requestClose();
    }
  }
}
