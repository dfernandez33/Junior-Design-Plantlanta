import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '../../../../node_modules/@angular/router';
import { VerifyAdminRequestInfo } from '../../interfaces/verify-admin-request-info';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from 'src/app/widgets/spinner/spinner.component';
import { HttpClient } from '../../../../node_modules/@angular/common/http';
import { first } from '../../../../node_modules/rxjs/operators';

@Component({
  selector: 'app-verify-admin',
  templateUrl: './verify-admin.component.html',
  styleUrls: ['./verify-admin.component.sass']
})
export class VerifyAdminComponent implements OnInit {

  REVIEW_REQUEST_URL = "https://us-central1-junior-design-plantlanta.cloudfunctions.net/reviewAdminRequest";

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  badRequestId = false;

  submitted = false;
  message = "";

  requestId: string;
  requestInfo: VerifyAdminRequestInfo;

  getAdminRequestFunction;

  constructor(private route: ActivatedRoute, private http: HttpClient, private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.requestId = this.route.snapshot.paramMap.get("requestId");
    this.getAdminRequestFunction = this.cloud.httpsCallable("getAdminRequest");
    this.getAdminRequestFunction({
      requestId: this.requestId
    }).toPromise().then(data => {
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
      this.message = "Request approved. The user has been notified by email.\n You can now close this page."
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
      this.message = "Request approved. The user has been notified by email.\n You can now close this page."
    }).catch(error => {
      this.spin.hide();
      this.submitted = true;
      this.message = error.error.message + "\n Please reload and try again."
    });
  }


}
