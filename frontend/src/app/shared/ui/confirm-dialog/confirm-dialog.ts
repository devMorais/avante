import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';

import { Modal } from '../modal/modal';
import { Button } from '../button/button';

/**
 * Modal de confirmação genérico, reutilizável em todo o sistema
 * (excluir quadro, atividade, sprint, status, etc).
 *
 * Uso:
 * <app-confirm-dialog
 *   [isOpen]="deleteDialogOpen()"
 *   title="Excluir atividade?"
 *   message="Esta ação não pode ser desfeita."
 *   [loading]="deleting()"
 *   (confirm)="reallyDelete()"
 *   (cancel)="deleteDialogOpen.set(false)"
 * ></app-confirm-dialog>
 */
@Component({
  selector: 'app-confirm-dialog',
  standalone: true,
  imports: [CommonModule, Modal, Button],
  templateUrl: './confirm-dialog.html',
  styleUrl: './confirm-dialog.scss'
})
export class ConfirmDialog {
  @Input() isOpen = false;
  @Input() title = 'Tem certeza?';
  @Input() itemName: string | null = null; // nome do item a excluir, vira <strong> na mensagem

  @Input() message = 'Essa ação não pode ser desfeita.';
  @Input() confirmLabel = 'Excluir';
  @Input() cancelLabel = 'Cancelar';
  @Input() loading = false;

  @Output() confirm = new EventEmitter<void>();
  @Output() cancel = new EventEmitter<void>();

  onConfirm() {
    if (this.loading) return;
    this.confirm.emit();
  }

  onCancel() {
    if (this.loading) return;
    this.cancel.emit();
  }
}
