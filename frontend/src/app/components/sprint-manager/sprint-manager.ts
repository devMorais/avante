import { Component, Input, OnInit, signal, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

import { Button } from '../../shared/ui/button/button';
import { Modal } from '../../shared/ui/modal/modal';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';

@Component({
  selector: 'app-sprint-manager',
  standalone: true,
  imports: [CommonModule, FormsModule, Button, Modal, ConfirmDialog],
  templateUrl: './sprint-manager.html',
  styleUrl: './sprint-manager.scss'
})
export class SprintManager implements OnInit {
  @Input() boardId!: number;
  @Output() sprintsChanged = new EventEmitter<void>();

  sprints = signal<any[]>([]);
  loading = signal(true);

  // ---------- Modal criar/editar ----------
  dialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingSprint: any = null;
  saving = signal(false);

  form = {
    name: '',
    start_date: '',
    end_date: '',
  };

  // ---------- Modal excluir ----------
  deleteDialogOpen = signal(false);
  sprintPendingDelete: any = null;
  deleting = signal(false);

  constructor(private apiService: ApiService) { }

  ngOnInit(): void {
    this.loadSprints();
  }

  loadSprints() {
    this.loading.set(true);
    this.apiService.getSprints(this.boardId).subscribe({
      next: (data) => {
        this.sprints.set(data);
        this.loading.set(false);
      },
      error: (err) => {
        console.error('Erro ao carregar sprints:', err);
        this.loading.set(false);
      }
    });
  }

  // ---------- Criar ----------

  openCreateDialog() {
    this.dialogMode = 'create';
    this.editingSprint = null;
    this.form = { name: '', start_date: '', end_date: '' };
    this.dialogOpen.set(true);
  }

  // ---------- Editar ----------

  openEditDialog(sprint: any) {
    this.dialogMode = 'edit';
    this.editingSprint = sprint;
    this.form = {
      name: sprint.name,
      start_date: sprint.start_date ?? '',
      end_date: sprint.end_date ?? '',
    };
    this.dialogOpen.set(true);
  }

  closeDialog() {
    this.dialogOpen.set(false);
  }

  confirmSave() {
    if (!this.form.name.trim() || this.saving()) return;

    this.saving.set(true);
    const payload = {
      board_id: this.boardId,
      name: this.form.name.trim(),
      start_date: this.form.start_date || null,
      end_date: this.form.end_date || null,
    };

    const request$ = this.dialogMode === 'edit' && this.editingSprint
      ? this.apiService.updateSprint(this.editingSprint.id, payload)
      : this.apiService.createSprint(payload);

    request$.subscribe({
      next: () => {
        this.saving.set(false);
        this.dialogOpen.set(false);
        this.loadSprints();
        this.sprintsChanged.emit();
      },
      error: (err) => {
        console.error('Erro ao salvar sprint:', err);
        this.saving.set(false);
      }
    });
  }

  // ---------- Excluir ----------

  askDelete(sprint: any) {
    this.sprintPendingDelete = sprint;
    this.deleteDialogOpen.set(true);
  }

  cancelDelete() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.sprintPendingDelete = null;
  }

  confirmDelete() {
    if (!this.sprintPendingDelete || this.deleting()) return;

    this.deleting.set(true);
    this.apiService.deleteSprint(this.sprintPendingDelete.id).subscribe({
      next: () => {
        this.sprints.set(this.sprints().filter(s => s.id !== this.sprintPendingDelete.id));
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.sprintPendingDelete = null;
        this.sprintsChanged.emit();
      },
      error: (err) => {
        console.error('Erro ao excluir sprint:', err);
        this.deleting.set(false);
      }
    });
  }

  formatDate(date: string | null): string {
    if (!date) return '—';
    const [year, month, day] = date.split('-');
    return `${day}/${month}/${year}`;
  }

  formatDateLong(date: string | null): string {
    if (!date) return '—';
    const d = new Date(date + 'T00:00:00');
    return d.toLocaleDateString('pt-BR', { day: 'numeric', month: 'short', year: 'numeric' });
  }

  isFinished(sprint: any): boolean { return !!sprint?.finished_at; }

  isOverdue(sprint: any): boolean {
    if (!sprint?.end_date || sprint?.finished_at) return false;
    return new Date(sprint.end_date) < new Date(new Date().toDateString());
  }

  isUpcoming(sprint: any): boolean {
    if (!sprint?.start_date || sprint?.finished_at) return false;
    return new Date(sprint.start_date) > new Date(new Date().toDateString());
  }

  isActive(sprint: any): boolean {
    return !this.isFinished(sprint) && !this.isOverdue(sprint) && !this.isUpcoming(sprint);
  }

  duration(sprint: any): number | null {
    if (!sprint?.start_date || !sprint?.end_date) return null;
    const start = new Date(sprint.start_date);
    const end = new Date(sprint.end_date);
    return Math.ceil((end.getTime() - start.getTime()) / 86400000) + 1;
  }

  daysRemaining(sprint: any): number | null {
    if (!sprint?.end_date || sprint?.finished_at) return null;
    const end = new Date(sprint.end_date);
    const today = new Date(new Date().toDateString());
    return Math.ceil((end.getTime() - today.getTime()) / 86400000);
  }

  daysOverdue(sprint: any): number | null {
    if (!this.isOverdue(sprint)) return null;
    const end = new Date(sprint.end_date);
    const today = new Date(new Date().toDateString());
    return Math.ceil((today.getTime() - end.getTime()) / 86400000);
  }

  timelineProgress(sprint: any): number {
    if (!sprint?.start_date || !sprint?.end_date) return 0;
    if (sprint?.finished_at) return 100;
    const start = new Date(sprint.start_date).getTime();
    const end = new Date(sprint.end_date).getTime();
    const now = Date.now();
    if (now <= start) return 0;
    if (now >= end) return 100;
    return Math.round(((now - start) / (end - start)) * 100);
  }

  statusLabel(sprint: any): string {
    if (this.isFinished(sprint)) return 'Finalizada';
    if (this.isOverdue(sprint)) return 'Vencida';
    if (this.isUpcoming(sprint)) return 'Agendada';
    return 'Ativa';
  }

  statusClass(sprint: any): string {
    if (this.isFinished(sprint)) return 'badge--finished';
    if (this.isOverdue(sprint)) return 'badge--overdue';
    if (this.isUpcoming(sprint)) return 'badge--upcoming';
    return 'badge--active';
  }
}
