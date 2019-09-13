import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AngularFireAuth } from '../../../node_modules/@angular/fire/auth';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  user: firebase.User;

  constructor(private authService: AuthService , private router: Router) {}

  canActivate(next: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
    this.user = this.authService.getUser();
    if (this.user) {
      if(this.user.emailVerified) {
        return true;
      } else {
        this.router.navigate(['/verify_email']);
        return false;
      }
    } 

    this.router.navigate(["/login"]);
    return false;
  }
}
