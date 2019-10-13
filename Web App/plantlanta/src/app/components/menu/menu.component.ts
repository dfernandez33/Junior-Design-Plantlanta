import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router } from '@angular/router';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.sass']
})
export class MenuComponent implements OnInit {

  showLogout = false;

  constructor(private afAuth: AngularFireAuth, private router: Router) { }

  ngOnInit() {
    this.afAuth.auth.onAuthStateChanged(user => {
      if (user) {
        this.showLogout = true;
      } else {
        this.showLogout = false;
      }
    });
  }

  async logout() {
    await this.afAuth.auth.signOut();
    this.router.navigate(["/login"]);
  }

}
