import {
  Directive, ElementRef, HostListener, Input, OnDestroy, Renderer2
} from '@angular/core';

type Placement = 'top' | 'bottom' | 'left' | 'right';

/**
 * Tooltip flutuante profissional.
 * Uso: <button appTooltip="Texto" tooltipPlacement="top">
 * Renderiza no <body> para não sofrer clipping de overflow.
 */
@Directive({
  selector: '[appTooltip]',
  standalone: true,
})
export class TooltipDirective implements OnDestroy {
  @Input('appTooltip') text = '';
  @Input() tooltipPlacement: Placement = 'top';

  private tip?: HTMLElement;
  private showTimer: any = null;

  constructor(private host: ElementRef<HTMLElement>, private r: Renderer2) {}

  @HostListener('mouseenter') onEnter() {
    this.showTimer = setTimeout(() => this.show(), 350);
  }
  @HostListener('mouseleave') onLeave() { this.hide(); }
  @HostListener('click') onClick() { this.hide(); }
  @HostListener('window:scroll') onScroll() { this.hide(); }
  ngOnDestroy() { this.hide(); }

  private show() {
    if (!this.text || this.tip) return;

    const tip = this.r.createElement('div') as HTMLElement;
    this.r.addClass(tip, 'app-tooltip');
    const label = this.r.createElement('span');
    this.r.setProperty(label, 'textContent', this.text);
    this.r.appendChild(tip, label);
    const arrow = this.r.createElement('span');
    this.r.addClass(arrow, 'app-tooltip__arrow');
    this.r.appendChild(tip, arrow);
    this.r.appendChild(document.body, tip);
    this.tip = tip;

    // Posicionamento com flip se faltar espaço
    const hostRect = this.host.nativeElement.getBoundingClientRect();
    const tipRect = tip.getBoundingClientRect();
    const gap = 8;
    let placement = this.tooltipPlacement;

    if (placement === 'top' && hostRect.top - tipRect.height - gap < 0) placement = 'bottom';
    else if (placement === 'bottom' && hostRect.bottom + tipRect.height + gap > window.innerHeight) placement = 'top';

    let top = 0, left = 0;
    let arrowLeft = '50%', arrowTop = '';
    switch (placement) {
      case 'top':
        top = hostRect.top - tipRect.height - gap;
        left = hostRect.left + hostRect.width / 2 - tipRect.width / 2;
        this.r.addClass(tip, 'app-tooltip--top');
        break;
      case 'bottom':
        top = hostRect.bottom + gap;
        left = hostRect.left + hostRect.width / 2 - tipRect.width / 2;
        this.r.addClass(tip, 'app-tooltip--bottom');
        break;
      case 'left':
        top = hostRect.top + hostRect.height / 2 - tipRect.height / 2;
        left = hostRect.left - tipRect.width - gap;
        this.r.addClass(tip, 'app-tooltip--left');
        break;
      case 'right':
        top = hostRect.top + hostRect.height / 2 - tipRect.height / 2;
        left = hostRect.right + gap;
        this.r.addClass(tip, 'app-tooltip--right');
        break;
    }

    // Clamp horizontal + reposiciona a setinha para o centro do host
    const margin = 6;
    const desiredLeft = left;
    if (left < margin) left = margin;
    if (left + tipRect.width > window.innerWidth - margin) left = window.innerWidth - tipRect.width - margin;
    if (placement === 'top' || placement === 'bottom') {
      const hostCenter = hostRect.left + hostRect.width / 2;
      arrowLeft = `${Math.max(10, Math.min(tipRect.width - 10, hostCenter - left))}px`;
      this.r.setStyle(arrow, 'left', arrowLeft);
    }

    this.r.setStyle(tip, 'top', `${Math.round(top)}px`);
    this.r.setStyle(tip, 'left', `${Math.round(left)}px`);
    // trigger fade-in
    requestAnimationFrame(() => { if (this.tip) this.r.addClass(this.tip, 'app-tooltip--visible'); });
  }

  private hide() {
    if (this.showTimer) { clearTimeout(this.showTimer); this.showTimer = null; }
    if (this.tip) {
      this.r.removeChild(document.body, this.tip);
      this.tip = undefined;
    }
  }
}
