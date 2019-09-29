import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AngularFireAuth } from '../../../node_modules/@angular/fire/auth';
import { first } from '../../../node_modules/rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private router: Router, private afAuth: AngularFireAuth) {}

  canActivate(next: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
    return this.afAuth.authState.pipe(first()).toPromise().then(user => {
      if (user) {
        if(user.emailVerified) {
          return true;
        } else {
          this.router.navigate(['/verify_email']);
          return false;
        }
      } 
  
      const returnUrl = state.url;
      this.router.navigate(["/login"], { queryParams: {returnUrl: returnUrl}}); 
      return false;
    });
  }
}
