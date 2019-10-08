import { Component, ViewChild } from '@angular/core';
import { AuthService } from './services/auth.service';
import { NavbarService } from './services/navbar.service';
import { Router, NavigationStart } from '../../node_modules/@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})
export class AppComponent {

  constructor(private authService: AuthService, public navbarService: NavbarService, private router: Router) {
    this.authService.subscribeToUser();
    this.router.events.subscribe((event) => {
      if (event instanceof NavigationStart) {
        if (event.url == "/login" || event.url == "register/:requestId" 
            || event.url == "/verify_email" || event.url == "verify_admin/:requestId"
            || event.url == "/request_admin") {
              this.navbarService.hide();
        } else {
          this.navbarService.setActive(event.url);
          this.navbarService.show();
        }
      }
    });
  }

}
