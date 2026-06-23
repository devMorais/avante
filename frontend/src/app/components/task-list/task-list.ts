import { Component, OnInit, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
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
import { Pagination } from '../../shared/ui/pagination/pagination';

type SortField = 'description' | 'status' | 'priority' | 'assignee' | null;
type SortDir = 'asc' | 'desc';

const PRIORITY_ORDER: Record<string, number> = { 'Urgente': 0, 'Alta': 1, 'Média': 2, 'Baixa': 3 };

@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [
    CommonModule, FormsModule, Button, Badge, Popover, ConfirmDialog,
    Modal, Avatar, TaskDialog, SprintManager, StatusManager, Sidebar,
    TaskFilters, Pagination
  ],
  templateUrl: './task-list.html',
  styleUrl: './task-list.scss'
})
export class TaskListComponent implements OnInit {
  boardId!: number;

  tasks = signal<any[]>([]);
  sprints = signal<any[]>([]);
  statuses = signal<any[]>([]);
  users = signal<any[]>([]);

  viewMode = signal('table');
  loading = signal(true);

  // ---------- Sidebar ----------
  sidebarCollapsed = signal(false);
  section = signal('tasks');

  toggleSidebar() { this.sidebarCollapsed.set(!this.sidebarCollapsed()); }
  setSection(section: 'tasks' | 'sprints' | 'statuses') { this.section.set(section); }

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private apiService: ApiService
  ) { }

  ngOnInit(): void {
    this.boardId = Number(this.route.snapshot.paramMap.get('id'));
    this.loadSprints();
    this.loadStatuses();
    this.loadUsers();
    this.loadTasks();
  }

  // ---------- Filtros e paginação ----------

  currentFilters: TaskFilterValue = {
    search: '',
    status_ids: [],
    priorities: [],
    assignee_ids: [],
  };

  currentPage = signal(1);
  lastPage = signal(1);
  total = signal(0);
  perPage = signal(25);
  fromItem = signal(1);
  toItem = signal(25);

  onFiltersChange(filters: TaskFilterValue) {
    this.currentFilters = filters;
    this.currentPage.set(1);
    this.loadTasks();
  }

  onPageChange(page: number) {
    this.currentPage.set(page);
    this.loadTasks();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  onPerPageChange(perPage: number) {
    this.perPage.set(perPage);
    this.currentPage.set(1);
    this.loadTasks();
  }

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

  loadTasks() {
    this.loading.set(true);
    this.apiService.getTasks(this.boardId, {
      page: this.currentPage(),
      per_page: this.perPage(),
      search: this.currentFilters.search || undefined,
      status_ids: this.currentFilters.status_ids.length ? this.currentFilters.status_ids : undefined,
      priorities: this.currentFilters.priorities.length ? this.currentFilters.priorities : undefined,
      assignee_ids: this.currentFilters.assignee_ids.length ? this.currentFilters.assignee_ids : undefined,
    }).subscribe({
      next: (res) => {
        if (res && res.data) {
          this.tasks.set(res.data);
          this.currentPage.set(res.current_page);
          this.lastPage.set(res.last_page);
          this.total.set(res.total);
          this.fromItem.set(res.from ?? 1);
          this.toItem.set(res.to ?? res.data.length);
        } else {
          this.tasks.set(res);
          this.lastPage.set(1);
          this.total.set(res.length);
          this.fromItem.set(1);
          this.toItem.set(res.length);
        }
        this.selectedIds.set(new Set());
        this.loading.set(false);
      },
      error: (err) => {
        console.error('Erro ao carregar tarefas:', err);
        this.loading.set(false);
      }
    });
  }

  loadAll() {
    this.loadSprints();
    this.loadStatuses();
    this.loadUsers();
    this.loadTasks();
  }

  loadSprints() {
    this.apiService.getSprints(this.boardId).subscribe({
      next: (data) => {
        // Garante que as sprints ficam ordenadas pelo nome / start_date
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

  // ---------- Agrupamentos ----------

  groupedBySprint = computed(() => {
    const groups: { sprint: any | null; tasks: any[] }[] = [];
    for (const sprint of this.sprints()) {
      const sprintTasks = this.sortedTasks(this.tasks().filter(t => t.sprint_id === sprint.id));
      groups.push({ sprint, tasks: sprintTasks });
    }
    const withoutSprint = this.sortedTasks(this.tasks().filter(t => !t.sprint_id));
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

  clearSelection() { this.selectedIds.set(new Set()); }

  // ---------- Mover tarefas selecionadas ----------

  movingToSprint = signal(false);
  moveSprintModalOpen = signal(false);

  openMoveModal() { this.moveSprintModalOpen.set(true); }
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
          if (completed === ids.length) {
            this.movingToSprint.set(false);
            this.moveSprintModalOpen.set(false);
            this.loadTasks();
          }
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
      next: () => {
        this.saving.set(false);
        this.taskDialogOpen.set(false);
        this.loadTasks();
      },
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

  updateTaskField(task: any, field: string, value: any) {
    this.apiService.updateTask(task.id, { [field]: value }).subscribe({
      next: (updated) => { this.tasks.set(this.tasks().map(t => t.id === task.id ? updated : t)); },
      error: (err) => console.error(`Erro ao atualizar ${field}:`, err)
    });
  }

  updateTaskAssignees(task: any, userIds: number[]) {
    this.apiService.updateTask(task.id, { assignee_ids: userIds }).subscribe({
      next: (updated) => { this.tasks.set(this.tasks().map(t => t.id === task.id ? updated : t)); },
      error: (err) => console.error('Erro ao atualizar responsáveis:', err)
    });
  }

  // ---------- Modal de responsáveis ----------

  assigneeModalOpen = signal(false);
  taskForAssignees: any = null;
  assigneeSearchTerm = signal('');

  openAssigneeModal(task: any, event?: Event) {
    event?.stopPropagation();
    this.taskForAssignees = { ...task };
    this.assigneeSearchTerm.set('');
    this.assigneeModalOpen.set(true);
  }

  closeAssigneeModal() {
    this.assigneeModalOpen.set(false);
    this.taskForAssignees = null;
    this.assigneeSearchTerm.set('');
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
    if (this.editingTask && this.editingTask.id === task.id) {
      this.editingTask = this.taskForAssignees;
    }
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
