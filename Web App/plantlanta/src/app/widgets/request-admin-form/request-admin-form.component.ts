import { Component, OnInit, ViewChild } from '@angular/core';
import { SpinnerComponent } from '../spinner/spinner.component';
import { FormGroup, FormControl } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-request-admin-form',
  templateUrl: './request-admin-form.component.html',
  styleUrls: ['./request-admin-form.component.sass']
})
export class RequestAdminFormComponent implements OnInit {

  REQUEST_ACCOUNT_URL = "https://us-central1-junior-design-plantlanta.cloudfunctions.net/requestAdminAccount";

  requestSent = false;
  validForm = true;
  errMessage = "";

  submitting = false;

  requestForm = new FormGroup({
    email: new FormControl(''),
    firstName: new FormControl(''),
    lastName: new FormControl(''),
    message: new FormControl(''),
    organizationName:  new FormControl('')
  });

  constructor(private http: HttpClient) { }

  ngOnInit() {
  }

  requestAccount() {
    if (this.requestForm.valid) {
      const formValues = this.requestForm.value;
      const request = {
        name: formValues["firstName"] + " " + formValues["lastName"],
        email: formValues["email"],
        message: formValues["message"],
        organizationName: formValues["organizationName"]
      };
      this.submitting = true;
      this.http.post(this.REQUEST_ACCOUNT_URL, request).pipe(first()).toPromise().then((resp: any) => {
        this.requestSent = true;
        this.submitting = false;
      }).catch((error) => {
        this.validForm = false;
        this.errMessage = error.error.message;
        this.submitting = false;
      });
    } else {
      this.validForm = false;
      this.errMessage = "Please fill out all fields to procceed."
    }
  }

}
