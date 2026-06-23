import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';

import { Auth } from '../../services/auth';
import { Button } from '../../shared/ui/button/button';

@Component({
  selector: 'app-login',
  imports: [CommonModule, FormsModule, Button],
  templateUrl: './login.html',
  styleUrl: './login.scss',
})
export class Login {
  email = '';
  password = '';
  loading = false;
  errorMessage = '';

  constructor(private auth: Auth, private router: Router) { }

  onSubmit() {
    if (!this.email.trim() || !this.password.trim() || this.loading) return;

    this.loading = true;
    this.errorMessage = '';

    this.auth.login(this.email.trim(), this.password).subscribe({
      next: () => {
        this.loading = false;
        this.router.navigate(['/']);
      },
      error: () => {
        this.loading = false;
        this.errorMessage = 'E-mail ou senha incorretos.';
      },
    });
  }
}
