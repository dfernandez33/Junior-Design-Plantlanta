import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { Router } from '../../../../node_modules/@angular/router';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { Event } from '../../interfaces/event';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.sass']
})
export class HomeComponent implements OnInit {

  events: Event[];
  getEventsFunctions;
  loaded = false;
  message = ""

  constructor(private afAuth: AngularFireAuth, private router: Router, private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.getEventsFunctions = this.cloud.httpsCallable("getAllEvents");
    this.message = "Loading Events..."
    this.getEventsFunctions().toPromise().then((data) => {
      //TODO: figure out way to change participants from userIds to actual names
      this.events = data.events;
      this.loaded = true;
    });
  }

  logOut() {
    this.afAuth.auth.signOut().then(() => this.router.navigate(['/login']));
  }

}
