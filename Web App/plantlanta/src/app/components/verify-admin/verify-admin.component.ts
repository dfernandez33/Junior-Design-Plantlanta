import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '../../../../node_modules/@angular/router';
import { VerifyAdminRequestInfo } from '../../interfaces/verify-admin-request-info';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from 'src/app/widgets/spinner/spinner.component';

@Component({
  selector: 'app-verify-admin',
  templateUrl: './verify-admin.component.html',
  styleUrls: ['./verify-admin.component.sass']
})
export class VerifyAdminComponent implements OnInit {

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  badRequestId = false;

  submitted = false;
  message = "";

  requestId: string;
  requestInfo: VerifyAdminRequestInfo;

  getAdminRequestFunction;
  reviewRequestFunction;

  constructor(private route: ActivatedRoute, private cloud: AngularFireFunctions) { }

  ngOnInit() {
    this.requestId = this.route.snapshot.paramMap.get("requestId");
    this.reviewRequestFunction = this.cloud.httpsCallable("reviewAdminRequest");
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
    this.reviewRequestFunction({
      requestId: this.requestId,
      approved: true
    }).toPromise().then(resp => {
      if (resp.status == 200) {
        this.spin.hide();
        this.submitted = true;
        this.message = "Request approved. The user has been notified by email.\n You can now close this page."
      } else {
        this.spin.hide();
        this.submitted = true;
        this.message = resp.message + "\n Please reload and try again."
      }
    });
  }

  denyRequest() {
    this.spin.show();
    this.reviewRequestFunction({
      requestId: this.requestId,
      approved: false
    }).toPromise().then(resp => {
      if (resp.status == 200) {
        this.spin.hide();
        this.submitted = true;
        this.message = "Request denied. The user has been notified by email.\n You can now close this page."
      } else {
        this.spin.hide();
        this.submitted = true;
        this.message = resp.message + "\n Please reload and try again."
      }
    });
  }


}
