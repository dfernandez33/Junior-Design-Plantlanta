import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';
import { ActivatedRoute } from '../../../../node_modules/@angular/router';

@Component({
  selector: 'app-create-event',
  templateUrl: './create-event.component.html',
  styleUrls: ['./create-event.component.sass']
})
export class CreateEventComponent implements OnInit {

  validForm = true;
  message = "";
  eventCreated = false;

  createEventFunction;

  getEventFunction;
  deleteEventFunction;
  editEventFunction;

  eventId = "";
  isEdit = false;
  loading = false;

  confirmDeleteModal = false;

  successDeleteModal = false;
  successDeleteModalMessage = "";

  editModal = false;
  editModalMessage = "";

  eventForm = new FormGroup({
    eventName: new FormControl(''),
    eventLocation: new FormControl(''),
    eventDate: new FormControl(''),
    eventStart: new FormControl(''),
    eventEnd: new FormControl(''),
    eventDescription: new FormControl(''),
  });

  constructor(private cloud: AngularFireFunctions, private route: ActivatedRoute) {}

  ngOnInit() {
    this.eventId = this.route.snapshot.paramMap.get("eventId");
    if (this.eventId != null) {
      this.deleteEventFunction = this.cloud.httpsCallable("deleteEvent");
      this.editEventFunction = this.cloud.httpsCallable("editEvent");

      this.message = "Loading Event..."
      this.loading = true;
      this.isEdit = true;
      this.getEventFunction = this.cloud.httpsCallable("getEvent");
      this.getEventFunction({EventID: this.eventId}).toPromise().then(event => {
        this.eventForm.setValue({
          eventName: event.message.name,
          eventLocation: event.message.location,
          eventDate: new Date(event.message.date._seconds * 1000),
          eventStart: event.message.startTime,
          eventEnd: event.message.endTime,
          eventDescription: event.message.description
        });
        this.loading = false;
      });
    } else {
      this.createEventFunction = this.cloud.httpsCallable("createEvent");
    }
  }

  async registerEvent() {
    this.message = "Creating Event..."
    this.loading = true;
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
        if (!resp.status) {
          this.loading = false;
          this.validForm = false;
          this.message = resp.message;
        } else {
          this.loading = false;
          this.eventCreated = true;
          this.eventForm.reset();
        }
      } catch(e) {
        this.loading = false;
        this.validForm = false;
        this.message = e.message;
      }
    } else if (this.eventForm.invalid) {
      this.validForm = false;
      this.message = "All fields are required to create an event. Please fill them out.";
    }
  }

  closeEventCreatedModal() {
    this.eventCreated = false;
  }

  closeEditModal() {
    this.editModal = false;
  }

  closeSuccessDeleteModal() {
    this.successDeleteModal = false;
  }

  toggleConfirmDeleteModal() {
    this.confirmDeleteModal = !this.confirmDeleteModal;
  }

  deleteEvent() {
    this.confirmDeleteModal = false;
    this.message = "Deleting Event...";
    this.loading = true;
    this.deleteEventFunction({eventId: this.eventId}).toPromise().then(resp => {
      if (resp.status) {
        this.successDeleteModal = true;
        this.loading = false;
        this.successDeleteModalMessage = "Event Successfully Deleted"
      } else {
        this.successDeleteModal = true;
        this.loading = false;
        this.successDeleteModalMessage = resp.message;
      }
    }).catch(e => {
      this.successDeleteModal = true;
      this.loading = false;
      this.successDeleteModalMessage = "There was an error deleteing this event. Please try again."
    });
  }

  editEvent() {
    this.message = "Updating Event Information...";
    this.loading = true;
    let formValues = this.eventForm.value;
    this.editEventFunction({
      name: formValues["eventName"],
      location: formValues["eventLocation"],
      description: formValues["eventDescription"],
      date: formValues["eventDate"].toString(),
      startTime: formValues["eventStart"],
      endTime: formValues["eventEnd"]
    }).toPromise().then(resp => {
      if (resp.status) {
        this.editModal = true;
        this.loading = false;
        this.editModalMessage = "Event Successfully Updated"
      } else {
        this.editModal = true;
        this.loading = false;
        this.editModalMessage = resp.message;
      }
    }).catch(e => {
      this.editModal = true;
      this.loading = false;
      this.editModalMessage = "There was an error updating this event. Please try again."
    });
  }

}