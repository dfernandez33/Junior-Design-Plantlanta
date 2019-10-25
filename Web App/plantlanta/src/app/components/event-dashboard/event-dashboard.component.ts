import { Component, OnInit } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router } from '@angular/router';
import { AngularFireFunctions } from '@angular/fire/functions';
import { Event } from '../../interfaces/event';
import { EventService } from '../../services/Event/event.service';

@Component({
  selector: 'app-event-dashboard',
  templateUrl: './event-dashboard.component.html',
  styleUrls: ['./event-dashboard.component.sass']
})
export class EventDashboardComponent implements OnInit {

  events: Event[];
  loaded = false;
  message = ""

  constructor(private eventService: EventService) { }

  ngOnInit() {
    this.message = "Loading Events..."
    this.eventService.getEvents().subscribe(events => {
      this.loaded = true;
      this.events = events;
    })

  }

}
