import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-button',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './button.html',
  styleUrl: './button.scss',
})
export class Button {
  @Input() variant: 'primary' | 'text' | 'danger' = 'primary';
  @Input() disabled = false;
  @Input() type: 'button' | 'submit' = 'button';
  @Output() clicked = new EventEmitter<Event>();

  onClick(event: Event) {
    if (this.disabled) return;
    this.clicked.emit(event);
  }
}
