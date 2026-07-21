import { Component, OnInit, signal, computed, HostListener, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CdkDragDrop, DragDropModule, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { forkJoin } from 'rxjs';
import { ApiService } from '../../services/api';

import { Button } from '../../shared/ui/button/button';
import { Badge } from '../../shared/ui/badge/badge';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';
import { Modal } from '../../shared/ui/modal/modal';
import { Avatar } from '../../shared/ui/avatar/avatar';
import { TaskDialog, TaskFormValue } from '../task-dialog/task-dialog';
import { SprintManager } from '../sprint-manager/sprint-manager';
import { StatusManager } from '../status-manager/status-manager';
import { PriorityManager } from '../priority-manager/priority-manager';
import { TypeManager } from '../type-manager/type-manager';
import { Sidebar } from '../../shared/ui/sidebar/sidebar';
import { TaskFilters, TaskFilterValue } from '../task-filters/task-filters';
import { TooltipDirective } from '../../shared/ui/tooltip/tooltip';
import { ConstructionComponent, ConstructionFeature } from '../../shared/ui/construction/construction';
import { Marketing } from '../marketing/marketing';
import { Analytics } from '../analytics/analytics';

type SortField = 'description' | 'status' | 'priority' | 'assignee' | null;
type SortDir = 'asc' | 'desc';


@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [
    CommonModule, FormsModule, DragDropModule, Button, Badge, ConfirmDialog,
    Modal, Avatar, TaskDialog, SprintManager, StatusManager, PriorityManager, TypeManager, Sidebar,
    TaskFilters, TooltipDirective, ConstructionComponent, Marketing, Analytics
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
  priorities = signal<any[]>([]);
  taskTypes = signal<any[]>([]);

  viewMode = signal('table');
  loading = signal(true);

  // ---------- Sidebar ----------
  sidebarCollapsed = signal(false);
  section = signal('tasks');

  // Sub-navegação dentro da seção "marketing": 'tasks' reusa a mesma Tabela/Kanban
  // de tarefas (área marketing); as demais delegam pro <app-marketing>.
  marketingTab = signal<'tasks' | 'pipeline' | 'ideas' | 'campaigns' | 'performance'>('tasks');

  // Área ativa: decide se Tabela/Kanban/Sprints mostram tarefas de programação
  // ou de marketing — cada uma com seu próprio conjunto de status/prioridades/tipos.
  currentArea = computed<'programming' | 'marketing'>(() =>
    this.section() === 'marketing' && this.marketingTab() === 'tasks' ? 'marketing' : 'programming'
  );

  // Sub-tab de marketing SEM 'tasks' — tipo estreito para o binding com <app-marketing>,
  // que só é renderizado quando marketingTab() !== 'tasks' (ver *ngIf no template).
  marketingSubTab = computed<'pipeline' | 'ideas' | 'campaigns' | 'performance'>(() => {
    const t = this.marketingTab();
    return t === 'tasks' ? 'pipeline' : t;
  });

  toggleSidebar() { this.sidebarCollapsed.set(!this.sidebarCollapsed()); }
  setSection(s: 'tasks' | 'sprints' | 'statuses' | 'priorities' | 'types' | 'marketing' | 'analytics' | 'educore') {
    const prevArea = this.currentArea();
    this.section.set(s);
    if (s === 'marketing') {
      this.marketingTab.set('tasks');
    }
    // troca de área (programação <-> marketing): recarrega tasks/status/prioridades/tipos
    // do conjunto certo — sem isso a tela ficava mostrando os dados da área anterior.
    if (this.currentArea() !== prevArea || s === 'tasks' || s === 'marketing') {
      this.loadAll();
    }
    this.syncSectionToUrl();
  }

  setMarketingTab(t: 'tasks' | 'pipeline' | 'ideas' | 'campaigns' | 'performance') {
    this.marketingTab.set(t);
    if (t === 'tasks') this.loadAll();
    this.syncSectionToUrl();
  }

  // Guarda a aba/sub-aba ativa na URL (?section=...&mtab=...) para sobreviver
  // a um F5 — sem isso a tela sempre voltava pra "Tarefas" ao atualizar a página.
  private syncSectionToUrl() {
    const queryParams: any = { section: this.section() };
    if (this.section() === 'marketing') queryParams.mtab = this.marketingTab();
    this.router.navigate([], {
      relativeTo: this.route,
      queryParams,
      queryParamsHandling: 'merge',
      replaceUrl: true,
    });
  }

  reloadPriorities() { this.loadPriorities(); }

  // ---------- Funcionalidades planejadas (páginas em construção) ----------

  readonly educoreFeatures: ConstructionFeature[] = [
    { icon: 'book', title: 'Leitor de PDFs', desc: 'Abra materiais de estudo direto no quadro, ligados às atividades.' },
    { icon: 'doc', title: 'Trilhas de estudo', desc: 'Organize conteúdos em trilhas e marque seu progresso.' },
    { icon: 'bulb', title: 'Anotações inteligentes', desc: 'Caderno integrado com resumos e revisões espaçadas.' },
    { icon: 'target', title: 'Metas de aprendizado', desc: 'Defina objetivos e acompanhe a evolução por tema.' },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private apiService: ApiService
  ) { }

  ngOnInit(): void {
    this.boardId = Number(this.route.snapshot.paramMap.get('id'));

    const qp = this.route.snapshot.queryParamMap;
    const validSections = ['tasks', 'sprints', 'statuses', 'priorities', 'types', 'marketing', 'analytics', 'educore'];
    const qSection = qp.get('section');
    if (qSection && validSections.includes(qSection)) this.section.set(qSection as any);
    const qMtab = qp.get('mtab');
    const validMtabs = ['tasks', 'pipeline', 'ideas', 'campaigns', 'performance'];
    if (qMtab && validMtabs.includes(qMtab)) this.marketingTab.set(qMtab as any);

    this.loadBoard();
    this.loadSprints();
    this.loadStatuses();
    this.loadUsers();
    this.loadTasks();
    this.loadTags();
    this.loadPriorities();
    this.loadTaskTypes();
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

  // ---------- Ordenação (por sprint) ----------

  // Mapa: chave do grupo -> { field, dir }
  sprintSort = signal<Record<string, { field: SortField; dir: SortDir }>>({});
  // Grupos cuja ordem foi alterada por drag (para habilitar o reset)
  draggedGroups = signal<Set<string>>(new Set());
  // Snapshot da ordem original (id -> índice), capturado no primeiro load
  private originalOrder = new Map<number, number>();

  groupKey(sprint: any): string { return String(sprint?.id ?? 'backlog'); }
  taskGroupKey(task: any): string { return String(task?.sprint_id ?? 'backlog'); }

  getSort(key: string): { field: SortField; dir: SortDir } {
    return this.sprintSort()[key] ?? { field: null, dir: 'asc' };
  }

  setSortFor(key: string, field: SortField) {
    const cur = this.getSort(key);
    const next = cur.field === field
      ? { field, dir: (cur.dir === 'asc' ? 'desc' : 'asc') as SortDir }
      : { field, dir: 'asc' as SortDir };
    this.sprintSort.set({ ...this.sprintSort(), [key]: next });
  }

  // Há ordenação ativa OU ordem alterada por drag → permite restaurar
  hasCustomOrder(key: string): boolean {
    return this.getSort(key).field !== null || this.draggedGroups().has(key);
  }

  // Restaura a ordem original (desfaz sort e drag) do grupo
  resetOrder(key: string, event?: Event) {
    event?.stopPropagation();
    const map = { ...this.sprintSort() };
    delete map[key];
    this.sprintSort.set(map);

    const dragged = new Set(this.draggedGroups());
    dragged.delete(key);
    this.draggedGroups.set(dragged);

    // Reordena as tarefas do grupo pela ordem original e persiste
    const groupTasks = this.tasks()
      .filter(t => this.taskGroupKey(t) === key)
      .sort((a, b) => (this.originalOrder.get(a.id) ?? 0) - (this.originalOrder.get(b.id) ?? 0));

    const items = groupTasks.map((t, i) => ({ id: t.id, sort_order: i }));
    if (items.length) {
      // atualiza local
      const orderById = new Map(items.map(it => [it.id, it.sort_order]));
      this.tasks.set(this.tasks().map(t =>
        orderById.has(t.id) ? { ...t, sort_order: orderById.get(t.id) } : t
      ));
      this.apiService.reorderTasks(items).subscribe();
    }
  }

  private sortGroupTasks(tasks: any[], key: string): any[] {
    const { field, dir } = this.getSort(key);
    if (!field) {
      // sem sort → ordem por sort_order
      return [...tasks].sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
    }
    const d = dir === 'asc' ? 1 : -1;
    return [...tasks].sort((a, b) => {
      let av: any, bv: any;
      if (field === 'description') { av = this.titleFor(a).toLowerCase(); bv = this.titleFor(b).toLowerCase(); }
      else if (field === 'status') { av = (a.status?.name ?? '').toLowerCase(); bv = (b.status?.name ?? '').toLowerCase(); }
      else if (field === 'priority') {
        av = this.priorityOrder(a.priority);
        bv = this.priorityOrder(b.priority);
        return (av - bv) * d;
      }
      else if (field === 'assignee') { av = (a.assignees?.[0]?.name ?? '').toLowerCase(); bv = (b.assignees?.[0]?.name ?? '').toLowerCase(); }
      if (av < bv) return -1 * d;
      if (av > bv) return 1 * d;
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
      area: this.currentArea(),
    }).subscribe({
      next: (res) => {
        const list = Array.isArray(res) ? res : (res.data ?? []);
        this.tasks.set(list);
        // captura ordem original na primeira carga
        if (this.originalOrder.size === 0) {
          list.forEach((t: any, i: number) => this.originalOrder.set(t.id, i));
        } else {
          // garante que novas tarefas tenham posição no snapshot
          list.forEach((t: any) => { if (!this.originalOrder.has(t.id)) this.originalOrder.set(t.id, this.originalOrder.size); });
        }
        this.selectedIds.set(new Set());
        this.closeBulkDropdown();
        this.loading.set(false);
      },
      error: (err) => { console.error('Erro ao carregar tarefas:', err); this.loading.set(false); }
    });
  }

  loadAll() { this.loadSprints(); this.loadStatuses(); this.loadUsers(); this.loadTasks(); this.loadTags(); this.loadPriorities(); this.loadTaskTypes(); }

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
    this.apiService.getStatuses(this.boardId, this.currentArea()).subscribe({
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

  loadPriorities() {
    this.apiService.getPriorities(this.boardId, this.currentArea()).subscribe({
      next: (data) => this.priorities.set(data),
      error: () => {}
    });
  }

  loadTaskTypes() {
    this.apiService.getTaskTypes(this.boardId, this.currentArea()).subscribe({
      next: (data) => this.taskTypes.set(data),
      error: () => {}
    });
  }

  reloadTaskTypes() { this.loadTaskTypes(); }

  typeColor(name: string): string {
    if (!name) return '#6B6B70';
    return this.taskTypes().find(t => t.name === name)?.color || '#6B6B70';
  }

  // Nomes dos responsáveis além dos exibidos (para tooltip do +N)
  extraAssigneeNames(task: any, shown: number): string {
    return (task.assignees ?? []).slice(shown).map((a: any) => a.name).join(', ');
  }
  allAssigneeNames(task: any): string {
    return (task.assignees ?? []).map((a: any) => a.name).join(', ');
  }
  extraTagNames(task: any, shown: number): string {
    return (task.tags ?? []).slice(shown).map((t: any) => t.name).join(', ');
  }

  // ---------- Agrupamentos ----------

  groupedBySprint = computed(() => {
    const epicFilter = this.selectedEpics();
    const allTasks = epicFilter.length
      ? this.tasks().filter(t => t.epic && epicFilter.includes(t.epic))
      : this.tasks();

    const groups: { sprint: any | null; tasks: any[] }[] = [];
    // sprints já finalizadas somem da Tabela de Atividades — continuam disponíveis
    // (e reabríveis) na sub-aba "Sprints" do gerenciador.
    for (const sprint of this.sprints().filter(s => !s.finished_at)) {
      const key = this.groupKey(sprint);
      const sprintTasks = this.sortGroupTasks(allTasks.filter(t => t.sprint_id === sprint.id), key);
      groups.push({ sprint, tasks: sprintTasks });
    }
    const withoutSprint = this.sortGroupTasks(allTasks.filter(t => !t.sprint_id), 'backlog');
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

  private parseLocalDate(dateStr: string): Date {
    const [y, m, d] = dateStr.split('-').map(Number);
    return new Date(y, m - 1, d);
  }

  isSprintOverdue(sprint: any): boolean {
    if (!sprint?.end_date || sprint?.finished_at) return false;
    const end = this.parseLocalDate(sprint.end_date);
    const today = new Date(new Date().toDateString());
    return end < today;
  }

  sprintDaysRemaining(sprint: any): number | null {
    if (!sprint?.end_date || sprint?.finished_at) return null;
    const end = this.parseLocalDate(sprint.end_date);
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

  bulkDropdown = signal<'status' | 'priority' | 'type' | 'tags' | 'sprint' | 'assignee' | null>(null);
  bulkUpdating = signal(false);

  toggleBulkDropdown(type: 'status' | 'priority' | 'type' | 'tags' | 'sprint' | 'assignee') {
    this.bulkDropdown.set(this.bulkDropdown() === type ? null : type);
  }

  closeBulkDropdown() { this.bulkDropdown.set(null); }

  private runBulkUpdate(payload: Partial<{
    status_id: number | null; priority: string | null; type: string | null;
    sprint_id: number | null; add_tag_id: number; add_assignee_id: number;
  }>, label: string) {
    const ids = Array.from(this.selectedIds());
    if (!ids.length) return;
    this.bulkUpdating.set(true);
    this.closeBulkDropdown();

    this.apiService.bulkUpdateTasks({ task_ids: ids, ...payload }).subscribe({
      next: (updated: any[]) => {
        const byId = new Map(updated.map(t => [t.id, t]));
        this.tasks.set(this.tasks().map(t => byId.get(t.id) ?? t));
        this.bulkUpdating.set(false);
        this.showToast(`${ids.length} tarefa(s) atualizadas — ${label}`);
      },
      error: (err) => {
        console.error('Erro ao atualizar em massa:', err);
        this.bulkUpdating.set(false);
        this.loadTasks();
      }
    });
  }

  bulkSetStatus(status: any) {
    this.runBulkUpdate({ status_id: status.id }, status.name);
  }

  bulkSetPriority(priority: string) {
    this.runBulkUpdate({ priority }, priority);
  }

  bulkSetType(type: any) {
    this.runBulkUpdate({ type: type.name }, type.name);
  }

  bulkAddTag(tag: any) {
    this.runBulkUpdate({ add_tag_id: tag.id }, `tag "${tag.name}" adicionada`);
  }

  bulkAssigneeSearch = signal('');

  bulkAddAssignee(user: any) {
    this.runBulkUpdate({ add_assignee_id: user.id }, `atribuídas para ${user.name}`);
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
    this.apiService.bulkUpdateTasks({ task_ids: ids, sprint_id: sprintId }).subscribe({
      next: () => {
        this.movingToSprint.set(false);
        this.moveSprintModalOpen.set(false);
        this.selectedIds.set(new Set());
        this.loadTasks();
      },
      error: (err) => {
        console.error('Erro ao mover tarefa:', err);
        this.movingToSprint.set(false);
        this.moveSprintModalOpen.set(false);
        this.loadTasks();
      }
    });
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
    this.attachments.set([]);
    this.taskDialogOpen.set(true);
  }

  openEditTaskDialog(task: any) {
    this.dialogMode = 'edit';
    this.editingTask = task;
    this.taskDialogOpen.set(true);
    this.loadComments(task.id);
    this.loadAttachments(task.id);
  }

  closeTaskDialog() { this.taskDialogOpen.set(false); }

  confirmSaveTask(formValue: TaskFormValue) {
    this.saving.set(true);
    const isEdit = this.dialogMode === 'edit' && this.editingTask;
    // area só é definida na criação — edição não muda a área da tarefa
    const payload = isEdit
      ? { board_id: this.boardId, ...formValue }
      : { board_id: this.boardId, area: this.currentArea(), ...formValue };
    const request$ = isEdit
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

  // ---------- Arquivos compartilhados ----------

  attachments = signal<any[]>([]);
  uploadingAttachment = signal(false);

  loadAttachments(taskId: number) {
    this.apiService.getAttachments(taskId).subscribe({
      next: (data) => this.attachments.set(data),
      error: (err) => console.error('Erro ao carregar arquivos:', err)
    });
  }

  onUploadAttachment(files: File[]) {
    if (!this.editingTask || !files.length) return;
    const taskId = this.editingTask.id;
    this.uploadingAttachment.set(true);
    forkJoin(files.map((file) => this.apiService.uploadAttachment(taskId, file))).subscribe({
      next: () => { this.loadAttachments(taskId); this.uploadingAttachment.set(false); },
      error: (err) => {
        console.error('Erro ao enviar arquivo(s):', err);
        this.loadAttachments(taskId); // alguns podem ter subido antes do erro — recarrega pra refletir
        this.uploadingAttachment.set(false);
        this.showToast(files.length > 1 ? 'Não foi possível enviar todos os arquivos.' : 'Não foi possível enviar o arquivo.');
      }
    });
  }

  onRemoveAttachment(id: number) {
    if (!this.editingTask) return;
    this.apiService.deleteAttachment(id).subscribe({
      next: () => this.loadAttachments(this.editingTask.id),
      error: (err) => console.error('Erro ao excluir arquivo:', err)
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

  // Excluir a partir da modal de tarefa
  onDeleteFromDialog() {
    if (!this.editingTask) return;
    this.taskPendingDelete = this.editingTask;
    this.taskDialogOpen.set(false);
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

  // ---------- Popover unificado (status / prioridade / responsáveis / tags) ----------

  activePopover = signal<{
    type: 'status' | 'priority' | 'assignee' | 'tags' | 'type';
    taskId: number;
    top: number;
    left: number;
    placement: 'top' | 'bottom';
    arrowLeft: number;
  } | null>(null);

  popoverTask: any = null;
  popoverSearch = signal('');

  private readonly POP_DIMS: Record<string, { w: number; h: number }> = {
    status: { w: 240, h: 290 },
    priority: { w: 230, h: 240 },
    assignee: { w: 300, h: 380 },
    tags: { w: 300, h: 360 },
    type: { w: 230, h: 260 },
  };

  popWidth(type: string): number { return this.POP_DIMS[type]?.w ?? 260; }

  openPopover(type: 'status' | 'priority' | 'assignee' | 'tags' | 'type', task: any, event: Event) {
    event.stopPropagation();
    const cur = this.activePopover();
    if (cur && cur.type === type && cur.taskId === task.id) { this.closePopover(); return; }

    const el = event.currentTarget as HTMLElement;
    const rect = el.getBoundingClientRect();
    const { w, h } = this.POP_DIMS[type];
    const margin = 12;

    this.popoverTask = { ...task };
    this.popoverSearch.set('');

    // Horizontal: centraliza no gatilho, com clamp na viewport
    const triggerCenterX = rect.left + rect.width / 2;
    let left = triggerCenterX - w / 2;
    if (left < margin) left = margin;
    if (left + w > window.innerWidth - margin) left = window.innerWidth - w - margin;

    // Vertical: escolhe o lado com mais espaço
    const spaceBelow = window.innerHeight - rect.bottom;
    const spaceAbove = rect.top;
    let placement: 'top' | 'bottom';
    let top: number;
    if (spaceBelow >= h + margin || spaceBelow >= spaceAbove) {
      placement = 'bottom';
      top = rect.bottom + 10;
    } else {
      placement = 'top';
      top = Math.max(margin, rect.top - h - 10);
    }

    // Setinha aponta para o centro do gatilho, relativo ao painel
    let arrowLeft = triggerCenterX - left;
    arrowLeft = Math.max(16, Math.min(w - 16, arrowLeft));

    this.activePopover.set({ type, taskId: task.id, top, left, placement, arrowLeft });
  }

  closePopover() {
    this.activePopover.set(null);
    this.popoverTask = null;
  }

  @HostListener('document:keydown.escape')
  onEscKey() {
    if (this.activePopover()) this.closePopover();
  }

  @HostListener('document:click')
  onDocumentClick() {
    if (this.activePopover()) this.closePopover();
  }

  // Status / prioridade / tipo no popover unificado
  setPopoverField(field: 'status_id' | 'priority' | 'type', value: any) {
    if (!this.popoverTask) return;
    this.updateTaskField(this.popoverTask, field, value);
    this.closePopover();
  }

  // ---------- Responsáveis ----------

  // Compat: task-dialog chama manageAssignees sem event → abre centrado na tela
  openAssigneeModal(task: any, event?: Event) {
    if (event) {
      this.openPopover('assignee', task, event);
    } else {
      this.popoverTask = { ...task };
      this.popoverSearch.set('');
      const { w, h } = this.POP_DIMS['assignee'];
      this.activePopover.set({
        type: 'assignee', taskId: task.id, placement: 'bottom',
        arrowLeft: -100,
        top: Math.max(12, (window.innerHeight - h) / 2),
        left: Math.max(12, (window.innerWidth - w) / 2),
      });
    }
  }

  closeAssigneeModal() { this.closePopover(); }

  toggleAssignee(userId: number) {
    const task = this.popoverTask;
    if (!task) return;
    const current: number[] = (task.assignees ?? []).map((u: any) => Number(u.id));
    const updated = current.includes(Number(userId))
      ? current.filter(id => id !== Number(userId))
      : [...current, Number(userId)];
    const updatedUsers = this.users().filter(u => updated.includes(Number(u.id)));
    this.popoverTask = { ...task, assignees: updatedUsers };
    this.tasks.set(this.tasks().map(t => t.id === task.id ? this.popoverTask : t));
    if (this.editingTask && this.editingTask.id === task.id) this.editingTask = this.popoverTask;
    this.updateTaskAssignees(task, updated);
  }

  removeAssignee(userId: number, event?: Event) {
    event?.stopPropagation();
    this.toggleAssignee(userId);
  }

  isAssignee(userId: number): boolean {
    return (this.popoverTask?.assignees ?? []).some((u: any) => Number(u.id) === Number(userId));
  }

  suggestedUsers = computed(() => {
    const _ = this.activePopover(); // reatividade ao abrir/atualizar
    const selectedIds = new Set((this.popoverTask?.assignees ?? []).map((u: any) => Number(u.id)));
    const term = this.popoverSearch().trim().toLowerCase();
    return this.users().filter(u => {
      if (selectedIds.has(Number(u.id))) return false;
      if (!term) return true;
      return (u.name ?? '').toLowerCase().includes(term);
    });
  });

  // ---------- Tags na linha (popover) ----------

  toggleTaskTag(tagId: number) {
    const task = this.popoverTask;
    if (!task) return;
    const current: number[] = (task.tags ?? []).map((t: any) => Number(t.id));
    const updated = current.includes(Number(tagId))
      ? current.filter(id => id !== Number(tagId))
      : [...current, Number(tagId)];
    const updatedTags = this.tags().filter(t => updated.includes(Number(t.id)));
    this.popoverTask = { ...task, tags: updatedTags };
    this.tasks.set(this.tasks().map(t => t.id === task.id ? this.popoverTask : t));
    if (this.editingTask && this.editingTask.id === task.id) this.editingTask = this.popoverTask;
    this.apiService.updateTask(task.id, { tag_ids: updated }).subscribe({
      next: (u) => this.tasks.set(this.tasks().map(t => t.id === task.id ? u : t)),
      error: (err) => console.error('Erro ao atualizar tags:', err)
    });
  }

  removeTaskTag(tagId: number, event?: Event) {
    event?.stopPropagation();
    this.toggleTaskTag(tagId);
  }

  isTaskTag(tagId: number): boolean {
    return (this.popoverTask?.tags ?? []).some((t: any) => Number(t.id) === Number(tagId));
  }

  suggestedTags = computed(() => {
    const _ = this.activePopover();
    const selectedIds = new Set((this.popoverTask?.tags ?? []).map((t: any) => Number(t.id)));
    const term = this.popoverSearch().trim().toLowerCase();
    return this.tags().filter(t => {
      if (selectedIds.has(Number(t.id))) return false;
      if (!term) return true;
      return (t.name ?? '').toLowerCase().includes(term);
    });
  });

  // Cores para novas tags criadas inline
  private readonly TAG_PALETTE = [
    '#4F46E5', '#0284C7', '#059669', '#D97706', '#DC2626',
    '#7C3AED', '#DB2777', '#0891B2', '#16A34A', '#EA580C',
  ];

  // Termo digitado pode virar nova tag? (não existe exatamente)
  canCreateTag = computed(() => {
    const _ = this.activePopover();
    const term = this.popoverSearch().trim();
    if (!term) return false;
    return !this.tags().some(t => (t.name ?? '').toLowerCase() === term.toLowerCase());
  });

  creatingTag = signal(false);

  createTagInline() {
    const term = this.popoverSearch().trim();
    if (!term || this.creatingTag()) return;
    this.creatingTag.set(true);
    const color = this.TAG_PALETTE[this.tags().length % this.TAG_PALETTE.length];
    this.apiService.createTag({ board_id: this.boardId, name: term, color }).subscribe({
      next: (tag: any) => {
        this.tags.set([...this.tags(), tag]);
        this.popoverSearch.set('');
        this.creatingTag.set(false);
        // aplica imediatamente à tarefa
        this.toggleTaskTag(tag.id);
      },
      error: (err) => { console.error('Erro ao criar tag:', err); this.creatingTag.set(false); }
    });
  }

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
    const newSprintId = targetGroup.sprint?.id ?? null;
    const targetKey = this.groupKey(targetGroup.sprint);

    if (event.previousContainer === event.container) {
      moveItemInArray(targetList, event.previousIndex, event.currentIndex);
    } else {
      transferArrayItem(sourceList, targetList, event.previousIndex, event.currentIndex);
      const task = targetList[event.currentIndex];
      task.sprint_id = newSprintId;
      this.apiService.updateTask(task.id, { sprint_id: newSprintId }).subscribe();
    }

    // marca grupo como reordenado manualmente
    const dragged = new Set(this.draggedGroups());
    dragged.add(targetKey);
    this.draggedGroups.set(dragged);

    // persiste a ordem e atualiza o sort_order local para fixar a ordem
    const items = targetList.map((t, i) => ({ id: t.id, sort_order: i }));
    const orderById = new Map(items.map(it => [it.id, it.sort_order]));
    this.tasks.set(this.tasks().map(t =>
      orderById.has(t.id)
        ? { ...t, sort_order: orderById.get(t.id), sprint_id: t.id === targetList[event.currentIndex]?.id ? newSprintId : t.sprint_id }
        : t
    ));
    this.apiService.reorderTasks(items).subscribe();
  }

  // ---------- Kanban (colunas por status) ----------

  // Largura total do conteúdo do board — usada pra dar ao scrollbar-espelho do
  // topo a mesma extensão de rolagem do board de verdade (colunas: 322px + gap 20px).
  kanbanContentWidth = computed(() => {
    const n = this.kanbanColumns().length;
    return n > 0 ? n * 322 + (n - 1) * 20 : 0;
  });

  @ViewChild('kanbanScrollTop') kanbanScrollTopRef?: ElementRef<HTMLDivElement>;
  @ViewChild('kanbanScrollMain') kanbanScrollMainRef?: ElementRef<HTMLDivElement>;
  private syncingKanbanScroll = false;

  onKanbanTopScroll(event: Event) {
    if (this.syncingKanbanScroll) return;
    this.syncingKanbanScroll = true;
    const main = this.kanbanScrollMainRef?.nativeElement;
    if (main) main.scrollLeft = (event.target as HTMLElement).scrollLeft;
    this.syncingKanbanScroll = false;
  }

  onKanbanMainScroll(event: Event) {
    if (this.syncingKanbanScroll) return;
    this.syncingKanbanScroll = true;
    const top = this.kanbanScrollTopRef?.nativeElement;
    if (top) top.scrollLeft = (event.target as HTMLElement).scrollLeft;
    this.syncingKanbanScroll = false;
  }

  kanbanColumns = computed(() => {
    const tasks = this.tasks();
    const bySort = (a: any, b: any) => (a.sort_order ?? 0) - (b.sort_order ?? 0);

    const cols: { status: any; tasks: any[] }[] = this.statuses().map(s => ({
      status: s,
      tasks: tasks.filter(t => t.status_id === s.id).sort(bySort),
    }));

    const noStatus = tasks.filter(t => !t.status_id).sort(bySort);
    if (noStatus.length > 0) {
      cols.unshift({ status: null, tasks: noStatus });
    }
    return cols;
  });

  kanbanDropIds = computed(() =>
    this.kanbanColumns().map(c => 'kanban-' + (c.status?.id ?? 'none'))
  );

  kanbanDropId(col: any): string {
    return 'kanban-' + (col.status?.id ?? 'none');
  }

  onKanbanDrop(event: CdkDragDrop<any[]>, targetCol: any) {
    const task = event.item.data;
    const sameCol = event.previousContainer === event.container;

    if (sameCol) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
    } else {
      transferArrayItem(event.previousContainer.data, event.container.data, event.previousIndex, event.currentIndex);
    }

    const newStatusId = targetCol.status?.id ?? null;
    const items = event.container.data.map((t: any, i: number) => ({ id: t.id, sort_order: i }));
    const orderById = new Map(items.map((it: any) => [it.id, it.sort_order]));

    this.tasks.set(this.tasks().map(t => {
      const patch: any = {};
      if (orderById.has(t.id)) patch.sort_order = orderById.get(t.id);
      if (t.id === task.id && !sameCol) {
        patch.status_id = newStatusId;
        patch.status = targetCol.status;
        patch.completed_at = targetCol.status?.name && /conclu/i.test(targetCol.status.name)
          ? (t.completed_at ?? new Date().toISOString())
          : null;
      }
      return Object.keys(patch).length ? { ...t, ...patch } : t;
    }));

    if (!sameCol) {
      this.apiService.updateTask(task.id, { status_id: newStatusId }).subscribe({
        next: (updated) => {
          this.tasks.set(this.tasks().map(t => t.id === updated.id ? { ...t, ...updated } : t));
          if (updated.status?.name && /conclu/i.test(updated.status.name)) {
            const msg = this.MOTIVATIONAL_COMPLETE[Math.floor(Math.random() * this.MOTIVATIONAL_COMPLETE.length)];
            this.showToast(msg);
          }
        },
        error: () => this.loadTasks(),
      });
    }

    this.apiService.reorderTasks(items).subscribe({ error: () => this.loadTasks() });
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
        area: this.currentArea(),
        titulo: (item.titulo ?? item.description).trim().slice(0, 150),
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

  // Ordem da prioridade pela posição no banco (maior 'order' = mais alta, ordena primeiro)
  priorityOrder(priority: string): number {
    const list = this.priorities();
    const idx = list.findIndex(x => x.name === priority);
    if (idx === -1) return 999;
    // inverte: prioridades com maior 'order' (mais críticas) vêm primeiro no asc
    return list.length - idx;
  }

  // Resolve a cor da prioridade pela lista do banco (fallback p/ mapa legado)
  priorityColor(priority: string): string {
    if (!priority) return '#6B6B70';
    const p = this.priorities().find(x => x.name === priority);
    if (p?.color) return p.color;
    const legacy: Record<string, string> = {
      'Baixa': '#059669', 'Média': '#0284C7', 'Alta': '#EA580C', 'Urgente': '#DC2626',
    };
    return legacy[priority] || '#6B6B70';
  }

  summaryFor(description: string | undefined | null): string {
    if (!description) return '(sem descrição)';
    const trimmed = description.trim();
    const maxLength = 200;
    if (trimmed.length <= maxLength) return trimmed;
    return trimmed.slice(0, maxLength).trimEnd() + '…';
  }

  // Título curto exibido no card/linha — usa o campo dedicado `titulo`;
  // cai pra descrição só como salvaguarda (tarefa antiga sem titulo preenchido).
  titleFor(task: any): string {
    return task?.titulo?.trim() || this.summaryFor(task?.description);
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
