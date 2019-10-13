import { Component, OnInit, ViewChild } from '@angular/core';
import { first } from '../../../../node_modules/rxjs/operators';
import { ActivatedRoute } from '../../../../node_modules/@angular/router';
import { HttpClient } from '../../../../node_modules/@angular/common/http';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';
import { VerifyOrganizationRequestInfo } from '../../interfaces/verify-organization-request-info';

@Component({
  selector: 'app-verify-organization',
  templateUrl: './verify-organization.component.html',
  styleUrls: ['./verify-organization.component.sass']
})
export class VerifyOrganizationComponent implements OnInit {

  REVIEW_REQUEST_URL = "https://us-central1-junior-design-plantlanta.cloudfunctions.net/reviewOrganizationRequest";

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  loaded = false;

  badRequestId = false;

  submitted = false;
  message = "";

  requestId: string;
  requestInfo: VerifyOrganizationRequestInfo;

  getAdminRequestFunction;

  constructor(private route: ActivatedRoute, private http: HttpClient, private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.requestId = this.route.snapshot.paramMap.get("requestId");
    this.getAdminRequestFunction = this.cloud.httpsCallable("getOrganizationRequest");
    this.getAdminRequestFunction({
      requestId: this.requestId
    }).toPromise().then(data => {
      this.loaded = true;
      if (data == undefined) {
        this.badRequestId = true;
        this.message = "This request has either been reviewed already, or the link provided is invalid."
      } else {
        this.requestInfo = data;
      }
    })
  }

  approveRequest() {
    this.spin.show();
    const review = {
      requestId: this.requestId,
      approved: true
    };
    this.http.post(this.REVIEW_REQUEST_URL, review).pipe(first()).toPromise().then((resp: any) => {
      this.spin.hide();
      this.submitted = true;
      this.message = "Request approved. An email has been sent to the organization's contact email.\n You can now close this page."
    }).catch(error => {
      this.spin.hide();
      this.submitted = true;
      this.message = error.error.message + "\n Please reload and try again."
    });
  }

  denyRequest() {
    this.spin.show();
    const review = {
      requestId: this.requestId,
      approved: false
    };
    this.http.post(this.REVIEW_REQUEST_URL, review).pipe(first()).toPromise().then((resp: any) => {
      this.spin.hide();
      this.submitted = true;
      this.message = "Request denied. An email has been sent to the organization's contact email.\n You can now close this page."
    }).catch(error => {
      this.spin.hide();
      this.submitted = true;
      this.message = error.error.message + "\n Please reload and try again."
    });
  }

}
