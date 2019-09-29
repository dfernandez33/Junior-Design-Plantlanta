import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';
import { Timestamp } from 'rxjs/internal/operators/timestamp';

@Component({
  selector: 'app-create-event',
  templateUrl: './create-event.component.html',
  styleUrls: ['./create-event.component.sass']
})
export class CreateEventComponent implements OnInit {

  validForm = true;
  errMessage = "";
  eventCreated = false;

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  createEventFunction;

  eventForm = new FormGroup({
    eventName: new FormControl(''),
    eventLocation: new FormControl(''),
    eventDate: new FormControl(''),
    eventStart: new FormControl(''),
    eventEnd: new FormControl(''),
    eventDescription: new FormControl(''),
  });

  constructor(private cloud: AngularFireFunctions) {}

  ngOnInit() {
    this.createEventFunction = this.cloud.httpsCallable("createEvent");
  }

  async registerEvent() {
    if (this.eventForm.valid) {
      let formValues = this.eventForm.value;
      try {
        let resp = await this.createEventFunction({
          name: formValues["eventName"],
          location: formValues["eventLocation"],
          description: formValues["eventDescription"],
          date: formValues["eventDate"].toString(),
          startTime: formValues["eventStart"],
          endTime: formValues["eventEnd"]
      }).toPromise();
        this.spin.show()
        if (!resp.status) {
          this.spin.hide();
          this.validForm = false;
          this.errMessage = resp.message;
        } else {
          this.spin.hide()
          this.eventCreated = true;
          this.eventForm.reset();
        }
      } catch(e) {
        this.spin.hide()
        this.validForm = false;
        this.errMessage = e.message;
      }
    } else if (this.eventForm.invalid) {
      this.validForm = false;
      this.errMessage = "All fields are required to create an event. Please fill them out.";
    }
  }

  closeModal() {
    this.eventCreated = false;
  }
}