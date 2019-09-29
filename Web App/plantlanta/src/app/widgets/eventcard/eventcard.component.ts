import { Component, OnInit, Input } from '@angular/core';
import { Event } from '../../interfaces/event';
import { DeviceDetectorService } from '../../../../node_modules/ngx-device-detector';

@Component({
  selector: 'app-eventcard',
  templateUrl: './eventcard.component.html',
  styleUrls: ['./eventcard.component.sass']
})
export class EventcardComponent implements OnInit {

  @Input() event: Event;

  showParticipants;
  showAtendees;

  displayColumns: string[] = ['#', 'name'];

  constructor(private deviceService: DeviceDetectorService) { }

  ngOnInit() {
    if (this.deviceService.isMobile()) {
      this.showAtendees = false;
      this.showParticipants = false; 
    } else {
      this.showAtendees = true;
      this.showParticipants = true;
    }
  }

  toggleParticipants() {
    this.showParticipants = !this.showParticipants;
  }

  toggleAtendees() {
    this.showAtendees = !this.showAtendees;
  }

}
