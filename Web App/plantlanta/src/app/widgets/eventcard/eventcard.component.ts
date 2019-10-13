import { Component, OnInit, Input } from '@angular/core';
import { Event } from '../../interfaces/event';
import { DeviceDetectorService } from '../../../../node_modules/ngx-device-detector';
import { Router } from '../../../../node_modules/@angular/router';

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

  constructor(private deviceService: DeviceDetectorService, private router: Router) { }

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

  download(data) {
      const a: any = document.getElementById(this.event.eventId);
      var file = this.dataURItoBlob(data);
      a.href = URL.createObjectURL(file);
      a.download = "Event_" + this.event.eventId;
  }

  private dataURItoBlob(dataURI) {
      // convert base64 to raw binary data held in a string
      var byteString = atob(dataURI.split(',')[1]);

      // separate out the mime component
      var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

      // write the bytes of the string to an ArrayBuffer
      var arrayBuffer = new ArrayBuffer(byteString.length);
      var _ia = new Uint8Array(arrayBuffer);
      for (var i = 0; i < byteString.length; i++) {
          _ia[i] = byteString.charCodeAt(i);
      }

      var dataView = new DataView(arrayBuffer);
      var blob = new Blob([dataView], { type: mimeString });
      return blob;
  }

  editEvent() {
    this.router.navigate(["/create_event/" + this.event.eventId])
  }

}
