import { Component, OnInit, signal, computed, HostListener } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CdkDragDrop, DragDropModule, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { ApiService } from '../../services/api';

import { Button } from '../../shared/ui/button/button';
import { Badge } from '../../shared/ui/badge/badge';
import { Popover } from '../../shared/ui/popover/popover';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';
import { Modal } from '../../shared/ui/modal/modal';
import { Avatar } from '../../shared/ui/avatar/avatar';
import { TaskDialog, TaskFormValue } from '../task-dialog/task-dialog';
import { SprintManager } from '../sprint-manager/sprint-manager';
import { StatusManager } from '../status-manager/status-manager';
import { Sidebar } from '../../shared/ui/sidebar/sidebar';
import { TaskFilters, TaskFilterValue } from '../task-filters/task-filters';
import { TagManagerComponent } from '../tag-manager/tag-manager';

type SortField = 'description' | 'status' | 'priority' | 'assignee' | null;
type SortDir = 'asc' | 'desc';

const PRIORITY_ORDER: Record<string, number> = { 'Urgente': 0, 'Alta': 1, 'Média': 2, 'Baixa': 3 };

@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [
    CommonModule, FormsModule, DragDropModule, Button, Badge, Popover, ConfirmDialog,
    Modal, Avatar, TaskDialog, SprintManager, StatusManager, Sidebar,
    TaskFilters, TagManagerComponent
  ],
  templateUrl: './task-list.html',
  styleUrl: './task-list.scss'
})
export class TaskListComponent implements OnInit {
  boardId!: number;

  board = signal<any>(null);
  tasks = signal<any[]>([]);
  sprints = signal<any[]>([]);
  statuses = signal<any[]>([]);
  users = signal<any[]>([]);
  tags = signal<any[]>([]);

  viewMode = signal('table');
  loading = signal(true);

  // ---------- Sidebar ----------
  sidebarCollapsed = signal(false);
  section = signal('tasks');

  toggleSidebar() { this.sidebarCollapsed.set(!this.sidebarCollapsed()); }
  setSection(s: 'tasks' | 'sprints' | 'statuses' | 'tags') { this.section.set(s); }

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private apiService: ApiService
  ) { }

  ngOnInit(): void {
    this.boardId = Number(this.route.snapshot.paramMap.get('id'));
    this.loadBoard();
    this.loadSprints();
    this.loadStatuses();
    this.loadUsers();
    this.loadTasks();
    this.loadTags();
  }

  // ---------- Filtros ----------

  currentFilters: TaskFilterValue = { search: '', status_ids: [], priorities: [], assignee_ids: [], epics: [], tag_ids: [] };
  selectedEpics = signal<string[]>([]);

  onFiltersChange(filters: TaskFilterValue) {
    this.currentFilters = filters;
    this.selectedEpics.set(filters.epics ?? []);
    this.loadTasks();
  }

  availableEpics = computed(() => {
    const set = new Set<string>();
    this.tasks().forEach(t => { if (t.epic) set.add(t.epic); });
    return [...set].sort();
  });

  // ---------- Stats computados ----------

  statsTotal = computed(() => this.tasks().length);
  statsDone = computed(() => this.tasks().filter(t => t.status?.name && /conclu/i.test(t.status.name)).length);
  statsInProgress = computed(() => this.tasks().filter(t => t.status?.name && /andamento/i.test(t.status.name)).length);
  statsNoStatus = computed(() => this.tasks().filter(t => !t.status_id).length);
  statsDonePct = computed(() => {
    const total = this.statsTotal();
    if (!total) return 0;
    return Math.round((this.statsDone() / total) * 100);
  });

  // ---------- Ordenação ----------

  sortField = signal<SortField>(null);
  sortDir = signal<SortDir>('asc');

  setSort(field: SortField) {
    if (this.sortField() === field) {
      this.sortDir.set(this.sortDir() === 'asc' ? 'desc' : 'asc');
    } else {
      this.sortField.set(field);
      this.sortDir.set('asc');
    }
  }

  clearSort() { this.sortField.set(null); }

  sortedTasks(tasks: any[]): any[] {
    const field = this.sortField();
    if (!field) return tasks;
    const dir = this.sortDir() === 'asc' ? 1 : -1;
    return [...tasks].sort((a, b) => {
      let av: any, bv: any;
      if (field === 'description') { av = (a.description ?? '').toLowerCase(); bv = (b.description ?? '').toLowerCase(); }
      else if (field === 'status') { av = (a.status?.name ?? '').toLowerCase(); bv = (b.status?.name ?? '').toLowerCase(); }
      else if (field === 'priority') {
        av = PRIORITY_ORDER[a.priority] ?? 99;
        bv = PRIORITY_ORDER[b.priority] ?? 99;
        return (av - bv) * dir;
      }
      else if (field === 'assignee') { av = (a.assignees?.[0]?.name ?? '').toLowerCase(); bv = (b.assignees?.[0]?.name ?? '').toLowerCase(); }
      if (av < bv) return -1 * dir;
      if (av > bv) return 1 * dir;
      return 0;
    });
  }

  // ---------- Carregamento ----------

  loadBoard() {
    this.apiService.getBoard(this.boardId).subscribe({
      next: (data) => this.board.set(data),
      error: (err) => console.error('Erro ao carregar board:', err)
    });
  }

  loadTasks() {
    this.loading.set(true);
    this.apiService.getTasks(this.boardId, {
      search: this.currentFilters.search || undefined,
      status_ids: this.currentFilters.status_ids.length ? this.currentFilters.status_ids : undefined,
      priorities: this.currentFilters.priorities.length ? this.currentFilters.priorities : undefined,
      assignee_ids: this.currentFilters.assignee_ids.length ? this.currentFilters.assignee_ids : undefined,
      tag_ids: this.currentFilters.tag_ids?.length ? this.currentFilters.tag_ids : undefined,
    }).subscribe({
      next: (res) => {
        this.tasks.set(Array.isArray(res) ? res : (res.data ?? []));
        this.selectedIds.set(new Set());
        this.closeBulkDropdown();
        this.loading.set(false);
      },
      error: (err) => { console.error('Erro ao carregar tarefas:', err); this.loading.set(false); }
    });
  }

  loadAll() { this.loadSprints(); this.loadStatuses(); this.loadUsers(); this.loadTasks(); this.loadTags(); }

  loadSprints() {
    this.apiService.getSprints(this.boardId).subscribe({
      next: (data) => {
        const sorted = [...data].sort((a, b) => {
          if (a.start_date && b.start_date) return a.start_date.localeCompare(b.start_date);
          return (a.name ?? '').localeCompare(b.name ?? '');
        });
        this.sprints.set(sorted);
      },
      error: (err) => console.error('Erro ao carregar sprints:', err)
    });
  }

  loadStatuses() {
    this.apiService.getStatuses(this.boardId).subscribe({
      next: (data) => { this.statuses.set(data); this.loading.set(false); },
      error: (err) => { console.error('Erro ao carregar status:', err); this.loading.set(false); }
    });
  }

  loadUsers() {
    this.apiService.getUsers().subscribe({
      next: (data) => this.users.set(data),
      error: (err) => console.error('Erro ao carregar usuários:', err)
    });
  }

  loadTags() {
    this.apiService.getTags(this.boardId).subscribe({
      next: (data) => this.tags.set(data),
      error: () => {}
    });
  }

  // ---------- Agrupamentos ----------

  groupedBySprint = computed(() => {
    const epicFilter = this.selectedEpics();
    const allTasks = epicFilter.length
      ? this.tasks().filter(t => t.epic && epicFilter.includes(t.epic))
      : this.tasks();

    const groups: { sprint: any | null; tasks: any[] }[] = [];
    for (const sprint of this.sprints()) {
      const sprintTasks = this.sortedTasks(allTasks.filter(t => t.sprint_id === sprint.id));
      groups.push({ sprint, tasks: sprintTasks });
    }
    const withoutSprint = this.sortedTasks(allTasks.filter(t => !t.sprint_id));
    groups.push({ sprint: null, tasks: withoutSprint });
    return groups;
  });

  setViewMode(mode: 'kanban' | 'table') { this.viewMode.set(mode); }
  goBack() { this.router.navigate(['/']); }

  reloadSprints() {
    this.apiService.getSprints(this.boardId).subscribe({
      next: (data) => {
        const sorted = [...data].sort((a, b) => {
          if (a.start_date && b.start_date) return a.start_date.localeCompare(b.start_date);
          return (a.name ?? '').localeCompare(b.name ?? '');
        });
        this.sprints.set(sorted);
      },
      error: (err) => console.error('Erro ao recarregar sprints:', err)
    });
  }

  reloadStatuses() {
    this.apiService.getStatuses(this.boardId).subscribe({
      next: (data) => this.statuses.set(data),
      error: (err) => console.error('Erro ao recarregar status:', err)
    });
  }

  // ---------- Progresso da sprint ----------

  sprintProgressSegments(sprintTasks: any[]): { color: string; pct: number; name: string; count: number }[] {
    if (!sprintTasks.length) return [];
    const total = sprintTasks.length;
    const map = new Map<string, { color: string; name: string; count: number }>();
    for (const task of sprintTasks) {
      const key = task.status?.id ?? '__none__';
      const name = task.status?.name ?? 'Sem status';
      const color = task.status?.color ?? '#D1D5DB';
      if (map.has(key)) { map.get(key)!.count++; }
      else { map.set(key, { color, name, count: 1 }); }
    }
    return Array.from(map.values()).map(s => ({ ...s, pct: (s.count / total) * 100 }));
  }

  sprintCompletionPct(sprintTasks: any[]): number {
    if (!sprintTasks.length) return 0;
    const done = sprintTasks.filter(t => t.status?.name && /conclu/i.test(t.status.name)).length;
    return Math.round((done / sprintTasks.length) * 100);
  }

  sprintDoneCount(sprintTasks: any[]): number {
    return sprintTasks.filter(t => t.status?.name && /conclu/i.test(t.status.name)).length;
  }

  sprintRemainingCount(sprintTasks: any[]): number {
    return sprintTasks.length - this.sprintDoneCount(sprintTasks);
  }

  isSprintFinished(sprint: any): boolean { return !!sprint?.finished_at; }

  isSprintOverdue(sprint: any): boolean {
    if (!sprint?.end_date || sprint?.finished_at) return false;
    return new Date(sprint.end_date) < new Date(new Date().toDateString());
  }

  sprintDaysRemaining(sprint: any): number | null {
    if (!sprint?.end_date || sprint?.finished_at) return null;
    const end = new Date(sprint.end_date);
    const today = new Date(new Date().toDateString());
    return Math.ceil((end.getTime() - today.getTime()) / 86400000);
  }

  canFinishSprint(sprint: any, sprintTasks: any[]): boolean {
    if (!sprint || sprint.finished_at) return false;
    return this.isSprintOverdue(sprint) || this.sprintCompletionPct(sprintTasks) === 100;
  }

  sprintTooltip(sprint: any, sprintTasks: any[]): string {
    const segs = this.sprintProgressSegments(sprintTasks);
    const pct = this.sprintCompletionPct(sprintTasks);
    const lines = segs.map(s => `${s.name}: ${s.count} (${Math.round(s.pct)}%)`);
    lines.push(`\nConcluído: ${pct}%`);
    return lines.join('\n');
  }

  // ---------- Finalizar sprint ----------

  finishingSprintId = signal<number | null>(null);
  finishConfirmOpen = signal(false);
  sprintToFinish: any = null;
  sprintToFinishTasks: any[] = [];

  openFinishConfirm(sprint: any, tasks: any[], event: Event) {
    event.stopPropagation();
    this.sprintToFinish = sprint;
    this.sprintToFinishTasks = tasks;
    this.finishConfirmOpen.set(true);
  }

  closeFinishConfirm() {
    this.finishConfirmOpen.set(false);
    this.sprintToFinish = null;
    this.sprintToFinishTasks = [];
  }

  confirmFinishSprint() {
    if (!this.sprintToFinish) return;
    const sprint = this.sprintToFinish;
    const concludedStatus = this.statuses().find(s => /conclu/i.test(s.name));
    this.finishingSprintId.set(sprint.id);
    this.finishConfirmOpen.set(false);
    this.apiService.finishSprint(sprint.id, { concluded_status_id: concludedStatus?.id ?? null }).subscribe({
      next: (res) => {
        this.finishingSprintId.set(null);
        this.sprintToFinish = null;
        const msg = res.overflow_count > 0
          ? `Sprint finalizada! ${res.overflow_count} tarefa(s) movida(s) para "${res.next_sprint}".`
          : 'Sprint finalizada com sucesso!';
        this.showToast(msg);
        this.loadSprints();
        this.loadTasks();
      },
      error: (err) => { console.error('Erro ao finalizar sprint:', err); this.finishingSprintId.set(null); }
    });
  }

  toastMsg = signal('');
  showToast(msg: string) {
    this.toastMsg.set(msg);
    setTimeout(() => this.toastMsg.set(''), 4000);
  }

  // ---------- Seleção de tarefas ----------

  selectedIds = signal<Set<number>>(new Set());

  isSelected(id: number): boolean { return this.selectedIds().has(id); }

  toggleSelect(id: number, event: Event) {
    event.stopPropagation();
    const s = new Set(this.selectedIds());
    s.has(id) ? s.delete(id) : s.add(id);
    this.selectedIds.set(s);
  }

  isGroupAllSelected(tasks: any[]): boolean {
    if (tasks.length === 0) return false;
    return tasks.every(t => this.selectedIds().has(t.id));
  }

  isGroupIndeterminate(tasks: any[]): boolean {
    const sel = tasks.filter(t => this.selectedIds().has(t.id)).length;
    return sel > 0 && sel < tasks.length;
  }

  toggleSelectGroup(tasks: any[], event: Event) {
    event.stopPropagation();
    const s = new Set(this.selectedIds());
    if (this.isGroupAllSelected(tasks)) {
      tasks.forEach(t => s.delete(t.id));
    } else {
      tasks.forEach(t => s.add(t.id));
    }
    this.selectedIds.set(s);
  }

  get selectedCount(): number { return this.selectedIds().size; }
  clearSelection() { this.selectedIds.set(new Set()); this.closeBulkDropdown(); }

  // ---------- Ações em massa ----------

  bulkDropdown = signal<'status' | 'priority' | 'sprint' | 'assignee' | null>(null);
  bulkUpdating = signal(false);

  toggleBulkDropdown(type: 'status' | 'priority' | 'sprint' | 'assignee') {
    this.bulkDropdown.set(this.bulkDropdown() === type ? null : type);
  }

  closeBulkDropdown() { this.bulkDropdown.set(null); }

  bulkUpdateField(field: 'status_id' | 'priority', value: any, label: string) {
    const ids = Array.from(this.selectedIds());
    if (!ids.length) return;
    this.bulkUpdating.set(true);
    this.closeBulkDropdown();

    let completed = 0;
    const updatedTasks = [...this.tasks()];

    for (const id of ids) {
      this.apiService.updateTask(id, { [field]: value }).subscribe({
        next: (updated) => {
          const idx = updatedTasks.findIndex(t => t.id === id);
          if (idx !== -1) updatedTasks[idx] = updated;
          completed++;
          if (completed === ids.length) {
            this.tasks.set([...updatedTasks]);
            this.bulkUpdating.set(false);
            this.showToast(`${ids.length} tarefa(s) atualizadas — ${label}`);
          }
        },
        error: (err) => {
          console.error('Erro ao atualizar em massa:', err);
          completed++;
          if (completed === ids.length) {
            this.bulkUpdating.set(false);
            this.loadTasks();
          }
        }
      });
    }
  }

  bulkSetStatus(status: any) {
    this.bulkUpdateField('status_id', status.id, status.name);
  }

  bulkSetPriority(priority: string) {
    this.bulkUpdateField('priority', priority, priority);
  }

  bulkAssigneeSearch = signal('');

  bulkAddAssignee(user: any) {
    const ids = Array.from(this.selectedIds());
    if (!ids.length) return;
    this.bulkUpdating.set(true);
    this.closeBulkDropdown();
    let completed = 0;
    const updatedTasks = [...this.tasks()];
    for (const id of ids) {
      const task = updatedTasks.find(t => t.id === id);
      const current: number[] = (task?.assignees ?? []).map((u: any) => Number(u.id));
      const merged = current.includes(Number(user.id)) ? current : [...current, Number(user.id)];
      this.apiService.updateTask(id, { assignee_ids: merged }).subscribe({
        next: (updated) => {
          const idx = updatedTasks.findIndex(t => t.id === id);
          if (idx !== -1) updatedTasks[idx] = updated;
          completed++;
          if (completed === ids.length) {
            this.tasks.set([...updatedTasks]);
            this.bulkUpdating.set(false);
            this.showToast(`${ids.length} tarefa(s) atribuídas para ${user.name}`);
          }
        },
        error: () => {
          completed++;
          if (completed === ids.length) { this.bulkUpdating.set(false); this.loadTasks(); }
        }
      });
    }
  }

  filteredBulkUsers = computed(() => {
    const term = this.bulkAssigneeSearch().toLowerCase();
    if (!term) return this.users();
    return this.users().filter(u => (u.name ?? '').toLowerCase().includes(term));
  });

  // ---------- Mover tarefas selecionadas ----------

  movingToSprint = signal(false);
  moveSprintModalOpen = signal(false);

  openMoveModal() { this.closeBulkDropdown(); this.moveSprintModalOpen.set(true); }
  closeMoveModal() { this.moveSprintModalOpen.set(false); }

  moveSelectedToSprint(sprintId: number | null) {
    const ids = Array.from(this.selectedIds());
    if (ids.length === 0) return;
    this.movingToSprint.set(true);
    let completed = 0;
    for (const id of ids) {
      this.apiService.updateTask(id, { sprint_id: sprintId }).subscribe({
        next: () => {
          completed++;
          if (completed === ids.length) {
            this.movingToSprint.set(false);
            this.moveSprintModalOpen.set(false);
            this.selectedIds.set(new Set());
            this.loadTasks();
          }
        },
        error: (err) => {
          console.error('Erro ao mover tarefa:', err);
          completed++;
          if (completed === ids.length) { this.movingToSprint.set(false); this.moveSprintModalOpen.set(false); this.loadTasks(); }
        }
      });
    }
  }

  // ---------- Modal criar/editar atividade ----------

  taskDialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingTask: any = null;
  saving = signal(false);

  openCreateTaskDialog() {
    this.dialogMode = 'create';
    this.editingTask = null;
    this.comments.set([]);
    this.taskDialogOpen.set(true);
  }

  openEditTaskDialog(task: any) {
    this.dialogMode = 'edit';
    this.editingTask = task;
    this.taskDialogOpen.set(true);
    this.loadComments(task.id);
  }

  closeTaskDialog() { this.taskDialogOpen.set(false); }

  confirmSaveTask(formValue: TaskFormValue) {
    this.saving.set(true);
    const payload = { board_id: this.boardId, ...formValue };
    const request$ = this.dialogMode === 'edit' && this.editingTask
      ? this.apiService.updateTask(this.editingTask.id, payload)
      : this.apiService.createTask(payload);
    request$.subscribe({
      next: () => { this.saving.set(false); this.taskDialogOpen.set(false); this.loadTasks(); },
      error: (err) => { console.error('Erro ao salvar tarefa:', err); this.saving.set(false); }
    });
  }

  // ---------- Comentários ----------

  comments = signal<any[]>([]);
  savingComment = signal(false);

  loadComments(taskId: number) {
    this.apiService.getComments(taskId).subscribe({
      next: (data) => this.comments.set(data),
      error: (err) => console.error('Erro ao carregar comentários:', err)
    });
  }

  onAddComment(data: { content: string }) {
    if (!this.editingTask) return;
    this.savingComment.set(true);
    this.apiService.createComment(this.editingTask.id, data).subscribe({
      next: () => { this.loadComments(this.editingTask.id); this.savingComment.set(false); },
      error: (err) => { console.error('Erro ao criar comentário:', err); this.savingComment.set(false); }
    });
  }

  onRemoveComment(id: number) {
    if (!this.editingTask) return;
    this.apiService.deleteComment(id).subscribe({
      next: () => this.loadComments(this.editingTask.id),
      error: (err) => console.error('Erro ao excluir comentário:', err)
    });
  }

  // ---------- Modal excluir atividade ----------

  deleteDialogOpen = signal(false);
  taskPendingDelete: any = null;
  deleting = signal(false);

  askDeleteTask(task: any, event?: Event) {
    event?.stopPropagation();
    this.taskPendingDelete = task;
    this.deleteDialogOpen.set(true);
  }

  cancelDeleteTask() {
    if (this.deleting()) return;
    this.deleteDialogOpen.set(false);
    this.taskPendingDelete = null;
  }

  confirmDeleteTask() {
    if (!this.taskPendingDelete || this.deleting()) return;
    this.deleting.set(true);
    this.apiService.deleteTask(this.taskPendingDelete.id).subscribe({
      next: () => {
        this.deleting.set(false);
        this.deleteDialogOpen.set(false);
        this.taskPendingDelete = null;
        this.loadTasks();
      },
      error: (err) => { console.error('Erro ao excluir tarefa:', err); this.deleting.set(false); }
    });
  }

  // ---------- Atualização inline ----------

  private readonly MOTIVATIONAL_COMPLETE = [
    '🎉 Tarefa concluída! Você está arrasando!',
    '🔥 Mais uma na conta! Continue esse ritmo!',
    '✅ Concluído! Cada tarefa é uma vitória.',
    '💪 Isso! Progresso é progresso, não importa o tamanho.',
    '🚀 Tarefa finalizada! O sucesso é construído assim.',
    '⭐ Excelente! Você está mais perto dos seus objetivos.',
    '🏆 Task done! Você é imparável!',
  ];

  updateTaskField(task: any, field: string, value: any) {
    this.apiService.updateTask(task.id, { [field]: value }).subscribe({
      next: (updated) => {
        this.tasks.set(this.tasks().map(t => t.id === task.id ? updated : t));
        if (field === 'status_id' && updated.status?.name && /conclu/i.test(updated.status.name)) {
          const msg = this.MOTIVATIONAL_COMPLETE[Math.floor(Math.random() * this.MOTIVATIONAL_COMPLETE.length)];
          this.showToast(msg);
        }
      },
      error: (err) => console.error(`Erro ao atualizar ${field}:`, err)
    });
  }

  updateTaskAssignees(task: any, userIds: number[]) {
    this.apiService.updateTask(task.id, { assignee_ids: userIds }).subscribe({
      next: (updated) => { this.tasks.set(this.tasks().map(t => t.id === task.id ? updated : t)); },
      error: (err) => console.error('Erro ao atualizar responsáveis:', err)
    });
  }

  // ---------- Popover de responsáveis (substitui modal) ----------

  assigneePopoverOpen = signal(false);
  assigneePopoverStyle = signal({ top: '0px', left: '0px' });
  taskForAssignees: any = null;
  assigneeSearchTerm = signal('');

  openAssigneePopover(task: any, event: Event) {
    event.stopPropagation();
    const el = event.currentTarget as HTMLElement;
    const rect = el.getBoundingClientRect();

    if (this.taskForAssignees?.id === task.id && this.assigneePopoverOpen()) {
      this.closeAssigneePopover();
      return;
    }

    this.taskForAssignees = { ...task };
    this.assigneeSearchTerm.set('');

    const popW = 300;
    const popH = 380;
    let left = rect.left;
    if (left + popW > window.innerWidth - 16) left = window.innerWidth - popW - 16;

    let top: number;
    if (rect.bottom + popH > window.innerHeight - 16) {
      top = Math.max(8, rect.top - popH - 8);
    } else {
      top = rect.bottom + 8;
    }

    this.assigneePopoverStyle.set({ top: `${top}px`, left: `${left}px` });
    this.assigneePopoverOpen.set(true);
  }

  // Compat: task-dialog chama manageAssignees sem event → abre centrado
  openAssigneeModal(task: any, event?: Event) {
    if (event) {
      this.openAssigneePopover(task, event);
    } else {
      this.taskForAssignees = { ...task };
      this.assigneeSearchTerm.set('');
      const popW = 300;
      const popH = 380;
      this.assigneePopoverStyle.set({
        top: `${Math.max(8, (window.innerHeight - popH) / 2)}px`,
        left: `${Math.max(8, (window.innerWidth - popW) / 2)}px`
      });
      this.assigneePopoverOpen.set(true);
    }
  }

  closeAssigneePopover() {
    this.assigneePopoverOpen.set(false);
  }

  // Alias para compatibilidade com template
  closeAssigneeModal() { this.closeAssigneePopover(); }

  @HostListener('document:keydown.escape')
  onEscKey() {
    if (this.assigneePopoverOpen()) this.closeAssigneePopover();
  }

  @HostListener('document:click')
  onDocumentClick() {
    if (this.assigneePopoverOpen()) this.closeAssigneePopover();
  }

  toggleAssignee(userId: number) {
    const task = this.taskForAssignees;
    if (!task) return;
    const current: number[] = (task.assignees ?? []).map((u: any) => Number(u.id));
    const updated = current.includes(Number(userId))
      ? current.filter(id => id !== Number(userId))
      : [...current, Number(userId)];
    const updatedUsers = this.users().filter(u => updated.includes(Number(u.id)));
    this.taskForAssignees = { ...task, assignees: updatedUsers };
    this.tasks.set(this.tasks().map(t => t.id === task.id ? this.taskForAssignees : t));
    if (this.editingTask && this.editingTask.id === task.id) this.editingTask = this.taskForAssignees;
    this.updateTaskAssignees(task, updated);
  }

  removeAssignee(userId: number, event?: Event) {
    event?.stopPropagation();
    this.toggleAssignee(userId);
  }

  isAssignee(userId: number): boolean {
    return (this.taskForAssignees?.assignees ?? []).some((u: any) => Number(u.id) === Number(userId));
  }

  suggestedUsers = computed(() => {
    const selectedIds = new Set((this.taskForAssignees?.assignees ?? []).map((u: any) => Number(u.id)));
    const term = this.assigneeSearchTerm().trim().toLowerCase();
    return this.users().filter(u => {
      if (selectedIds.has(Number(u.id))) return false;
      if (!term) return true;
      return (u.name ?? '').toLowerCase().includes(term);
    });
  });

  // ---------- Drag-and-drop de tarefas ----------

  draggingTask = signal(false);

  dropListIds = computed(() =>
    this.groupedBySprint().map(g => 'drop-' + (g.sprint?.id ?? 'backlog'))
  );

  dropListId(group: any): string {
    return 'drop-' + (group.sprint?.id ?? 'backlog');
  }

  onTaskDrop(event: CdkDragDrop<any[]>, targetGroup: any) {
    const sourceList: any[] = event.previousContainer.data;
    const targetList: any[] = event.container.data;

    if (event.previousContainer === event.container) {
      // Reorder dentro do mesmo grupo
      moveItemInArray(targetList, event.previousIndex, event.currentIndex);
    } else {
      // Mover para outro sprint
      transferArrayItem(sourceList, targetList, event.previousIndex, event.currentIndex);
      const task = targetList[event.currentIndex];
      const newSprintId = targetGroup.sprint?.id ?? null;
      this.apiService.updateTask(task.id, { sprint_id: newSprintId }).subscribe({
        next: (updated) => {
          targetList[event.currentIndex] = updated;
        }
      });
    }

    // Persistir ordem
    const items = targetList.map((t, i) => ({ id: t.id, sort_order: i }));
    this.apiService.reorderTasks(items).subscribe();
  }

  // ---------- JSON Bulk Import ----------

  importJsonModalOpen = signal(false);
  importJsonText = '';
  importJsonSprintId: number | null = null;
  importJsonStatusId: number | null = null;
  importJsonProgress = signal(0);
  importJsonTotal = signal(0);
  importJsonErrors: string[] = [];
  importJsonRunning = signal(false);
  importJsonDone = signal(false);

  openImportJsonModal() {
    this.importJsonText = '';
    this.importJsonSprintId = null;
    this.importJsonStatusId = null;
    this.importJsonProgress.set(0);
    this.importJsonTotal.set(0);
    this.importJsonErrors = [];
    this.importJsonRunning.set(false);
    this.importJsonDone.set(false);
    this.importJsonModalOpen.set(true);
  }

  closeImportJsonModal() {
    if (this.importJsonRunning()) return;
    this.importJsonModalOpen.set(false);
  }

  startJsonImport() {
    if (this.importJsonRunning()) return;
    let parsed: any[];
    try {
      parsed = JSON.parse(this.importJsonText);
      if (!Array.isArray(parsed)) throw new Error('O JSON deve ser um array.');
    } catch (e: any) {
      this.importJsonErrors = [`Erro ao parsear JSON: ${e.message}`];
      return;
    }

    const tasks = parsed.filter(item => item && typeof item.description === 'string' && item.description.trim());
    if (!tasks.length) {
      this.importJsonErrors = ['Nenhuma tarefa válida encontrada. Verifique o campo "description".'];
      return;
    }

    this.importJsonErrors = [];
    this.importJsonTotal.set(tasks.length);
    this.importJsonProgress.set(0);
    this.importJsonRunning.set(true);
    this.importJsonDone.set(false);

    const importNext = (idx: number) => {
      if (idx >= tasks.length) {
        this.importJsonRunning.set(false);
        this.importJsonDone.set(true);
        this.loadTasks();
        return;
      }
      const item = tasks[idx];
      const payload: any = {
        board_id: this.boardId,
        description: item.description.trim(),
        priority: item.priority ?? 'Média',
        epic: item.epic ?? undefined,
        sprint_id: item.sprint_id ?? this.importJsonSprintId ?? undefined,
        status_id: item.status_id ?? this.importJsonStatusId ?? undefined,
      };
      this.apiService.createTask(payload).subscribe({
        next: () => { this.importJsonProgress.set(idx + 1); importNext(idx + 1); },
        error: () => {
          this.importJsonErrors.push(`Tarefa ${idx + 1}: "${item.description.substring(0, 40)}..." — erro ao importar`);
          this.importJsonProgress.set(idx + 1);
          importNext(idx + 1);
        }
      });
    };

    importNext(0);
  }

  // ---------- Feature placeholder ----------

  comingSoonToast = signal('');
  showComingSoon(feature: string) {
    this.comingSoonToast.set(`🚀 ${feature} — Funcionalidade em evolução. Em breve!`);
    setTimeout(() => this.comingSoonToast.set(''), 3500);
  }

  // ---------- Utilitários ----------

  initialsFor(name: string | undefined | null): string {
    if (!name) return '?';
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 0) return '?';
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  priorityColor(priority: string): string {
    const colors: Record<string, string> = {
      'Baixa': '#059669', 'Média': '#0284C7', 'Alta': '#EA580C', 'Urgente': '#DC2626',
    };
    return colors[priority] || '#6B6B70';
  }

  priorities = ['Baixa', 'Média', 'Alta', 'Urgente'];

  summaryFor(description: string | undefined | null): string {
    if (!description) return '(sem descrição)';
    const trimmed = description.trim();
    const maxLength = 90;
    if (trimmed.length <= maxLength) return trimmed;
    return trimmed.slice(0, maxLength).trimEnd() + '…';
  }

  copiedTaskId = signal<number | null>(null);

  copyDescription(task: any, event: Event) {
    event.stopPropagation();
    if (!task.description) return;
    navigator.clipboard.writeText(task.description).then(() => {
      this.copiedTaskId.set(task.id);
      setTimeout(() => { if (this.copiedTaskId() === task.id) this.copiedTaskId.set(null); }, 1500);
    }).catch((err) => console.error('Erro ao copiar:', err));
  }

  collapsedGroups = signal<Set<string>>(new Set());
  isGroupCollapsed(key: string): boolean { return this.collapsedGroups().has(key); }
  toggleGroup(key: string) {
    const current = new Set(this.collapsedGroups());
    current.has(key) ? current.delete(key) : current.add(key);
    this.collapsedGroups.set(current);
  }
}
