import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '../../../../node_modules/@angular/forms';
import { AngularFireAuth } from '@angular/fire/auth';
import { Router } from '../../../../node_modules/@angular/router';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.sass']
})
export class LoginComponent implements OnInit {

  @ViewChild('spinner') spin: SpinnerComponent;

  validForm = true;
  errMessage = "";

  loginForm = new FormGroup({
    email: new FormControl(''),
    password: new FormControl('')
  });

  constructor(public afAuth: AngularFireAuth, private router: Router) { }

  ngOnInit() {
  }

  login() {
    if (this.loginForm.valid) {
      let email = this.loginForm.value["email"];
      let password = this.loginForm.value["password"];
      this.spin.show()
      this.afAuth.auth.signInWithEmailAndPassword(email, password).then((user) => {
        this.spin.hide()
        this.router.navigate(['/home']);
      }).catch((error) => {
        this.spin.hide();
        this.validForm = false;
        this.errMessage = error.message;
      })
    } else {
      this.errMessage = "Please fill out to procced."
      this.validForm = false;
    }
  }

}
