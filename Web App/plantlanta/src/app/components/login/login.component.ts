import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router, ActivatedRoute } from '@angular/router';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';
import { AngularFireFunctions } from '@angular/fire/functions';
import * as firebase from 'firebase';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.sass']
})
export class LoginComponent implements OnInit {

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  isUserAdminFunctions;
  validForm = true;
  errMessage = "";
  returnUrl: string;

  loginForm = new FormGroup({
    email: new FormControl(''),
    password: new FormControl('')
  });

  constructor(public afAuth: AngularFireAuth, private router: Router, private cloud: AngularFireFunctions, private route: ActivatedRoute) { }

  ngOnInit() {
    this.isUserAdminFunctions = this.cloud.httpsCallable("isUserAdmin");
    this.route.queryParams.subscribe(params => {
      this.returnUrl = params['returnUrl'] != null ? this.route.snapshot.queryParams['returnUrl'] : '/';
    });
  }

  async login() {
    if (this.loginForm.valid) {
      let email = this.loginForm.value["email"];
      let password = this.loginForm.value["password"];
      this.spin.show()
      try {
        await this.afAuth.auth.setPersistence(firebase.auth.Auth.Persistence.LOCAL);
        await this.afAuth.auth.signInWithEmailAndPassword(email, password);
        let resp = await this.isUserAdminFunctions().toPromise();
        if (!resp.status) {
          this.afAuth.auth.signOut();
          this.validForm = false;
          this.spin.hide();
          this.errMessage = "Only admins can access this page."
        } else {
          this.spin.hide();
          this.router.navigateByUrl(this.returnUrl);
        }
      } catch (e) {
        this.spin.hide();
        this.validForm = false;
        this.errMessage = e.message;
      }
    } else {
      this.errMessage = "Please fill out to procced."
      this.validForm = false;
    }
  }

}
