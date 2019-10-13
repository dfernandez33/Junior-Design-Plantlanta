import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router } from '@angular/router';
import { AngularFireFunctions } from '@angular/fire/functions';
import { Event } from '../../interfaces/event';

@Component({
  selector: 'app-event-dashboard',
  templateUrl: './event-dashboard.component.html',
  styleUrls: ['./event-dashboard.component.sass']
})
export class EventDashboardComponent implements OnInit {

  events: Event[];
  getEventsFunctions;
  loaded = false;
  message = ""

  constructor(private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.getEventsFunctions = this.cloud.httpsCallable("getAllEvents");
    this.message = "Loading Events..."
    this.getEventsFunctions().toPromise().then((data) => {
      //TODO: figure out way to change participants from userIds to actual names
      this.events = data.events;
      this.loaded = true;
    });
  }

}
