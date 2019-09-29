import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { Router, ActivatedRoute } from '../../../../node_modules/@angular/router';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';

@Component({
  selector: 'app-create-event',
  templateUrl: './create-event.component.html',
  styleUrls: ['./create-event.component.sass']
})
export class CreateEventComponent implements OnInit {

  validForm = true;
  errMessage = "";
  badRequestId = false;
  eventCreated = false;

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  createEventFunction;

  eventForm = new FormGroup({
    eventName: new FormControl(''),
    eventLocation: new FormControl(''),
    eventDate: new FormControl(new Date()),
    eventDuration: new FormControl(0),
    eventDescription: new FormControl(''),
  });

  constructor(private afAuth: AngularFireAuth, private cloud: AngularFireFunctions, private router: Router, private route: ActivatedRoute) {}

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
          date: formValues["eventDate"],
          duration: formValues["eventDuration"],
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


}