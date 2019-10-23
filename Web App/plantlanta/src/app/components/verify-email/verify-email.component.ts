import { Component, OnInit, ViewChild } from '@angular/core';
import { AuthService } from '../../services/Auth/auth.service';
import { Router } from '@angular/router';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';


@Component({
  selector: 'app-verify-email',
  templateUrl: './verify-email.component.html',
  styleUrls: ['./verify-email.component.sass']
})
export class VerifyEmailComponent implements OnInit {

  @ViewChild('spinner', {static: false}) spin: SpinnerComponent;

  user: firebase.User;
  error = false;
  errMessage = "";

  constructor(private authService: AuthService, private router: Router) { 
    this.user = this.authService.getUser();
  }
  

  ngOnInit() {
  }

  sendVerificationEmail() {
    if (this.user) {
      this.user.sendEmailVerification().then(() => {
        this.spin.show()
        let interval = setInterval(() => {
          this.user.reload();
          this.user = this.authService.getUser();
          if (this.user.emailVerified) {
            clearInterval(interval);
            this.spin.hide();
            this.router.navigate(['/home']);
          }
        }, 1500);
      }).catch((error) => {
        this.errMessage = error.message;
        this.error = true;
      });
    } else {
      this.errMessage = "You must be logged in to request a verification email.";
      this.error = true;
    }

  }
}
