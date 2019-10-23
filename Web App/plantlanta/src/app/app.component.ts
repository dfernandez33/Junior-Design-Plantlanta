import { Component } from '@angular/core';
import { AuthService } from './services/Auth/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})
export class AppComponent {

  constructor(private authService: AuthService) {
    this.authService.subscribeToUser();
  }

}
