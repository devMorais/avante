import {
  Component,
  EventEmitter,
  HostListener,
  Input,
  Output,
  OnChanges,
  SimpleChanges,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

import { Modal } from '../../shared/ui/modal/modal';
import { Button } from '../../shared/ui/button/button';
import { Avatar } from '../../shared/ui/avatar/avatar';
import { ApiService } from '../../services/api';

export interface TaskFormValue {
  description: string;
  status_id: number | null;
  priority: string;
  sprint_id: number | null;
  epic: string | null;
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
  styleUrl: './task-dialog.scss',
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
  formEpic = '';
  commentContent = '';

  // Notes core
  taskNotes = '';
  notesSaved = false;
  notesSaveMsg = '';
  savingNotes = false;

  // Notes editor state
  isFullscreen = false;
  previewMode = false;
  noteFont: 'inter' | 'mono' | 'lora' = 'inter';
  private _renderedNotes: SafeHtml = '';
  get renderedNotes(): SafeHtml { return this._renderedNotes; }

  // Images (base64, localStorage)
  noteImages: { id: string; data: string; name: string }[] = [];
  viewingImage: { data: string; name: string } | null = null;
  imageUploading = false;

  // Timer
  taskStartedAt: Date | null = null;
  timerInterval: any = null;
  elapsedStr = '';

  constructor(private apiService: ApiService, private sanitizer: DomSanitizer) {}

  // Intercept ESC before the Modal's own listener when in fullscreen
  @HostListener('document:keydown', ['$event'])
  onDocKeydown(event: KeyboardEvent) {
    if (event.key === 'Escape' && this.isFullscreen) {
      event.stopImmediatePropagation();
      this.isFullscreen = false;
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isOpen']?.currentValue === true) {
      this.resetForm();
    }
    if (changes['isOpen']?.currentValue === false) {
      this.stopTimer();
      this.isFullscreen = false;
      this.previewMode = false;
    }
  }

  private resetForm() {
    this.activeTab = 'details';
    this.notesSaved = false;
    this.notesSaveMsg = '';
    this.viewingImage = null;
    this.isFullscreen = false;
    this.previewMode = false;

    if (this.mode === 'edit' && this.task) {
      this.formDescription = this.task.description ?? '';
      this.formStatusId = this.task.status_id;
      this.formPriority = this.task.priority ?? 'Média';
      this.formSprintId = this.task.sprint_id;
      this.formEpic = this.task.epic ?? '';
      this.taskNotes = this.task.notes ?? this.loadLocalNotes(this.task.id);
      this.noteImages = this.loadImages(this.task.id);
      this.startTimer(this.task.id);
    } else {
      this.formDescription = '';
      this.formStatusId = this.statuses[0]?.id ?? null;
      this.formPriority = 'Média';
      this.formSprintId = null;
      this.formEpic = '';
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
        this.saveLocalNotes(this.task.id, this.taskNotes);
        this.notesSaved = true;
        this.notesSaveMsg = '📝 Salvo localmente!';
        this.savingNotes = false;
        setTimeout(() => { this.notesSaved = false; this.notesSaveMsg = ''; }, 2000);
      },
    });
  }

  onNotesBlur() {
    if (this.task?.id) this.saveLocalNotes(this.task.id, this.taskNotes);
  }

  onNotesChange() {
    if (this.previewMode) this.updateRendered();
  }

  // -------- Editor: fullscreen + preview --------

  toggleFullscreen() { this.isFullscreen = !this.isFullscreen; }

  togglePreview() {
    this.previewMode = !this.previewMode;
    if (this.previewMode) this.updateRendered();
  }

  private updateRendered() {
    this._renderedNotes = this.sanitizer.bypassSecurityTrustHtml(
      this.renderMarkdown(this.taskNotes)
    );
  }

  // -------- Editor: toolbar + keyboard --------

  onNotesKeydown(event: KeyboardEvent) {
    if (event.ctrlKey || event.metaKey) {
      switch (event.key.toLowerCase()) {
        case 'b': event.preventDefault(); this.insertFormat('bold'); return;
        case 'i': event.preventDefault(); this.insertFormat('italic'); return;
        case 'k': event.preventDefault(); this.insertFormat('code'); return;
        case 's': event.preventDefault(); this.saveNotes(); return;
      }
    }
    if (event.key === 'Tab') {
      event.preventDefault();
      const el = document.getElementById('notes-editor') as HTMLTextAreaElement;
      if (!el) return;
      const s = el.selectionStart;
      const e = el.selectionEnd;
      this.taskNotes =
        this.taskNotes.substring(0, s) + '    ' + this.taskNotes.substring(e);
      setTimeout(() => el.setSelectionRange(s + 4, s + 4), 0);
    }
  }

  insertFormat(type: string) {
    const el = document.getElementById('notes-editor') as HTMLTextAreaElement;
    if (!el) return;

    const s = el.selectionStart;
    const e = el.selectionEnd;
    const sel = this.taskNotes.substring(s, e);

    const fmts: Record<string, { before: string; after: string; ph: string }> = {
      bold:      { before: '**',              after: '**',     ph: 'negrito' },
      italic:    { before: '*',               after: '*',      ph: 'itálico' },
      code:      { before: '`',               after: '`',      ph: 'código' },
      codeblock: { before: '```\n',           after: '\n```',  ph: '// código aqui' },
      h1:        { before: '\n# ',            after: '\n',     ph: 'Título' },
      h2:        { before: '\n## ',           after: '\n',     ph: 'Subtítulo' },
      h3:        { before: '\n### ',          after: '\n',     ph: 'Seção' },
      bullet:    { before: '\n- ',            after: '',       ph: 'item da lista' },
      numbered:  { before: '\n1. ',           after: '',       ph: 'item numerado' },
      hr:        { before: '\n\n---\n\n',     after: '',       ph: '' },
      math:      { before: '\n$$\n',          after: '\n$$',   ph: 'f(x) = ax² + bx + c' },
      quote:     { before: '\n> ',            after: '',       ph: 'citação ou destaque' },
    };

    const fmt = fmts[type];
    if (!fmt) return;

    const text = sel || fmt.ph;
    this.taskNotes =
      this.taskNotes.substring(0, s) +
      fmt.before + text + fmt.after +
      this.taskNotes.substring(e);

    setTimeout(() => {
      el.focus();
      const newPos = s + fmt.before.length + text.length + fmt.after.length;
      el.setSelectionRange(newPos, newPos);
    }, 0);
  }

  // -------- Markdown renderer --------

  renderMarkdown(raw: string): string {
    if (!raw.trim()) {
      return '<p class="md-empty">Nenhuma anotação ainda. Comece a escrever no editor.</p>';
    }

    // 1. Extract and protect code blocks
    const blocks: string[] = [];
    let t = raw.replace(/```(\w*)\n?([\s\S]*?)```/g, (_, lang, code) => {
      const idx = blocks.length;
      const langTag = lang
        ? `<span class="code-lang">${this.escapeHtml(lang)}</span>`
        : '';
      blocks.push(
        `<div class="md-code-block">${langTag}<pre><code>${this.escapeHtml(code.trimEnd())}</code></pre></div>`
      );
      return `\x02BLK${idx}\x03`;
    });

    // 2. Escape remaining HTML
    t = t.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

    // 3. Math blocks $$...$$
    t = t.replace(/\$\$([\s\S]*?)\$\$/g, (_, m) =>
      `<div class="md-math-block"><span class="md-math-label">∑ Fórmula</span><pre class="md-math-pre">${m.trim()}</pre></div>`
    );

    // 4. Inline math $...$
    t = t.replace(/\$([^\$\n]+)\$/g, '<code class="md-inline-math">$1</code>');

    // 5. Headings
    t = t.replace(/^### (.+)$/gm, '<h3 class="md-h3">$1</h3>');
    t = t.replace(/^## (.+)$/gm,  '<h2 class="md-h2">$1</h2>');
    t = t.replace(/^# (.+)$/gm,   '<h1 class="md-h1">$1</h1>');

    // 6. Horizontal rule
    t = t.replace(/^---$/gm, '<hr class="md-hr">');

    // 7. Blockquote
    t = t.replace(/^&gt; (.+)$/gm, '<blockquote class="md-quote">$1</blockquote>');

    // 8. Bold + italic
    t = t.replace(/\*\*\*(.+?)\*\*\*/g, '<strong><em>$1</em></strong>');
    t = t.replace(/\*\*(.+?)\*\*/g,     '<strong>$1</strong>');
    t = t.replace(/\*([^*\n]+)\*/g,     '<em>$1</em>');

    // 9. Inline code
    t = t.replace(/`([^`\n]+)`/g, '<code class="md-inline-code">$1</code>');

    // 10. Lists — mark items with sentinels then wrap
    t = t.replace(/^- (.+)$/gm,     '\x00UL\x00$1\x00EUL\x00');
    t = t.replace(/^\d+\. (.+)$/gm, '\x00OL\x00$1\x00EOL\x00');

    t = t.replace(/(\x00UL\x00.+?\x00EUL\x00\n?)+/g, (m) => {
      const items = m.replace(/\x00UL\x00(.+?)\x00EUL\x00\n?/g, '<li>$1</li>');
      return `<ul class="md-ul">${items}</ul>`;
    });
    t = t.replace(/(\x00OL\x00.+?\x00EOL\x00\n?)+/g, (m) => {
      const items = m.replace(/\x00OL\x00(.+?)\x00EOL\x00\n?/g, '<li>$1</li>');
      return `<ol class="md-ol">${items}</ol>`;
    });

    // 11. Paragraph wrapping
    const blockStart = /^(<h[1-6]|<ul|<ol|<hr|<div|<blockquote|\x02BLK)/;
    const lines = t.split('\n');
    let out = '';
    let inP = false;

    for (const line of lines) {
      const tr = line.trim();
      if (!tr) {
        if (inP) { out += '</p>\n'; inP = false; }
        continue;
      }
      if (blockStart.test(tr)) {
        if (inP) { out += '</p>\n'; inP = false; }
        out += tr + '\n';
      } else {
        if (!inP) { out += '<p class="md-p">'; inP = true; } else out += '<br>';
        out += tr;
      }
    }
    if (inP) out += '</p>';

    // 12. Restore code blocks
    blocks.forEach((b, i) => { out = out.replace(`\x02BLK${i}\x03`, b); });

    return out;
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
        this.noteImages = [
          ...this.noteImages,
          { id: `${Date.now()}-${Math.random().toString(36).slice(2)}`, data, name: file.name },
        ];
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

  openImageViewer(img: { data: string; name: string }) { this.viewingImage = img; }
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
    const renderedNotesHtml = this.renderMarkdown(notes);

    const imagesHtml = this.noteImages.map(img =>
      `<div class="img-wrap"><img src="${img.data}" alt="${this.escapeHtml(img.name)}" /></div>`
    ).join('');

    const win = window.open('', '_blank', 'width=820,height=700');
    if (!win) return;

    win.document.write(`<!DOCTYPE html>
<html lang="pt-BR"><head><meta charset="UTF-8"><title>${this.escapeHtml(title)}</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@700;800&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Inter', sans-serif; font-size: 14px; color: #1C1C1F; background: #fff; padding: 40px 48px; line-height: 1.6; }
.brand { font-size: 11px; font-weight: 700; letter-spacing: .08em; text-transform: uppercase; color: #4F46E5; margin-bottom: 24px; }
h1.title { font-family: 'Outfit', sans-serif; font-size: 20px; font-weight: 800; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #E8E6E1; line-height: 1.4; }
.meta { display: flex; gap: 24px; flex-wrap: wrap; margin-bottom: 28px; }
.meta-item { display: flex; flex-direction: column; gap: 3px; }
.meta-label { font-size: 10px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #6B6B70; }
.meta-value { font-size: 13px; font-weight: 600; }
.section-title { font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #6B6B70; margin: 24px 0 10px; }
.description { background: #FAFAF8; border: 1px solid #E8E6E1; border-radius: 10px; padding: 16px 18px; white-space: pre-wrap; word-break: break-word; }
/* Markdown notes */
.notes-box { background: #FFFBEB; border: 1px solid #FDE68A; border-radius: 10px; padding: 20px 22px; }
.notes-box .md-h1 { font-family:'Outfit',sans-serif; font-size:20px; font-weight:800; margin:16px 0 8px; border-bottom:2px solid #E8E6E1; padding-bottom:6px; }
.notes-box .md-h2 { font-family:'Outfit',sans-serif; font-size:16px; font-weight:700; margin:14px 0 6px; }
.notes-box .md-h3 { font-family:'Outfit',sans-serif; font-size:13px; font-weight:700; text-transform:uppercase; letter-spacing:.04em; color:#4F46E5; margin:12px 0 4px; }
.notes-box .md-p { font-size:14px; line-height:1.75; margin-bottom:10px; }
.notes-box .md-code-block { background:#1E1E2E; border-radius:8px; margin:12px 0; overflow:hidden; }
.notes-box .md-code-block pre { padding:14px; }
.notes-box .md-code-block code { font-family:'JetBrains Mono',monospace; font-size:12px; color:#CDD6F4; white-space:pre; }
.notes-box .md-inline-code { font-family:'JetBrains Mono',monospace; font-size:12px; background:rgba(124,58,237,.1); color:#7C3AED; border-radius:3px; padding:1px 4px; }
.notes-box .md-ul,.notes-box .md-ol { margin:6px 0 10px 20px; }
.notes-box .md-ul li,.notes-box .md-ol li { margin-bottom:3px; }
.notes-box .md-hr { border:none; border-top:1px solid #E8E6E1; margin:12px 0; }
.notes-box .md-math-block { background:#F0F4FF; border:1px solid #C7D2FE; border-radius:8px; padding:12px; margin:12px 0; }
.notes-box .md-math-label { font-size:10px; font-weight:700; color:#4F46E5; text-transform:uppercase; display:block; margin-bottom:4px; }
.notes-box .md-math-pre { font-family:'JetBrains Mono',monospace; font-size:13px; }
.notes-box .md-quote { border-left:3px solid #4F46E5; padding:6px 12px; background:rgba(79,70,229,.05); color:#4F46E5; margin:10px 0; border-radius:0 6px 6px 0; }
.images-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; margin-top: 8px; }
.img-wrap img { width: 100%; border-radius: 8px; border: 1px solid #E8E6E1; }
.footer { margin-top: 40px; padding-top: 16px; border-top: 1px solid #E8E6E1; font-size: 11px; color: #6B6B70; }
@media print { body { padding: 20px 28px; } }
</style></head><body>
<div class="brand">Avante — Gestão de Tarefas</div>
<h1 class="title">${this.escapeHtml(title)}</h1>
<div class="meta">
  <div class="meta-item"><span class="meta-label">Status</span><span class="meta-value">${this.escapeHtml(status)}</span></div>
  <div class="meta-item"><span class="meta-label">Prioridade</span><span class="meta-value">${this.escapeHtml(priority)}</span></div>
  <div class="meta-item"><span class="meta-label">Sprint</span><span class="meta-value">${this.escapeHtml(sprintName)}</span></div>
  ${elapsed ? `<div class="meta-item"><span class="meta-label">Tempo</span><span class="meta-value">${this.escapeHtml(elapsed)}</span></div>` : ''}
</div>
<div class="section-title">História / Descrição</div>
<div class="description">${this.escapeHtml(task.description ?? '')}</div>
${notes.trim() ? `<div class="section-title">Minhas Anotações</div><div class="notes-box">${renderedNotesHtml}</div>` : ''}
${imagesHtml ? `<div class="section-title">Imagens / Fotos do Caderno</div><div class="images-grid">${imagesHtml}</div>` : ''}
<div class="footer">Exportado em ${now} · Avante</div>
<script>window.onload = function() { window.print(); }<\/script>
</body></html>`);
    win.document.close();
  }

  private escapeHtml(str: string): string {
    return str
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  onClose() { this.closeDialog.emit(); }

  onSave() {
    if (!this.formDescription.trim() || this.saving) return;
    this.save.emit({
      description: this.formDescription.trim(),
      status_id: this.formStatusId,
      priority: this.formPriority,
      sprint_id: this.formSprintId,
      epic: this.formEpic.trim() || null,
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
