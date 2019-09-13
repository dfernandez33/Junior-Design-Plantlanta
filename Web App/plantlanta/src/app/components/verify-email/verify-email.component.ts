import { Component, OnInit, ViewChild } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { Router } from '../../../../node_modules/@angular/router';
import { SpinnerComponent } from '../../widgets/spinner/spinner.component';


@Component({
  selector: 'app-verify-email',
  templateUrl: './verify-email.component.html',
  styleUrls: ['./verify-email.component.sass']
})
export class VerifyEmailComponent implements OnInit {

  @ViewChild('spinner') spin: SpinnerComponent;

  user: firebase.User;

  constructor(private authService: AuthService, private router: Router) { 
    this.user = this.authService.getUser();
  }
  

  ngOnInit() {
  }

  sendVerificationEmail() {
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
    })
  }
}
