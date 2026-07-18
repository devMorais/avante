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
  selector: 'app-priority-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, DragDropModule, Button, Modal, ConfirmDialog],
  templateUrl: './priority-manager.html',
  styleUrl: './priority-manager.scss'
})
export class PriorityManager implements OnInit {
  @Input() boardId!: number;
  @Output() prioritiesChanged = new EventEmitter<void>();

  // Prioridades de programação e de marketing são conjuntos separados —
  // a sub-navegação troca qual conjunto é exibido/editado aqui.
  area = signal<'programming' | 'marketing'>('programming');

  priorities = signal<any[]>([]);
  loading = signal(true);
  saving = signal(false);
  reordering = signal(false);

  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingPriority: any = null;

  form = { name: '', color: '#4F46E5', order: 0 };

  deleteDialogOpen = signal(false);
  priorityPendingDelete: any = null;
  deleting = signal(false);

  readonly presetColors = PRESET_COLORS;

  constructor(private apiService: ApiService) { }

  ngOnInit(): void { this.loadPriorities(); }

  setArea(a: 'programming' | 'marketing') {
    if (this.area() === a) return;
    this.area.set(a);
    this.loadPriorities();
  }

  loadPriorities() {
    this.loading.set(true);
    this.apiService.getPriorities(this.boardId, this.area()).subscribe({
      next: (data) => { this.priorities.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  // ---------- Drag-and-drop ----------

  drop(event: CdkDragDrop<any[]>) {
    const list = [...this.priorities()];
    moveItemInArray(list, event.previousIndex, event.currentIndex);
    this.priorities.set(list);
    this.persistOrder(list);
  }

  persistOrder(list: any[]) {
    this.reordering.set(true);
    const items = list.map((s, i) => ({ id: s.id, order: i }));
    this.apiService.reorderPriorities(items).subscribe({
      next: () => {
        this.reordering.set(false);
        this.priorities.set(list.map((s, i) => ({ ...s, order: i })));
        this.prioritiesChanged.emit();
      },
      error: () => { this.reordering.set(false); this.loadPriorities(); }
    });
  }

  // ---------- CRUD ----------

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingPriority = null;
    const maxOrder = this.priorities().length > 0
      ? Math.max(...this.priorities().map(s => s.order ?? 0)) + 1
      : 0;
    this.form = { name: '', color: '#4F46E5', order: maxOrder };
    this.dialogOpen.set(true);
  }

  openEditDialog(priority: any) {
    this.dialogMode = 'edit';
    this.editingPriority = priority;
    this.form = { name: priority.name, color: priority.color ?? '#6B6B70', order: priority.order ?? 0 };
    this.dialogOpen.set(true);
  }

  closeDialog() { this.dialogOpen.set(false); }

  confirmSave() {
    if (!this.form.name.trim() || this.saving()) return;
    this.saving.set(true);

    const isEdit = this.dialogMode === 'edit' && this.editingPriority;
    const payload: any = {
      board_id: this.boardId,
      name: this.form.name.trim(),
      color: this.form.color || '#6B6B70',
      order: Number(this.form.order),
    };
    if (!isEdit) payload.area = this.area();

    const req$ = isEdit
      ? this.apiService.updatePriority(this.editingPriority.id, payload)
      : this.apiService.createPriority(payload);

    req$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadPriorities();
        this.prioritiesChanged.emit();
      },
      error: () => this.saving.set(false)
    });
  }

  askDelete(priority: any) {
    this.priorityPendingDelete = priority;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.priorityPendingDelete = null;
  }

  confirmDelete() {
    if (!this.priorityPendingDelete || this.deleting()) return;
    this.deleting.set(true);
    this.apiService.deletePriority(this.priorityPendingDelete.id).subscribe({
      next: () => {
        this.priorities.set(this.priorities().filter(s => s.id !== this.priorityPendingDelete.id));
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.priorityPendingDelete = null;
        this.prioritiesChanged.emit();
      },
      error: () => this.deleting.set(false)
    });
  }

  selectColor(c: string) { this.form.color = c; }
}
