import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { Router } from '../../../../node_modules/@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.sass']
})
export class HomeComponent implements OnInit {

  constructor(private afAuth: AngularFireAuth, private router: Router) { }

  ngOnInit() {
  }

  logOut() {
    this.afAuth.auth.signOut().then(() => this.router.navigate(['/login']));
  }

}
