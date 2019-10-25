import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AngularFireFunctions } from '@angular/fire/functions';
import { Event } from '../../interfaces/event';
import * as algoliasearch from 'algoliasearch';
import { environment } from '../../../environments/environment';

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

  constructor(private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.searchClient = algoliasearch(environment.algolia.app, environment.algolia.search_key);
    this.index = this.searchClient.initIndex('Events');
    this.getEventsFunctions = this.cloud.httpsCallable("getAllEvents");
    this.message = "Loading Events..."
    this.getEventsFunctions().toPromise().then((data) => {
      //TODO: figure out way to change participants from userIds to actual names
      this.events = data.events;
      this.filteredEvents = this.events;
      this.loaded = true;
    });
  }

  updateQuery(query) {
    this.index.search({ query: query.srcElement.value }).then(result => {
      const hitIDs = result.hits.map(hit => hit.objectID);
      this.filteredEvents = this.events.filter(event => hitIDs.includes(event.eventId));
    });
  }

}
