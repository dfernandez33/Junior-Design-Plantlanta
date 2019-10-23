import { Injectable } from '@angular/core';
import { AngularFirestore } from '../../../../node_modules/@angular/fire/firestore';
import { Event } from '../../interfaces/event';

@Injectable({
  providedIn: 'root'
})
export class EventService {

  constructor(private firestore: AngularFirestore) { }

  getEvents() {
    return this.firestore.collection<Event>("Events").valueChanges();
  }
}
