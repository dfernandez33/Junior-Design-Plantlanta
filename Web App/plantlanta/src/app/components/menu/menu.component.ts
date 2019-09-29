import { Component, OnInit } from '@angular/core';
import { NavbarService } from '../../services/navbar.service';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { Router } from '../../../../node_modules/@angular/router';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.sass']
})
export class MenuComponent implements OnInit {

  constructor(public navbar: NavbarService, private afAuth: AngularFireAuth, private router: Router) { }

  ngOnInit() {
  }

  async logout() {
    await this.afAuth.auth.signOut();
    this.router.navigate(["/login"]);
  }

}
