import { Injectable } from '@angular/core';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';
import { Event } from '../../interfaces/event';
import { UserService } from '../User/user.service';

@Injectable({
  providedIn: 'root'
})
export class EventService {

  constructor(private firestore: AngularFirestore, private userService: UserService) { }

  getEvents(user) {
    return this.firestore.collection<Event>("Events", ref => ref.where("organizationId", "==", user.organizationId)).valueChanges();
  }
}
