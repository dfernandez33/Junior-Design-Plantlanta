import { Component, OnInit } from '@angular/core';
import { Event } from '../../interfaces/event';
import * as algoliasearch from 'algoliasearch';
import { environment } from '../../../environments/environment';
import { EventService } from '../../services/Event/event.service';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { UserService } from '../../services/User/user.service';


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
  activeFilterElement = null;

  loaded = false;
  message = "";

  filterValues = ["Education",
  "Environmental Sustainability",
  "Community Improvement",
  "Event Organizing",
  "Elderly",
  "Orphanages"];

  constructor(private eventService: EventService, private afAuth: AngularFireAuth, private userService: UserService) { }

  ngOnInit() {
    this.searchClient = algoliasearch(environment.algolia.app, environment.algolia.search_key);
    this.index = this.searchClient.initIndex('Events');
    this.message = "Loading Events..."
    this.afAuth.auth.onAuthStateChanged(user => {
      if (user) {
        this.userService.getAdmin(user).subscribe(admin => {
          this.eventService.getEvents(admin.data()).subscribe(events => {
            this.loaded = true;
            this.events = events;
            this.filteredEvents = this.events;
          })
        });
      }
    });

  }

  updateQuery(query) {
    this.index.search({ query: query.srcElement.value,
      //you must surround the variable containing the filter value with escaped " in order for multiple word filters to work
      filters: this.activeFilterElement != null ? "type:" +  "\"" + this.activeFilterElement.innerText + "\"" : ''}).then(result => {
      const hitIDs = result.hits.map(hit => hit.objectID);
      this.filteredEvents = this.events.filter(event => hitIDs.includes(event.eventId));
    });
  }

  updateFilter(query, value) {
    if (this.activeFilterElement != null) {
      this.activeFilterElement.classList.toggle("is-active");
    }

    if (this.activeFilterElement != null && this.activeFilterElement.innerText == query.srcElement.innerText) {
      this.filteredEvents = this.events;
      this.activeFilterElement = null;
    } else {
      query.srcElement.classList.toggle("is-active");
      this.activeFilterElement = query.srcElement;
      //you must surround the variable containing the filter value with escaped " in order for multiple word filters to work
      this.index.search({ query: "",  filters: "type:" + "\"" + value + "\""}).then(result => {
        const hitIDs = result.hits.map(hit => hit.objectID);
        this.filteredEvents = this.events.filter(event => hitIDs.includes(event.eventId));
      });
    }

    // logic used to change background color of dropdown button
    if (this.activeFilterElement == null) {
      document.getElementById("dropdown-button").classList.remove("active-filter");
    } else if (this.activeFilterElement != null && !document.getElementById("dropdown-button").classList.contains("active-filter")) {
      document.getElementById("dropdown-button").classList.add("active-filter");
    }
  }

}
