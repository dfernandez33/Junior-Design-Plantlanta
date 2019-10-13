import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { ReactiveFormsModule } from '@angular/forms';
import { QRCodeModule } from 'angularx-qrcode';
import { DeviceDetectorModule } from 'ngx-device-detector';
import { MatTableModule, MatNativeDateModule } from "@angular/material";
import {MatDatepickerModule} from '@angular/material/datepicker';
import {NgxMaterialTimepickerModule} from 'ngx-material-timepicker';

import { AngularFireModule } from '@angular/fire';
import { AngularFireAuthModule } from '@angular/fire/auth';
import { AngularFireFunctionsModule } from '@angular/fire/functions';
import { AngularFirestoreModule } from '@angular/fire/firestore';
import { EventDashboardComponent } from './components/event-dashboard/event-dashboard.component';
import { AngularFireStorageModule } from '@angular/fire/storage';
import { VerifyEmailComponent } from './components/verify-email/verify-email.component';
import { NgxSpinnerModule } from "ngx-spinner";
import { SpinnerComponent } from './widgets/spinner/spinner.component';
import { VerifyAdminComponent } from './components/verify-admin/verify-admin.component';
import { RequestAdminComponent } from './components/request-admin/request-admin.component';
import { HttpClientModule } from '../../node_modules/@angular/common/http';
import { MenuComponent } from './components/menu/menu.component';
import { EventcardComponent } from './widgets/eventcard/eventcard.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { CreateEventComponent } from './components/create-event/create-event.component';
import { MarketplaceDashboardComponent } from './components/marketplace-dashboard/marketplace-dashboard.component';
import { RegisterOrganizationFormComponent } from './widgets/register-organization-form/register-organization-form.component';
import { RequestAdminFormComponent } from './widgets/request-admin-form/request-admin-form.component';
import { VerifyOrganizationComponent } from './components/verify-organization/verify-organization.component';
import { CreateItemComponent } from './components/create-item/create-item.component';

const firebaseConfig = {
  apiKey: "AIzaSyBmvdgLNheowskj5H1WDtVnnRUYxIUfix8",
  authDomain: "junior-design-plantlanta.firebaseapp.com",
  databaseURL: "https://junior-design-plantlanta.firebaseio.com",
  projectId: "junior-design-plantlanta",
  storageBucket: "junior-design-plantlanta.appspot.com",
  messagingSenderId: "243735414460",
  appId: "1:243735414460:web:7b69ee11245f75a27072b9"
};

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    EventDashboardComponent,
    VerifyEmailComponent,
    SpinnerComponent,
    VerifyAdminComponent,
    RequestAdminComponent,
    MenuComponent,
    EventcardComponent,
    CreateEventComponent,
    MarketplaceDashboardComponent,
    RegisterOrganizationFormComponent,
    RequestAdminFormComponent,
    VerifyOrganizationComponent,
    CreateItemComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireAuthModule,
    AngularFireFunctionsModule,
    AngularFirestoreModule,
    AngularFireStorageModule,
    NgxSpinnerModule,
    HttpClientModule,
    QRCodeModule,
    DeviceDetectorModule.forRoot(),
    BrowserAnimationsModule,
    MatTableModule,
    MatDatepickerModule,
    MatNativeDateModule,
    NgxMaterialTimepickerModule,
  ],
  providers: [
    MatDatepickerModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
