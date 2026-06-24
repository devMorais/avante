import { Component, EventEmitter, Input, Output, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { Modal } from '../../shared/ui/modal/modal';
import { Button } from '../../shared/ui/button/button';
import { Avatar } from '../../shared/ui/avatar/avatar';
import { ApiService } from '../../services/api';

export interface TaskFormValue {
  description: string;
  status_id: number | null;
  priority: string;
  sprint_id: number | null;
}

const PRIORITIES = ['Baixa', 'Média', 'Alta', 'Urgente'];

const MOTIVATIONAL = [
  '🔥 Nota salva! O conhecimento é a sua maior arma.',
  '📚 Anotações são o mapa do seu progresso.',
  '✅ Salvo! Cada nota é um passo para a aprovação.',
  '💡 Ótimo registro! Revisitar é essencial.',
  '🚀 Notas salvas! Continue assim.',
];

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

  // Notes
  taskNotes = '';
  notesSaved = false;
  notesSaveMsg = '';
  savingNotes = false;

  // Images (base64, localStorage)
  noteImages: { id: string; data: string; name: string }[] = [];
  viewingImage: { data: string; name: string } | null = null;
  imageUploading = false;

  // Timer
  taskStartedAt: Date | null = null;
  timerInterval: any = null;
  elapsedStr = '';

  constructor(private apiService: ApiService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isOpen']?.currentValue === true) {
      this.resetForm();
    }
    if (changes['isOpen']?.currentValue === false) {
      this.stopTimer();
    }
  }

  private resetForm() {
    this.activeTab = 'details';
    this.notesSaved = false;
    this.notesSaveMsg = '';
    this.viewingImage = null;

    if (this.mode === 'edit' && this.task) {
      this.formDescription = this.task.description ?? '';
      this.formStatusId = this.task.status_id;
      this.formPriority = this.task.priority ?? 'Média';
      this.formSprintId = this.task.sprint_id;
      // Notes: prefer backend, fallback localStorage
      this.taskNotes = this.task.notes ?? this.loadLocalNotes(this.task.id);
      this.noteImages = this.loadImages(this.task.id);
      this.startTimer(this.task.id);
    } else {
      this.formDescription = '';
      this.formStatusId = this.statuses[0]?.id ?? null;
      this.formPriority = 'Média';
      this.formSprintId = null;
      this.taskNotes = '';
      this.noteImages = [];
      this.stopTimer();
    }

    this.commentContent = '';
  }

  // -------- Notes: local helpers --------

  private loadLocalNotes(taskId: number): string {
    try { return localStorage.getItem(`avante-note-${taskId}`) ?? ''; } catch { return ''; }
  }

  private saveLocalNotes(taskId: number, text: string) {
    try {
      if (text.trim()) localStorage.setItem(`avante-note-${taskId}`, text);
      else localStorage.removeItem(`avante-note-${taskId}`);
    } catch {}
  }

  saveNotes() {
    if (!this.task?.id) return;
    this.savingNotes = true;
    // Save to backend
    this.apiService.updateTask(this.task.id, { notes: this.taskNotes }).subscribe({
      next: (updated) => {
        if (this.task) this.task.notes = updated.notes;
        this.saveLocalNotes(this.task.id, this.taskNotes);
        this.notesSaved = true;
        this.notesSaveMsg = MOTIVATIONAL[Math.floor(Math.random() * MOTIVATIONAL.length)];
        this.savingNotes = false;
        setTimeout(() => { this.notesSaved = false; this.notesSaveMsg = ''; }, 3000);
      },
      error: () => {
        // Fallback to localStorage only
        this.saveLocalNotes(this.task.id, this.taskNotes);
        this.notesSaved = true;
        this.notesSaveMsg = '📝 Salvo localmente!';
        this.savingNotes = false;
        setTimeout(() => { this.notesSaved = false; this.notesSaveMsg = ''; }, 2000);
      }
    });
  }

  onNotesBlur() {
    if (this.task?.id) this.saveLocalNotes(this.task.id, this.taskNotes);
  }

  // -------- Images --------

  private loadImages(taskId: number): { id: string; data: string; name: string }[] {
    try {
      const raw = localStorage.getItem(`avante-imgs-${taskId}`);
      return raw ? JSON.parse(raw) : [];
    } catch { return []; }
  }

  private persistImages(taskId: number) {
    try {
      localStorage.setItem(`avante-imgs-${taskId}`, JSON.stringify(this.noteImages));
    } catch {
      alert('Armazenamento local cheio. Exclua imagens antigas para adicionar novas.');
    }
  }

  onImageUpload(event: Event) {
    const input = event.target as HTMLInputElement;
    if (!input.files?.length || !this.task?.id) return;

    const files = Array.from(input.files).slice(0, 5 - this.noteImages.length);
    this.imageUploading = true;
    let loaded = 0;

    for (const file of files) {
      if (!file.type.startsWith('image/')) { loaded++; continue; }
      const reader = new FileReader();
      reader.onload = (e) => {
        const data = e.target?.result as string;
        this.noteImages = [...this.noteImages, {
          id: `${Date.now()}-${Math.random().toString(36).slice(2)}`,
          data,
          name: file.name,
        }];
        loaded++;
        if (loaded === files.length) {
          this.persistImages(this.task.id);
          this.imageUploading = false;
        }
      };
      reader.readAsDataURL(file);
    }

    input.value = '';
  }

  deleteImage(id: string) {
    this.noteImages = this.noteImages.filter(img => img.id !== id);
    if (this.task?.id) this.persistImages(this.task.id);
  }

  openImageViewer(img: { data: string; name: string }) {
    this.viewingImage = img;
  }

  closeImageViewer() { this.viewingImage = null; }

  // -------- Timer --------

  private startTimer(taskId: number) {
    this.stopTimer();
    const key = `avante-started-${taskId}`;
    let stored = localStorage.getItem(key);
    if (!stored) {
      stored = new Date().toISOString();
      localStorage.setItem(key, stored);
    }
    this.taskStartedAt = new Date(stored);
    this.updateElapsed();
    this.timerInterval = setInterval(() => this.updateElapsed(), 60000);
  }

  private stopTimer() {
    if (this.timerInterval) { clearInterval(this.timerInterval); this.timerInterval = null; }
    this.taskStartedAt = null;
    this.elapsedStr = '';
  }

  private updateElapsed() {
    if (!this.taskStartedAt) return;
    const ms = Date.now() - this.taskStartedAt.getTime();
    const mins = Math.floor(ms / 60000);
    const hours = Math.floor(mins / 60);
    const days = Math.floor(hours / 24);
    if (days > 0) this.elapsedStr = `${days}d ${hours % 24}h`;
    else if (hours > 0) this.elapsedStr = `${hours}h ${mins % 60}m`;
    else if (mins > 0) this.elapsedStr = `${mins}min`;
    else this.elapsedStr = 'agora';
  }

  get timerDisplay(): string { return this.elapsedStr ? `⏱ ${this.elapsedStr} nesta demanda` : ''; }

  // -------- Export PDF --------

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
    const elapsed = this.elapsedStr ? `Tempo nesta demanda: ${this.elapsedStr}` : '';

    const imagesHtml = this.noteImages.map(img =>
      `<div class="img-wrap"><img src="${img.data}" alt="${this.escapeHtml(img.name)}" /></div>`
    ).join('');

    const win = window.open('', '_blank', 'width=820,height=700');
    if (!win) return;

    win.document.write(`<!DOCTYPE html>
<html lang="pt-BR"><head><meta charset="UTF-8"><title>${this.escapeHtml(title)}</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; color: #1C1C1F; background: #fff; padding: 40px 48px; line-height: 1.6; }
.brand { font-size: 11px; font-weight: 700; letter-spacing: .08em; text-transform: uppercase; color: #4F46E5; margin-bottom: 24px; }
h1 { font-size: 20px; font-weight: 700; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #E8E6E1; line-height: 1.4; }
.meta { display: flex; gap: 24px; flex-wrap: wrap; margin-bottom: 28px; }
.meta-item { display: flex; flex-direction: column; gap: 3px; }
.meta-label { font-size: 10px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #6B6B70; }
.meta-value { font-size: 13px; font-weight: 600; }
.section-title { font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #6B6B70; margin: 24px 0 10px; }
.description { background: #FAFAF8; border: 1px solid #E8E6E1; border-radius: 10px; padding: 16px 18px; white-space: pre-wrap; word-break: break-word; }
.notes-box { background: #FFFBEB; border: 1px solid #FDE68A; border-radius: 10px; padding: 16px 18px; white-space: pre-wrap; word-break: break-word; }
.images-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; margin-top: 8px; }
.img-wrap img { width: 100%; border-radius: 8px; border: 1px solid #E8E6E1; }
.footer { margin-top: 40px; padding-top: 16px; border-top: 1px solid #E8E6E1; font-size: 11px; color: #6B6B70; }
@media print { body { padding: 20px 28px; } }
</style></head><body>
<div class="brand">Avante — Gestão de Tarefas</div>
<h1>${this.escapeHtml(title)}</h1>
<div class="meta">
  <div class="meta-item"><span class="meta-label">Status</span><span class="meta-value">${this.escapeHtml(status)}</span></div>
  <div class="meta-item"><span class="meta-label">Prioridade</span><span class="meta-value">${this.escapeHtml(priority)}</span></div>
  <div class="meta-item"><span class="meta-label">Sprint</span><span class="meta-value">${this.escapeHtml(sprintName)}</span></div>
  ${elapsed ? `<div class="meta-item"><span class="meta-label">Tempo</span><span class="meta-value">${this.escapeHtml(elapsed)}</span></div>` : ''}
</div>
<div class="section-title">História / Descrição</div>
<div class="description">${this.escapeHtml(task.description ?? '')}</div>
${notes.trim() ? `<div class="section-title">Minhas Anotações</div><div class="notes-box">${this.escapeHtml(notes)}</div>` : ''}
${imagesHtml ? `<div class="section-title">Imagens / Fotos do Caderno</div><div class="images-grid">${imagesHtml}</div>` : ''}
<div class="footer">Exportado em ${now} · Avante</div>
<script>window.onload = function() { window.print(); }<\/script>
</body></html>`);
    win.document.close();
  }

  private escapeHtml(str: string): string {
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
  }

  onClose() { this.closeDialog.emit(); }

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
    this.addComment.emit({ content: this.commentContent.trim() });
    this.commentContent = '';
  }

  onDeleteComment(id: number) { this.removeComment.emit(id); }
  onManageAssignees() { this.manageAssignees.emit(); }

  get wordCount(): number {
    return this.formDescription.trim() ? this.formDescription.trim().split(/\s+/).length : 0;
  }
  get charCount(): number { return this.formDescription.length; }
}
