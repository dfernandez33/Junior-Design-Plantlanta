import { Injectable } from '@angular/core';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private firestore: AngularFirestore) { }

  getAdmin(user) {
    return this.firestore.collection("Admins").doc(user.uid).get();
  }
  
}
