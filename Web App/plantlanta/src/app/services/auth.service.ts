import { Injectable } from '@angular/core';
import { AngularFireAuth } from '../../../node_modules/@angular/fire/auth';
import { Subscription } from '../../../node_modules/rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  user: firebase.User;

  constructor(private afAuth:AngularFireAuth) {
    this.afAuth.authState.subscribe((user) => {
      this.user = user;
    });
   }

  getUser(): firebase.User {
    return this.user
  }

}
