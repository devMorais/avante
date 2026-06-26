import {
  Component, Input, Output, EventEmitter, OnInit,
  signal, computed, HostListener, ElementRef
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

export interface TaskFilterValue {
  search: string;
  status_ids: number[];
  priorities: string[];
  assignee_ids: number[];
  epics: string[];
}

@Component({
  selector: 'app-task-filters',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './task-filters.html',
  styleUrl: './task-filters.scss'
})
export class TaskFilters implements OnInit {
  @Input() statuses: any[] = [];
  @Input() users: any[] = [];
  @Input() epics: string[] = [];

  @Output() filtersChange = new EventEmitter<TaskFilterValue>();

  // Estado interno dos filtros
  search = signal('');
  selectedStatusIds = signal<number[]>([]);
  selectedPriorities = signal<string[]>([]);
  selectedAssigneeIds = signal<number[]>([]);
  selectedEpics = signal<string[]>([]);

  // Controle de dropdowns abertos
  openDropdown = signal<'status' | 'priority' | 'assignee' | 'epic' | null>(null);

  // Busca interna dos dropdowns
  statusSearch = signal('');
  assigneeSearch = signal('');
  epicSearch = signal('');

  priorities = ['Baixa', 'Média', 'Alta', 'Urgente'];

  priorityColors: Record<string, string> = {
    'Baixa': '#059669',
    'Média': '#0284C7',
    'Alta': '#EA580C',
    'Urgente': '#DC2626',
  };

  constructor(private elRef: ElementRef) { }

  ngOnInit() { }

  // Computed: listas filtradas pelos campos de busca internos
  filteredStatuses = computed(() => {
    const term = this.statusSearch().toLowerCase().trim();
    if (!term) return this.statuses;
    return this.statuses.filter(s => s.name.toLowerCase().includes(term));
  });

  filteredUsers = computed(() => {
    const term = this.assigneeSearch().toLowerCase().trim();
    if (!term) return this.users;
    return this.users.filter(u => u.name.toLowerCase().includes(term));
  });

  filteredEpics = computed(() => {
    const term = this.epicSearch().toLowerCase().trim();
    if (!term) return this.epics;
    return this.epics.filter(e => e.toLowerCase().includes(term));
  });

  // Computed: chips ativos para exibição abaixo da barra
  activeChips = computed(() => {
    const chips: { type: 'status' | 'priority' | 'assignee' | 'epic'; id: number | string; label: string }[] = [];

    this.selectedStatusIds().forEach(id => {
      const s = this.statuses.find(s => Number(s.id) === Number(id));
      if (s) chips.push({ type: 'status', id, label: s.name });
    });

    this.selectedPriorities().forEach(p => {
      chips.push({ type: 'priority', id: p, label: p });
    });

    this.selectedAssigneeIds().forEach(id => {
      const u = this.users.find(u => Number(u.id) === Number(id));
      if (u) chips.push({ type: 'assignee', id, label: u.name });
    });

    this.selectedEpics().forEach(e => {
      chips.push({ type: 'epic', id: e, label: e });
    });

    return chips;
  });

  hasActiveFilters = computed(() =>
    this.search().trim() !== '' ||
    this.selectedStatusIds().length > 0 ||
    this.selectedPriorities().length > 0 ||
    this.selectedAssigneeIds().length > 0 ||
    this.selectedEpics().length > 0
  );

  // Fechar dropdown ao clicar fora
  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    const target = event.target as HTMLElement;
    // Não fecha se o clique foi dentro de um popover-wrapper
    if (target.closest('app-popover') || target.closest('.popover-panel')) {
      return;
    }
    if (!this.elRef.nativeElement.contains(target)) {
      this.openDropdown.set(null);
    }
  }

  toggleDropdown(name: 'status' | 'priority' | 'assignee' | 'epic') {
    this.openDropdown.set(this.openDropdown() === name ? null : name);
    if (this.openDropdown() === null) {
      this.statusSearch.set('');
      this.assigneeSearch.set('');
      this.epicSearch.set('');
    }
  }

  // Toggle de itens nos filtros
  toggleStatus(id: number) {
    const current = this.selectedStatusIds();
    const next = current.includes(Number(id))
      ? current.filter(i => i !== Number(id))
      : [...current, Number(id)];
    this.selectedStatusIds.set(next);
    this.emit();
  }

  togglePriority(p: string) {
    const current = this.selectedPriorities();
    const next = current.includes(p)
      ? current.filter(i => i !== p)
      : [...current, p];
    this.selectedPriorities.set(next);
    this.emit();
  }

  toggleAssignee(id: number) {
    const current = this.selectedAssigneeIds();
    const next = current.includes(Number(id))
      ? current.filter(i => i !== Number(id))
      : [...current, Number(id)];
    this.selectedAssigneeIds.set(next);
    this.emit();
  }

  toggleEpic(epic: string) {
    const current = this.selectedEpics();
    const next = current.includes(epic)
      ? current.filter(e => e !== epic)
      : [...current, epic];
    this.selectedEpics.set(next);
    this.emit();
  }

  isEpicSelected(epic: string): boolean {
    return this.selectedEpics().includes(epic);
  }

  isStatusSelected(id: number): boolean {
    return this.selectedStatusIds().includes(Number(id));
  }

  isPrioritySelected(p: string): boolean {
    return this.selectedPriorities().includes(p);
  }

  isAssigneeSelected(id: number): boolean {
    return this.selectedAssigneeIds().includes(Number(id));
  }

  // Remove chip individual
  removeChip(chip: { type: string; id: number | string }) {
    if (chip.type === 'status') {
      this.selectedStatusIds.set(this.selectedStatusIds().filter(i => i !== Number(chip.id)));
    } else if (chip.type === 'priority') {
      this.selectedPriorities.set(this.selectedPriorities().filter(p => p !== chip.id));
    } else if (chip.type === 'assignee') {
      this.selectedAssigneeIds.set(this.selectedAssigneeIds().filter(i => i !== Number(chip.id)));
    } else if (chip.type === 'epic') {
      this.selectedEpics.set(this.selectedEpics().filter(e => e !== chip.id));
    }
    this.emit();
  }

  onSearchInput(value: string) {
    this.search.set(value);
    this.emit();
  }

  clearAll() {
    this.search.set('');
    this.selectedStatusIds.set([]);
    this.selectedPriorities.set([]);
    this.selectedAssigneeIds.set([]);
    this.selectedEpics.set([]);
    this.openDropdown.set(null);
    this.emit();
  }

  private emit() {
    this.filtersChange.emit({
      search: this.search(),
      status_ids: this.selectedStatusIds(),
      priorities: this.selectedPriorities(),
      assignee_ids: this.selectedAssigneeIds(),
      epics: this.selectedEpics(),
    });
  }

  initialsFor(name: string): string {
    if (!name) return '?';
    const words = name.trim().split(/\s+/).filter(Boolean);
    if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}
