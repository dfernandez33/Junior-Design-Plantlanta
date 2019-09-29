import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { HomeComponent } from './components/home/home.component';
import { AuthGuard } from './guards/auth.guard';
import { VerifyEmailComponent } from './components/verify-email/verify-email.component';
import { VerifyAdminComponent } from './components/verify-admin/verify-admin.component';
import { RequestAdminComponent } from './components/request-admin/request-admin.component';
import { CreateEventComponent } from './components/create-event/create-event.component';

const routes: Routes = [
  { path:'', redirectTo: '/dashboard', pathMatch:'full' },
  { path: 'login', component: LoginComponent},
  { path: 'register/:requestId', component: RegisterComponent },
  { path: 'dashboard', component: HomeComponent, canActivate:[AuthGuard] },
  { path: 'verify_email', component: VerifyEmailComponent },
  { path: 'verify_admin/:requestId', component: VerifyAdminComponent, canActivate:[AuthGuard] },
  { path: 'request_admin', component: RequestAdminComponent },
  { path: 'create_event', component: CreateEventComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
