import {
  Component,
  ElementRef,
  HostListener,
  signal
} from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-popover',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './popover.html',
  styleUrl: './popover.scss',
})
export class Popover {
  open = signal(false);

  constructor(private elementRef: ElementRef) { }

  toggle(event?: Event) {
    event?.stopPropagation();
    this.open.set(!this.open());
  }

  close() {
    this.open.set(false);
  }

  // Fecha o popover se o clique for fora do componente
  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    if (!this.elementRef.nativeElement.contains(event.target)) {
      this.open.set(false);
    }
  }
}
