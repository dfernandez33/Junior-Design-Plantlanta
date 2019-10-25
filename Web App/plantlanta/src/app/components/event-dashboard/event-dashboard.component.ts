import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AngularFireFunctions } from '@angular/fire/functions';
import { Event } from '../../interfaces/event';
import * as algoliasearch from 'algoliasearch';
import { environment } from '../../../environments/environment';
import { EventService } from '../../services/Event/event.service';


@Component({
  selector: 'app-event-dashboard',
  templateUrl: './event-dashboard.component.html',
  styleUrls: ['./event-dashboard.component.sass']
})
export class EventDashboardComponent implements OnInit {

  searchClient;
  index;

  events: Event[];
  filteredEvents: Event[] = [];
  getEventsFunctions;

  loaded = false;
  message = ""

  constructor(private eventService: EventService) { }

  ngOnInit() {
    this.searchClient = algoliasearch(environment.algolia.app, environment.algolia.search_key);
    this.index = this.searchClient.initIndex('Events');
    this.message = "Loading Events..."
    this.eventService.getEvents().subscribe(events => {
      this.loaded = true;
      this.events = events;
      this.filteredEvents = this.events;
    })

  }

  updateQuery(query) {
    this.index.search({ query: query.srcElement.value }).then(result => {
      const hitIDs = result.hits.map(hit => hit.objectID);
      this.filteredEvents = this.events.filter(event => hitIDs.includes(event.eventId));
    });
  }

}
