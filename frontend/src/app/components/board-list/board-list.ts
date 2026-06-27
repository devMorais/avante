import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';
import { Router } from '@angular/router';

import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';

import { Popover } from '../../shared/ui/popover/popover';
import { Modal } from '../../shared/ui/modal/modal';
import { Button } from '../../shared/ui/button/button';
import { ConfirmDialog } from '../../shared/ui/confirm-dialog/confirm-dialog';
import { UserManager } from '../user-manager/user-manager';
import { Sidebar } from '../../shared/ui/sidebar/sidebar';



const ACCENT_PALETTE = [
  { bg: '#EEF2FF', fg: '#4F46E5' }, // índigo
  { bg: '#ECFDF5', fg: '#059669' }, // verde
  { bg: '#FFF7ED', fg: '#EA580C' }, // laranja
  { bg: '#FDF2F8', fg: '#DB2777' }, // rosa
  { bg: '#F0F9FF', fg: '#0284C7' }, // azul
  { bg: '#FAF5FF', fg: '#9333EA' }, // roxo
  { bg: '#FFFBEB', fg: '#D97706' }, // âmbar
  { bg: '#F0FDFA', fg: '#0D9488' }, // teal
];

function accentFor(name: string) {
  let hash = 0;
  for (let i = 0; i < name.length; i++) {
    hash = name.charCodeAt(i) + ((hash << 5) - hash);
  }
  const index = Math.abs(hash) % ACCENT_PALETTE.length;
  return ACCENT_PALETTE[index];
}

function initialsFor(name: string) {
  const words = name.trim().split(/\s+/).filter(Boolean);
  if (words.length === 0) return '?';
  if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
  return (words[0][0] + words[1][0]).toUpperCase();
}

@Component({
  selector: 'app-board-list',
  standalone: true,
  imports: [
    CommonModule, FormsModule, MatInputModule, MatFormFieldModule, MatIconModule,
    Popover, Modal, Button, ConfirmDialog, UserManager, Sidebar
  ],
  templateUrl: './board-list.html',
  styleUrl: './board-list.scss'
})
export class BoardListComponent implements OnInit {
  boards = signal<any[]>([]);
  searchTerm = signal('');

  // Estado do modal de criar/editar
  boardDialogOpen = signal(false);
  dialogMode: 'create' | 'edit' = 'create';
  editingBoardId: number | null = null;
  newBoardName = '';
  saving = signal(false);
  imagePreview = signal<string | null>(null);
  selectedFile: File | null = null;

  // Estado do modal de confirmação de exclusão
  deleteDialogOpen = signal(false);
  boardPendingDelete: any = null;
  deleting = signal(false);

  sidebarCollapsed = signal(false);
  section = signal<'boards' | 'users' | 'archived'>('boards');

  comingSoonToast = signal('');

  showArchived = signal(false);

  toggleArchivedSection() {
    this.showArchived.set(!this.showArchived());
  }

  toggleSidebar() {
    this.sidebarCollapsed.set(!this.sidebarCollapsed());
  }

  setSection(section: 'boards' | 'users' | 'archived') {
    this.section.set(section);
  }

  showComingSoon(feature: string) {
    this.comingSoonToast.set(`🚀 ${feature} — Funcionalidade em evolução. Em breve!`);
    setTimeout(() => this.comingSoonToast.set(''), 3500);
  }

  constructor(
    private apiService: ApiService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.loadBoards();
  }

  loadBoards() {
    this.apiService.getBoards().subscribe({
      next: (data) => this.boards.set(data),
      error: (err) => console.error('Erro:', err)
    });
  }

  private matchesSearch(list: any[]) {
    const term = this.searchTerm().trim().toLowerCase();
    if (!term) return list;
    return list.filter(b => b.name.toLowerCase().includes(term));
  }

  // Quadros ativos (não arquivados)
  filteredBoards() {
    return this.matchesSearch(this.boards().filter(b => !b.archived_at));
  }

  // Quadros arquivados
  filteredArchivedBoards() {
    return this.matchesSearch(this.boards().filter(b => !!b.archived_at));
  }

  archivedCount() {
    return this.boards().filter(b => !!b.archived_at).length;
  }

  accentFor = accentFor;
  initialsFor = initialsFor;

  // ---------- Criar ----------

  openAddBoardDialog() {
    this.dialogMode = 'create';
    this.editingBoardId = null;
    this.newBoardName = '';
    this.selectedFile = null;
    this.imagePreview.set(null);
    this.boardDialogOpen.set(true);
  }

  // ---------- Editar ----------

  openEditBoardDialog(board: any, event?: Event) {
    event?.stopPropagation();
    this.dialogMode = 'edit';
    this.editingBoardId = board.id;
    this.newBoardName = board.name;
    this.selectedFile = null;
    this.imagePreview.set(board.icon_url || null);
    this.boardDialogOpen.set(true);
  }

  closeBoardDialog() {
    this.boardDialogOpen.set(false);
  }

  onFileSelected(event: Event) {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    if (!file) return;

    this.selectedFile = file;
    const reader = new FileReader();
    reader.onload = () => this.imagePreview.set(reader.result as string);
    reader.readAsDataURL(file);
  }

  removeSelectedImage() {
    this.selectedFile = null;
    this.imagePreview.set(null);
  }

  confirmSaveBoard() {
    if (!this.newBoardName.trim() || this.saving()) return;

    this.saving.set(true);
    const formData = new FormData();
    formData.append('name', this.newBoardName.trim());
    if (this.selectedFile) {
      formData.append('image', this.selectedFile);
    }

    const request$ = this.dialogMode === 'edit' && this.editingBoardId
      ? this.apiService.updateBoard(this.editingBoardId, formData)
      : this.apiService.createBoard(formData);

    request$.subscribe({
      next: () => {
        this.apiService.getBoards().subscribe({
          next: (data) => {
            this.boards.set(data);
            this.saving.set(false);
            this.boardDialogOpen.set(false);
          },
          error: (err) => {
            console.error('Erro ao recarregar quadros:', err);
            this.saving.set(false);
            this.boardDialogOpen.set(false);
          }
        });
      },
      error: (err) => {
        console.error('Erro ao salvar quadro:', err);
        this.saving.set(false);
      }
    });
  }

  // ---------- Excluir ----------

  openDeleteDialog(board: any, event?: Event) {
    event?.stopPropagation();
    this.boardPendingDelete = board;
    this.deleteDialogOpen.set(true);
  }

  closeDeleteDialog() {
    this.deleteDialogOpen.set(false);
  }

  confirmDeleteBoard() {
    if (!this.boardPendingDelete || this.deleting()) return;

    this.deleting.set(true);
    this.apiService.deleteBoard(this.boardPendingDelete.id).subscribe({
      next: () => {
        this.boards.set(this.boards().filter(b => b.id !== this.boardPendingDelete.id));
        this.deleting.set(false);
        this.boardPendingDelete = null;
        this.deleteDialogOpen.set(false);
      },
      error: (err) => {
        console.error('Erro ao excluir quadro:', err);
        this.deleting.set(false);
      }
    });
  }

  // ---------- Arquivar / Restaurar ----------

  archiveBoard(board: any, event?: Event) {
    event?.stopPropagation();
    this.apiService.archiveBoard(board.id).subscribe({
      next: (updated) => {
        this.boards.set(this.boards().map(b => b.id === board.id ? { ...b, archived_at: updated.archived_at } : b));
      },
      error: (err) => console.error('Erro ao arquivar quadro:', err)
    });
  }

  unarchiveBoard(board: any, event?: Event) {
    event?.stopPropagation();
    this.apiService.unarchiveBoard(board.id).subscribe({
      next: () => {
        this.boards.set(this.boards().map(b => b.id === board.id ? { ...b, archived_at: null } : b));
      },
      error: (err) => console.error('Erro ao restaurar quadro:', err)
    });
  }

  openBoard(boardId: number) {
    this.router.navigate(['/board', boardId]);
  }
}
