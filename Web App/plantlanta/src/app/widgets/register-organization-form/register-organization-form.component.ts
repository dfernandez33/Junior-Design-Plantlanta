import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { first, tap, finalize } from 'rxjs/operators';
import { AngularFireStorage } from '@angular/fire/storage';

@Component({
  selector: 'app-register-organization-form',
  templateUrl: './register-organization-form.component.html',
  styleUrls: ['./register-organization-form.component.sass']
})
export class RegisterOrganizationFormComponent implements OnInit {

  REQUEST_ORG_URL = "https://us-central1-junior-design-plantlanta.cloudfunctions.net/requestOrganization";

  submitting = false;
  requestSent = false;
  validForm = false;
  errMessage = '';
  message = '';

  file: File;

  requestOrganizationForm = new FormGroup({
    name: new FormControl(''),
    mission: new FormControl(''),
    contactEmail: new FormControl(''),
  });

  constructor(private cd: ChangeDetectorRef, private http: HttpClient, private storage: AngularFireStorage) { }

  ngOnInit() {

  }

  onFileChange(event) {
    if(event.target.files && event.target.files.length && event.target.files[0].type == "application/pdf") {
      this.file = event.target.files[0];
    } else {
      event.srcElement.value = null;
      this.validForm = false;
      this.errMessage = "Only PDF files are allowed."
    }
  }

  registerOrganization() {
    if (this.requestOrganizationForm.valid) {
      const formValues = this.requestOrganizationForm.value;
      const path = "501C3_Documents/" + formValues["name"]
      let upload = this.storage.upload(path, this.file);
      this.submitting = true;
      let percentChange = upload.percentageChanges().subscribe(percent => this.message = "Uploading Document... " + Math.round(percent) + "%");
      upload.then(async snapshot => {
        percentChange.unsubscribe();
        this.message = "Submitting Organization Request..."
        const request = {
          name: formValues["name"],
          contactEmail: formValues["contactEmail"],
          mission: formValues["mission"],
          doc501C3URL: await snapshot.ref.getDownloadURL()
        };
        this.http.post(this.REQUEST_ORG_URL, request).pipe(first()).toPromise().then(() => {
          this.requestSent = true;
          this.submitting = false;
        }).catch((error) => {
          this.validForm = false;
          this.errMessage = error.error.message;
          this.submitting = false;
          this.storage.ref(path).delete();
        });
      }).catch(error => {
        this.validForm = false;
        this.errMessage = error.message,
        this.submitting = false;
      })
    } else {
      this.validForm = false;
      this.errMessage = "Please fill out all fields to procceed."
    }
  }
}
