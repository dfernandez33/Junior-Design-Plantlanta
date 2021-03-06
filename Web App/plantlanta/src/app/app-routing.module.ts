import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { EventDashboardComponent } from './components/event-dashboard/event-dashboard.component';
import { AuthGuard } from './guards/auth.guard';
import { VerifyEmailComponent } from './components/verify-email/verify-email.component';
import { VerifyAdminComponent } from './components/verify-admin/verify-admin.component';
import { RequestAdminComponent } from './components/request-admin/request-admin.component';
import { CreateEventComponent } from './components/create-event/create-event.component';
import { MarketplaceDashboardComponent } from './components/marketplace-dashboard/marketplace-dashboard.component';
import { VerifyOrganizationComponent } from './components/verify-organization/verify-organization.component';
import { CreateItemComponent } from './components/create-item/create-item.component';
import { LandingPageComponent } from './components/landing-page/landing-page.component';

const routes: Routes = [
  { path:'', redirectTo: '/landing-page', pathMatch:'full' },
  { path: 'login', component: LoginComponent},
  { path: 'register/:requestId', component: RegisterComponent },
  { path: 'event_dashboard', component: EventDashboardComponent, canActivate:[AuthGuard] },
  { path: 'verify_email', component: VerifyEmailComponent },
  { path: 'verify_admin/:requestId', component: VerifyAdminComponent },
  { path: 'request_admin', component: RequestAdminComponent },
  { path: 'create_event', component: CreateEventComponent, canActivate:[AuthGuard] },
  { path: 'create_event/:eventId', component: CreateEventComponent },
  { path: 'marketplace_dashboard', component: MarketplaceDashboardComponent, canActivate:[AuthGuard]},
  { path: 'verify_organization/:requestId', component: VerifyOrganizationComponent},
  { path: 'create_item', component: CreateItemComponent },
  { path: 'create_item/:itemId', component: CreateItemComponent },
  { path: 'landing-page', component: LandingPageComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
