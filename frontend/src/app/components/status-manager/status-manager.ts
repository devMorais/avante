import { Component, Input, OnInit, signal, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

import { Button } from '../../shared/ui/button/button';
import { Modal } from '../../shared/ui/modal/modal';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';

@Component({
  selector: 'app-status-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, Button, Modal, ConfirmDialog],
  templateUrl: './status-manager.html',
  styleUrl: './status-manager.scss'
})
export class StatusManager implements OnInit {
  @Input() boardId!: number;
  @Output() statusesChanged = new EventEmitter<void>();

  statuses = signal<any[]>([]);
  loading = signal(true);

  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingStatus: any = null;
  saving = signal(false);

  form = { name: '', color: '#6B6B70' };

  deleteDialogOpen = signal(false);
  statusPendingDelete: any = null;
  deleting = signal(false);

  presetColors = [
    '#6B6B70', '#4F46E5', '#059669', '#0284C7',
    '#EA580C', '#DC2626', '#D97706', '#7C3AED'
  ];

  constructor(private apiService: ApiService) { }

  ngOnInit(): void {
    this.loadStatuses();
  }

  loadStatuses() {
    this.loading.set(true);
    this.apiService.getStatuses(this.boardId).subscribe({
      next: (data) => { this.statuses.set(data); this.loading.set(false); },
      error: (err) => { console.error('Erro ao carregar status:', err); this.loading.set(false); }
    });
  }

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingStatus = null;
    this.form = { name: '', color: '#6B6B70' };
    this.dialogOpen.set(true);
  }

  openEditDialog(status: any) {
    this.dialogMode = 'edit';
    this.editingStatus = status;
    this.form = { name: status.name, color: status.color };
    this.dialogOpen.set(true);
  }

  closeDialog() { this.dialogOpen.set(false); }

  confirmSave() {
    if (!this.form.name.trim() || this.saving()) return;
    this.saving.set(true);

    const payload = {
      board_id: this.boardId,
      name: this.form.name.trim(),
      color: this.form.color
    };

    const request$ = this.dialogMode === 'edit' && this.editingStatus
      ? this.apiService.updateStatus(this.editingStatus.id, payload)
      : this.apiService.createStatus(payload);

    request$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadStatuses();
        this.statusesChanged.emit();
      },
      error: (err) => { console.error('Erro ao salvar status:', err); this.saving.set(false); }
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
      error: (err) => { console.error('Erro ao excluir status:', err); this.deleting.set(false); }
    });
  }
}
