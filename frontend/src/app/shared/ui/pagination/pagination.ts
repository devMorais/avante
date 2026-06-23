import { Component, Input, Output, EventEmitter, computed, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-pagination',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './pagination.html',
  styleUrl: './pagination.scss'
})
export class Pagination {
  @Input() currentPage = 1;
  @Input() lastPage = 1;
  @Input() total = 0;
  @Input() perPage = 25;
  @Input() from = 1;
  @Input() to = 25;

  @Output() pageChange = new EventEmitter<number>();
  @Output() perPageChange = new EventEmitter<number>();

  perPageOptions = [10, 15, 25, 50];

  get pages(): (number | '...')[] {
    const total = this.lastPage;
    const current = this.currentPage;

    if (total <= 7) {
      return Array.from({ length: total }, (_, i) => i + 1);
    }

    const pages: (number | '...')[] = [1];

    if (current > 3) pages.push('...');

    const start = Math.max(2, current - 1);
    const end = Math.min(total - 1, current + 1);

    for (let i = start; i <= end; i++) pages.push(i);

    if (current < total - 2) pages.push('...');

    pages.push(total);

    return pages;
  }

  goTo(page: number | '...') {
    if (page === '...' || page === this.currentPage) return;
    if (page < 1 || page > this.lastPage) return;
    this.pageChange.emit(page);
  }

  prev() {
    if (this.currentPage > 1) this.pageChange.emit(this.currentPage - 1);
  }

  next() {
    if (this.currentPage < this.lastPage) this.pageChange.emit(this.currentPage + 1);
  }

  onPerPageChange(value: string) {
    this.perPageChange.emit(Number(value));
  }

  isNumber(p: number | '...'): boolean {
    return typeof p === 'number';
  }
}
