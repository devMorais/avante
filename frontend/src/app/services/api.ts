import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';


const API_URL = environment.apiUrl;
const BACKEND_URL = environment.backendUrl;

export function resolveAvatarUrl(url: string | null | undefined): string | null {
  if (!url) return null;
  if (url.startsWith('http')) return url;          // já absoluta
  return `${BACKEND_URL}${url}`;                   // /storage/... → URL completa
}

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  constructor(private http: HttpClient) { }

  // ---------- Boards ----------

  getBoards(): Observable<any> {
    return this.http.get(`${API_URL}/boards`);
  }

  getBoard(id: number): Observable<any> {
    return this.http.get(`${API_URL}/boards/${id}`);
  }

  createBoard(data: FormData): Observable<any> {
    return this.http.post(`${API_URL}/boards`, data);
  }

  updateBoard(id: number, data: FormData): Observable<any> {
    data.append('_method', 'PUT');
    return this.http.post(`${API_URL}/boards/${id}`, data);
  }

  deleteBoard(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/boards/${id}`);
  }

  archiveBoard(id: number): Observable<any> {
    return this.http.patch(`${API_URL}/boards/${id}/archive`, {});
  }

  unarchiveBoard(id: number): Observable<any> {
    return this.http.patch(`${API_URL}/boards/${id}/unarchive`, {});
  }

  // ---------- Tasks ----------

  getTasks(boardId: number, params: {
    page?: number;
    per_page?: number;
    search?: string;
    status_ids?: number[];
    priorities?: string[];
    assignee_ids?: number[];
    tag_ids?: number[];
  } = {}): Observable<any> {
    let query = `board_id=${boardId}`;

    if (params.page) query += `&page=${params.page}`;
    if (params.per_page) query += `&per_page=${params.per_page}`;
    if (params.search) query += `&search=${encodeURIComponent(params.search)}`;

    if (params.status_ids?.length) {
      params.status_ids.forEach(id => query += `&status_ids[]=${id}`);
    }
    if (params.priorities?.length) {
      params.priorities.forEach(p => query += `&priorities[]=${encodeURIComponent(p)}`);
    }
    if (params.assignee_ids?.length) {
      params.assignee_ids.forEach(id => query += `&assignee_ids[]=${id}`);
    }
    if (params.tag_ids?.length) {
      params.tag_ids.forEach(id => query += `&tag_ids[]=${id}`);
    }

    return this.http.get(`${API_URL}/tasks?${query}`);
  }

  createTask(data: any): Observable<any> {
    return this.http.post(`${API_URL}/tasks`, data);
  }

  updateTask(id: number, data: any): Observable<any> {
    return this.http.put(`${API_URL}/tasks/${id}`, data);
  }

  deleteTask(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/tasks/${id}`);
  }

  // ---------- Sprints ----------

  getSprints(boardId: number): Observable<any> {
    return this.http.get(`${API_URL}/sprints?board_id=${boardId}`);
  }

  createSprint(data: any): Observable<any> {
    return this.http.post(`${API_URL}/sprints`, data);
  }

  updateSprint(id: number, data: any): Observable<any> {
    return this.http.put(`${API_URL}/sprints/${id}`, data);
  }

  deleteSprint(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/sprints/${id}`);
  }

  // ---------- Users ----------

  getUsers(): Observable<any> {
    return this.http.get(`${API_URL}/users`);
  }

  createUser(data: any): Observable<any> {
    return this.http.post(`${API_URL}/users`, data);
  }

  updateUser(id: number, data: any): Observable<any> {
    return this.http.put(`${API_URL}/users/${id}`, data);
  }

  deleteUser(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/users/${id}`);
  }

  getStatuses(boardId: number): Observable<any> {
    return this.http.get(`${API_URL}/statuses?board_id=${boardId}`);
  }

  createStatus(data: any): Observable<any> {
    return this.http.post(`${API_URL}/statuses`, data);
  }

  updateStatus(id: number, data: any): Observable<any> {
    return this.http.put(`${API_URL}/statuses/${id}`, data);
  }

  deleteStatus(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/statuses/${id}`);
  }

  // ---------- Comments ----------

  getComments(taskId: number): Observable<any> {
    return this.http.get(`${API_URL}/tasks/${taskId}/comments`);
  }

  createComment(taskId: number, data: any): Observable<any> {
    return this.http.post(`${API_URL}/tasks/${taskId}/comments`, data);
  }

  deleteComment(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/comments/${id}`);
  }

  // ---------- Auth ----------

  login(data: any): Observable<any> {
    return this.http.post(`${API_URL}/login`, data);
  }

  logout(): Observable<any> {
    return this.http.post(`${API_URL}/logout`, {});
  }

  getProfile(): Observable<any> {
    return this.http.get(`${API_URL}/profile`);
  }

  updateProfile(data: any): Observable<any> {
    return this.http.put(`${API_URL}/profile`, data);
  }

  updatePassword(data: any): Observable<any> {
    return this.http.post(`${API_URL}/profile/password`, data);
  }

  uploadAvatar(file: File): Observable<any> {
    const formData = new FormData();
    formData.append('avatar', file);
    return this.http.post(`${API_URL}/profile/avatar`, formData);
  }

  finishSprint(sprintId: number, body: { concluded_status_id: number | null }) {
    return this.http.post<any>(`${API_URL}/sprints/${sprintId}/finish`, body);
  }

  // ---------- Reorder ----------

  reorderStatuses(items: { id: number; order: number }[]): Observable<any> {
    return this.http.put(`${API_URL}/statuses/reorder`, { items });
  }

  reorderPriorities(items: { id: number; order: number }[]): Observable<any> {
    return this.http.put(`${API_URL}/priorities/reorder`, { items });
  }

  reorderTasks(items: { id: number; sort_order: number }[]): Observable<any> {
    return this.http.post(`${API_URL}/tasks/reorder`, { items });
  }

  // ---------- Priorities ----------

  getPriorities(boardId: number): Observable<any> {
    return this.http.get(`${API_URL}/priorities?board_id=${boardId}`);
  }

  createPriority(data: { board_id: number; name: string; color: string }): Observable<any> {
    return this.http.post(`${API_URL}/priorities`, data);
  }

  updatePriority(id: number, data: { name?: string; color?: string; order?: number }): Observable<any> {
    return this.http.put(`${API_URL}/priorities/${id}`, data);
  }

  deletePriority(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/priorities/${id}`);
  }

  // ---------- Task types (tipos) ----------

  getTaskTypes(boardId: number): Observable<any> {
    return this.http.get(`${API_URL}/task-types?board_id=${boardId}`);
  }

  createTaskType(data: { board_id: number; name: string; color: string }): Observable<any> {
    return this.http.post(`${API_URL}/task-types`, data);
  }

  updateTaskType(id: number, data: { name?: string; color?: string; order?: number }): Observable<any> {
    return this.http.put(`${API_URL}/task-types/${id}`, data);
  }

  deleteTaskType(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/task-types/${id}`);
  }

  reorderTaskTypes(items: { id: number; order: number }[]): Observable<any> {
    return this.http.put(`${API_URL}/task-types/reorder`, { items });
  }

  // ---------- Tags ----------

  getTags(boardId: number): Observable<any> {
    return this.http.get(`${API_URL}/tags?board_id=${boardId}`);
  }

  createTag(data: { board_id: number; name: string; color: string }): Observable<any> {
    return this.http.post(`${API_URL}/tags`, data);
  }

  updateTag(id: number, data: { name?: string; color?: string }): Observable<any> {
    return this.http.put(`${API_URL}/tags/${id}`, data);
  }

  deleteTag(id: number): Observable<any> {
    return this.http.delete(`${API_URL}/tags/${id}`);
  }
}
