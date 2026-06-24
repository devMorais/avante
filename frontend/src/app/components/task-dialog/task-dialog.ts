import { Component, EventEmitter, Input, Output, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { Modal } from '../../shared/ui/modal/modal';
import { Button } from '../../shared/ui/button/button';
import { Avatar } from '../../shared/ui/avatar/avatar';

export interface TaskFormValue {
  description: string;
  status_id: number | null;
  priority: string;
  sprint_id: number | null;
}

const PRIORITIES = ['Baixa', 'Média', 'Alta', 'Urgente'];

@Component({
  selector: 'app-task-dialog',
  standalone: true,
  imports: [CommonModule, FormsModule, Modal, Button, Avatar],
  templateUrl: './task-dialog.html',
  styleUrl: './task-dialog.scss'
})
export class TaskDialog implements OnChanges {
  @Input() isOpen = false;
  @Input() mode: 'create' | 'edit' = 'create';
  @Input() task: any = null;
  @Input() statuses: any[] = [];
  @Input() sprints: any[] = [];
  @Input() saving = false;

  @Input() comments: any[] = [];
  @Input() savingComment = false;

  @Output() closeDialog = new EventEmitter<void>();
  @Output() save = new EventEmitter<TaskFormValue>();
  @Output() addComment = new EventEmitter<{ content: string }>();
  @Output() removeComment = new EventEmitter<number>();
  @Output() manageAssignees = new EventEmitter<void>();

  priorities = PRIORITIES;

  activeTab: 'details' | 'comments' | 'notes' = 'details';

  formDescription = '';
  formStatusId: number | null = null;
  formPriority = 'Média';
  formSprintId: number | null = null;

  commentContent = '';

  // Notes (stored in localStorage per task)
  taskNotes = '';
  notesSaved = false;

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isOpen']?.currentValue === true) {
      this.resetForm();
    }
  }

  private resetForm() {
    this.activeTab = 'details';
    this.notesSaved = false;

    if (this.mode === 'edit' && this.task) {
      this.formDescription = this.task.description ?? '';
      this.formStatusId = this.task.status_id;
      this.formPriority = this.task.priority ?? 'Média';
      this.formSprintId = this.task.sprint_id;
      this.taskNotes = this.loadNotes(this.task.id);
    } else {
      this.formDescription = '';
      this.formStatusId = this.statuses[0]?.id ?? null;
      this.formPriority = 'Média';
      this.formSprintId = null;
      this.taskNotes = '';
    }

    this.commentContent = '';
  }

  private loadNotes(taskId: number): string {
    try {
      return localStorage.getItem(`avante-note-${taskId}`) ?? '';
    } catch {
      return '';
    }
  }

  saveNotes() {
    if (!this.task?.id) return;
    try {
      if (this.taskNotes.trim()) {
        localStorage.setItem(`avante-note-${this.task.id}`, this.taskNotes);
      } else {
        localStorage.removeItem(`avante-note-${this.task.id}`);
      }
      this.notesSaved = true;
      setTimeout(() => { this.notesSaved = false; }, 2000);
    } catch {
      // localStorage not available
    }
  }

  exportPDF() {
    const task = this.task;
    if (!task) return;

    const title = (task.description ?? 'Tarefa').substring(0, 80);
    const status = task.status?.name ?? '—';
    const priority = task.priority ?? '—';
    const sprint = this.sprints.find(s => s.id === (task.sprint_id ?? this.formSprintId));
    const sprintName = sprint?.name ?? '—';
    const notes = this.taskNotes;
    const now = new Date().toLocaleString('pt-BR');

    const win = window.open('', '_blank', 'width=820,height=700');
    if (!win) return;

    win.document.write(`<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>${this.escapeHtml(title)}</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      font-size: 14px;
      color: #1C1C1F;
      background: #fff;
      padding: 40px 48px;
      line-height: 1.6;
    }
    .brand {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: #4F46E5;
      margin-bottom: 24px;
    }
    h1 {
      font-size: 20px;
      font-weight: 700;
      color: #1C1C1F;
      margin-bottom: 20px;
      line-height: 1.4;
      padding-bottom: 16px;
      border-bottom: 2px solid #E8E6E1;
    }
    .meta {
      display: flex;
      gap: 24px;
      flex-wrap: wrap;
      margin-bottom: 28px;
    }
    .meta-item {
      display: flex;
      flex-direction: column;
      gap: 3px;
    }
    .meta-label {
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      color: #6B6B70;
    }
    .meta-value {
      font-size: 13px;
      font-weight: 600;
      color: #1C1C1F;
    }
    .section-title {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      color: #6B6B70;
      margin-bottom: 10px;
      margin-top: 24px;
    }
    .description {
      background: #FAFAF8;
      border: 1px solid #E8E6E1;
      border-radius: 10px;
      padding: 16px 18px;
      font-size: 14px;
      color: #1C1C1F;
      white-space: pre-wrap;
      word-break: break-word;
    }
    .notes-box {
      background: #FFFBEB;
      border: 1px solid #FDE68A;
      border-radius: 10px;
      padding: 16px 18px;
      font-size: 14px;
      color: #1C1C1F;
      white-space: pre-wrap;
      word-break: break-word;
    }
    .footer {
      margin-top: 40px;
      padding-top: 16px;
      border-top: 1px solid #E8E6E1;
      font-size: 11px;
      color: #6B6B70;
    }
    @media print {
      body { padding: 20px 28px; }
    }
  </style>
</head>
<body>
  <div class="brand">Avante — Gestão de Tarefas</div>
  <h1>${this.escapeHtml(title)}</h1>
  <div class="meta">
    <div class="meta-item">
      <span class="meta-label">Status</span>
      <span class="meta-value">${this.escapeHtml(status)}</span>
    </div>
    <div class="meta-item">
      <span class="meta-label">Prioridade</span>
      <span class="meta-value">${this.escapeHtml(priority)}</span>
    </div>
    <div class="meta-item">
      <span class="meta-label">Sprint</span>
      <span class="meta-value">${this.escapeHtml(sprintName)}</span>
    </div>
  </div>
  <div class="section-title">História / Descrição</div>
  <div class="description">${this.escapeHtml(task.description ?? '')}</div>
  ${notes.trim() ? `
  <div class="section-title">Minhas Anotações</div>
  <div class="notes-box">${this.escapeHtml(notes)}</div>` : ''}
  <div class="footer">Exportado em ${now} · Avante</div>
  <script>window.onload = function() { window.print(); }<\/script>
</body>
</html>`);
    win.document.close();
  }

  private escapeHtml(str: string): string {
    return str
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  onClose() {
    this.closeDialog.emit();
  }

  onSave() {
    if (!this.formDescription.trim() || this.saving) return;

    this.save.emit({
      description: this.formDescription.trim(),
      status_id: this.formStatusId,
      priority: this.formPriority,
      sprint_id: this.formSprintId,
    });
  }

  onAddComment() {
    if (!this.commentContent.trim() || this.savingComment) return;

    this.addComment.emit({
      content: this.commentContent.trim(),
    });
    this.commentContent = '';
  }

  onDeleteComment(id: number) {
    this.removeComment.emit(id);
  }

  onManageAssignees() {
    this.manageAssignees.emit();
  }

  get wordCount(): number {
    return this.formDescription.trim() ? this.formDescription.trim().split(/\s+/).length : 0;
  }

  get charCount(): number {
    return this.formDescription.length;
  }
}
