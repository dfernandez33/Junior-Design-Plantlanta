import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';

@Injectable({
  providedIn: 'root'
})
export class AuthService {


  user: firebase.User;

  constructor(private afAuth:AngularFireAuth) {}

  getUser(): firebase.User {
    return this.user;
  }

  subscribeToUser() {
    this.afAuth.auth.onAuthStateChanged(user => {
      this.user = user;
    })
  }

}
