import { Routes } from '@angular/router';
import { BoardListComponent } from './components/board-list/board-list';
import { TaskListComponent } from './components/task-list/task-list';
import { Login } from './components/login/login';
import { ProfileComponent } from './components/profile/profile';
import { authGuard } from './guards/auth-guard';

export const routes: Routes = [
  { path: 'login', component: Login },
  { path: '', component: BoardListComponent, canActivate: [authGuard] },
  { path: 'board/:id', component: TaskListComponent, canActivate: [authGuard] },
  { path: 'profile', component: ProfileComponent, canActivate: [authGuard] },
];
