import { Injectable } from '@angular/core';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private firestore: AngularFirestore) { }

  getAdmin(uuid) {
    return this.firestore.collection("Admins").doc(uuid).get();
  }
  
}
