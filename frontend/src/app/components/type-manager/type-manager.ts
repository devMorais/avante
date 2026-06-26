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
  selector: 'app-type-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, DragDropModule, Button, Modal, ConfirmDialog],
  templateUrl: './type-manager.html',
  styleUrl: './type-manager.scss'
})
export class TypeManager implements OnInit {
  @Input() boardId!: number;
  @Output() typesChanged = new EventEmitter<void>();

  types = signal<any[]>([]);
  loading = signal(true);
  saving = signal(false);
  reordering = signal(false);

  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingType: any = null;

  form = { name: '', color: '#4F46E5', order: 0 };

  deleteDialogOpen = signal(false);
  typePendingDelete: any = null;
  deleting = signal(false);

  readonly presetColors = PRESET_COLORS;

  constructor(private apiService: ApiService) { }

  ngOnInit(): void { this.loadTypes(); }

  loadTypes() {
    this.loading.set(true);
    this.apiService.getTaskTypes(this.boardId).subscribe({
      next: (data) => { this.types.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  drop(event: CdkDragDrop<any[]>) {
    const list = [...this.types()];
    moveItemInArray(list, event.previousIndex, event.currentIndex);
    this.types.set(list);
    this.persistOrder(list);
  }

  persistOrder(list: any[]) {
    this.reordering.set(true);
    const items = list.map((s, i) => ({ id: s.id, order: i }));
    this.apiService.reorderTaskTypes(items).subscribe({
      next: () => {
        this.reordering.set(false);
        this.types.set(list.map((s, i) => ({ ...s, order: i })));
        this.typesChanged.emit();
      },
      error: () => { this.reordering.set(false); this.loadTypes(); }
    });
  }

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingType = null;
    const maxOrder = this.types().length > 0
      ? Math.max(...this.types().map(s => s.order ?? 0)) + 1
      : 0;
    this.form = { name: '', color: '#4F46E5', order: maxOrder };
    this.dialogOpen.set(true);
  }

  openEditDialog(type: any) {
    this.dialogMode = 'edit';
    this.editingType = type;
    this.form = { name: type.name, color: type.color ?? '#6B6B70', order: type.order ?? 0 };
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

    const req$ = this.dialogMode === 'edit' && this.editingType
      ? this.apiService.updateTaskType(this.editingType.id, payload)
      : this.apiService.createTaskType(payload);

    req$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadTypes();
        this.typesChanged.emit();
      },
      error: () => this.saving.set(false)
    });
  }

  askDelete(type: any) {
    this.typePendingDelete = type;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.typePendingDelete = null;
  }

  confirmDelete() {
    if (!this.typePendingDelete || this.deleting()) return;
    this.deleting.set(true);
    this.apiService.deleteTaskType(this.typePendingDelete.id).subscribe({
      next: () => {
        this.types.set(this.types().filter(s => s.id !== this.typePendingDelete.id));
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.typePendingDelete = null;
        this.typesChanged.emit();
      },
      error: () => this.deleting.set(false)
    });
  }

  selectColor(c: string) { this.form.color = c; }
}
