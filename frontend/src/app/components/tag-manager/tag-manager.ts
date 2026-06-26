import { Component, Input, Output, EventEmitter, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';
import { Button } from '../../shared/ui/button/button';
import { Modal } from '../../shared/ui/modal/modal';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';

@Component({
  selector: 'app-tag-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, Button, Modal, ConfirmDialog],
  templateUrl: './tag-manager.html',
  styleUrl: './tag-manager.scss'
})
export class TagManagerComponent implements OnInit {
  @Input() boardId!: number;
  @Output() tagsChanged = new EventEmitter<void>();

  tags = signal<any[]>([]);
  loading = signal(true);
  saving = signal(false);
  deleting = signal(false);
  reordering = signal(false);

  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingTag: any = null;
  deleteDialogOpen = signal(false);
  tagPendingDelete: any = null;

  form = { name: '', color: '#4F46E5' };

  readonly presetColors = [
    '#6B6B70', '#4F46E5', '#0284C7', '#059669',
    '#D97706', '#DC2626', '#7C3AED', '#DB2777',
    '#0891B2', '#16A34A', '#EA580C', '#9333EA'
  ];

  constructor(private apiService: ApiService) { }

  ngOnInit() { this.loadTags(); }

  loadTags() {
    this.loading.set(true);
    this.apiService.getTags(this.boardId).subscribe({
      next: (data: any[]) => { this.tags.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingTag = null;
    this.form = { name: '', color: '#4F46E5' };
    this.dialogOpen.set(true);
  }

  openEditDialog(tag: any) {
    this.dialogMode = 'edit';
    this.editingTag = tag;
    this.form = { name: tag.name, color: tag.color || '#4F46E5' };
    this.dialogOpen.set(true);
  }

  closeDialog() { this.dialogOpen.set(false); }

  selectColor(c: string) { this.form.color = c; }

  confirmSave() {
    if (!this.form.name.trim()) return;
    this.saving.set(true);
    const obs = this.dialogMode === 'create'
      ? this.apiService.createTag({ board_id: this.boardId, name: this.form.name.trim(), color: this.form.color })
      : this.apiService.updateTag(this.editingTag.id, { name: this.form.name.trim(), color: this.form.color });

    obs.subscribe({
      next: () => {
        this.saving.set(false);
        this.closeDialog();
        this.loadTags();
        this.tagsChanged.emit();
      },
      error: () => this.saving.set(false)
    });
  }

  askDelete(tag: any) {
    this.tagPendingDelete = tag;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() { this.deleteDialogOpen.set(false); this.tagPendingDelete = null; }

  confirmDelete() {
    if (!this.tagPendingDelete) return;
    this.deleting.set(true);
    this.apiService.deleteTag(this.tagPendingDelete.id).subscribe({
      next: () => {
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.tagPendingDelete = null;
        this.loadTags();
        this.tagsChanged.emit();
      },
      error: () => this.deleting.set(false)
    });
  }
}
