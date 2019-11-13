import { Component, OnInit} from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router } from '@angular/router';
import { UserService } from '../../services/User/user.service';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.sass']
})
export class MenuComponent implements OnInit {

  showLogout = false;
  user;

  constructor(private afAuth: AngularFireAuth, private router: Router, private UserService: UserService) { }

  ngOnInit() {
    this.afAuth.auth.onAuthStateChanged(user => {
      if (user) {
        this.UserService.getAdmin(user).subscribe(info => {
          this.user = info.data();
        });
        this.showLogout = true;
      } else {
        this.user = null;
        this.showLogout = false;
      }
    });

  }

  toggleNavbar() {
    document.querySelector('.navbar-menu').classList.toggle('is-active');
    document.querySelector('.navbar-burger').classList.toggle('is-active');
  }

  async logout() {
    await this.afAuth.auth.signOut();
    this.router.navigate(["/login"]);
  }

}
