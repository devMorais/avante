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
  @Input() task: any = null; // a tarefa sendo editada (null em modo "create")
  @Input() statuses: any[] = [];
  @Input() sprints: any[] = [];
  @Input() saving = false;

  // Comentários
  @Input() comments: any[] = [];
  @Input() savingComment = false;

  @Output() closeDialog = new EventEmitter<void>();
  @Output() save = new EventEmitter<TaskFormValue>();
  @Output() addComment = new EventEmitter<{ content: string }>();
  @Output() removeComment = new EventEmitter<number>();
  @Output() manageAssignees = new EventEmitter<void>();

  priorities = PRIORITIES;

  activeTab: 'details' | 'comments' = 'details';

  formDescription = '';
  formStatusId: number | null = null;
  formPriority = 'Média';
  formSprintId: number | null = null;

  commentContent = '';

  // Sempre que o modal abrir (isOpen muda para true) ou a tarefa mudar,
  // repopula o formulário com os dados certos.
  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isOpen']?.currentValue === true) {
      this.resetForm();
    }
  }

  private resetForm() {
    this.activeTab = 'details';

    if (this.mode === 'edit' && this.task) {
      this.formDescription = this.task.description ?? '';
      this.formStatusId = this.task.status_id;
      this.formPriority = this.task.priority ?? 'Média';
      this.formSprintId = this.task.sprint_id;
    } else {
      this.formDescription = '';
      this.formStatusId = this.statuses[0]?.id ?? null;
      this.formPriority = 'Média';
      this.formSprintId = null;
    }

    this.commentContent = '';
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
}
