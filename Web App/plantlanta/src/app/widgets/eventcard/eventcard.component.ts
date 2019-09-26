import { Component, OnInit, Input } from '@angular/core';
import { Event } from '../../interfaces/event';

@Component({
  selector: 'app-eventcard',
  templateUrl: './eventcard.component.html',
  styleUrls: ['./eventcard.component.sass']
})
export class EventcardComponent implements OnInit {

  @Input() event: Event;

  showParticipants = false;

  constructor() { }

  ngOnInit() {
  }

  toggleParticipants() {
    this.showParticipants = !this.showParticipants;
  }

}
