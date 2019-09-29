import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '../../../../node_modules/@angular/forms';
import { Router, ActivatedRoute } from '../../../../node_modules/@angular/router';
import { AngularFireAuth } from '../../../../node_modules/@angular/fire/auth';
import { AngularFireFunctions } from '../../../../node_modules/@angular/fire/functions';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.sass']
})
export class RegisterComponent implements OnInit {

  validForm = true;
  errMessage = "";
  badRequestId = false;

  requestId;

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  registerAdminFunction;

  registerForm = new FormGroup({
    email: new FormControl(''),
    firstName: new FormControl(''),
    lastName: new FormControl(''),
    password: new FormControl(''),
    verify_password: new FormControl(''),
  });

  constructor(private afAuth: AngularFireAuth, private cloud: AngularFireFunctions, private router: Router, private route: ActivatedRoute) {}

  ngOnInit() {
    this.registerAdminFunction = this.cloud.httpsCallable("registerAdmin");
    this.requestId = this.route.snapshot.paramMap.get("requestId");
    const getAdminRequest = this.cloud.httpsCallable("getAdminRequest");
    getAdminRequest({ requestId: this.requestId}).toPromise().then(resp => {
      if (resp == undefined) {
        this.badRequestId = true;
        this.errMessage = "This request has either been reviewed already, or the link provided is invalid."
      } else {
        this.registerForm.setValue({
          email: resp.email,
          firstName: resp.name.substr(0, resp.name.indexOf(' ')),
          lastName: resp.name.substr(resp.name.indexOf(' ') + 1),
          password: '',
          verify_password: ''
        });
      }
    })
  }

  async register() {
    if (this.registerForm.valid) {
      let formValues = this.registerForm.value;
      try {
        this.spin.show()
        let user = await this.afAuth.auth.createUserWithEmailAndPassword(formValues["email"], formValues["password"]);
        let resp = await this.registerAdminFunction({
            name: formValues["firstName"] + " " + formValues["lastName"],
            requestId: this.requestId
        }).toPromise();
        if (!resp.status) {
          user.user.delete();
          this.spin.hide();
          this.validForm = false;
          this.errMessage = resp.message;
        } else {
          this.spin.hide()
          this.router.navigate(['/verify_email']);
        }
      } catch(e) {
        this.spin.hide()
        this.validForm = false;
        this.errMessage = e.message;
      }
    } else if (this.registerForm.invalid) {
      this.validForm = false;
      this.errMessage = "All fields are required to register. Please fill them out.";
    }
  }
}
