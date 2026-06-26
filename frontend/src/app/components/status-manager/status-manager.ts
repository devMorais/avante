import { Component, Input, OnInit, signal, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CdkDragDrop, DragDropModule, moveItemInArray } from '@angular/cdk/drag-drop';
import { ApiService } from '../../services/api';
import { Button } from '../../shared/ui/button/button';
import { Modal } from '../../shared/ui/modal/modal';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';

const PRESET_COLORS = [
  '#6B6B70', '#4F46E5', '#0284C7', '#059669',
  '#D97706', '#DC2626', '#7C3AED', '#DB2777',
  '#0891B2', '#16A34A', '#EA580C', '#9333EA',
];

@Component({
  selector: 'app-status-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, DragDropModule, Button, Modal, ConfirmDialog],
  templateUrl: './status-manager.html',
  styleUrl: './status-manager.scss'
})
export class StatusManager implements OnInit {
  @Input() boardId!: number;
  @Output() statusesChanged = new EventEmitter<void>();

  statuses = signal<any[]>([]);
  loading = signal(true);
  saving = signal(false);
  reordering = signal(false);

  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingStatus: any = null;

  form = { name: '', color: '#4F46E5', order: 0 };

  deleteDialogOpen = signal(false);
  statusPendingDelete: any = null;
  deleting = signal(false);

  readonly presetColors = PRESET_COLORS;

  constructor(private apiService: ApiService) { }

  ngOnInit(): void { this.loadStatuses(); }

  loadStatuses() {
    this.loading.set(true);
    this.apiService.getStatuses(this.boardId).subscribe({
      next: (data) => { this.statuses.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  // ---------- Drag-and-drop ----------

  drop(event: CdkDragDrop<any[]>) {
    const list = [...this.statuses()];
    moveItemInArray(list, event.previousIndex, event.currentIndex);
    this.statuses.set(list);
    this.persistOrder(list);
  }

  persistOrder(list: any[]) {
    this.reordering.set(true);
    const items = list.map((s, i) => ({ id: s.id, order: i }));
    this.apiService.reorderStatuses(items).subscribe({
      next: () => {
        this.reordering.set(false);
        this.statuses.set(list.map((s, i) => ({ ...s, order: i })));
        this.statusesChanged.emit();
      },
      error: () => { this.reordering.set(false); this.loadStatuses(); }
    });
  }

  // ---------- CRUD ----------

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingStatus = null;
    const maxOrder = this.statuses().length > 0
      ? Math.max(...this.statuses().map(s => s.order ?? 0)) + 1
      : 0;
    this.form = { name: '', color: '#4F46E5', order: maxOrder };
    this.dialogOpen.set(true);
  }

  openEditDialog(status: any) {
    this.dialogMode = 'edit';
    this.editingStatus = status;
    this.form = { name: status.name, color: status.color ?? '#6B6B70', order: status.order ?? 0 };
    this.dialogOpen.set(true);
  }

  closeDialog() { this.dialogOpen.set(false); }

  confirmSave() {
    if (!this.form.name.trim() || this.saving()) return;
    this.saving.set(true);

    const payload = {
      board_id: this.boardId,
      name: this.form.name.trim(),
      color: this.form.color || '#6B6B70',
      order: Number(this.form.order),
    };

    const req$ = this.dialogMode === 'edit' && this.editingStatus
      ? this.apiService.updateStatus(this.editingStatus.id, payload)
      : this.apiService.createStatus(payload);

    req$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadStatuses();
        this.statusesChanged.emit();
      },
      error: () => this.saving.set(false)
    });
  }

  askDelete(status: any) {
    this.statusPendingDelete = status;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.statusPendingDelete = null;
  }

  confirmDelete() {
    if (!this.statusPendingDelete || this.deleting()) return;
    this.deleting.set(true);
    this.apiService.deleteStatus(this.statusPendingDelete.id).subscribe({
      next: () => {
        this.statuses.set(this.statuses().filter(s => s.id !== this.statusPendingDelete.id));
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.statusPendingDelete = null;
        this.statusesChanged.emit();
      },
      error: () => this.deleting.set(false)
    });
  }

  selectColor(c: string) { this.form.color = c; }
}
