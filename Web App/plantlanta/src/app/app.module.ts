import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { ReactiveFormsModule } from '@angular/forms';
import { QRCodeModule } from 'angularx-qrcode';

import { AngularFireModule } from '@angular/fire';
import { AngularFireAuthModule } from '@angular/fire/auth';
import { AngularFireFunctionsModule } from '@angular/fire/functions';
import { HomeComponent } from './components/home/home.component';
import { VerifyEmailComponent } from './components/verify-email/verify-email.component';
import { NgxSpinnerModule } from "ngx-spinner";
import { SpinnerComponent } from './widgets/spinner/spinner.component';
import { VerifyAdminComponent } from './components/verify-admin/verify-admin.component';
import { RequestAdminComponent } from './components/request-admin/request-admin.component';
import { HttpClientModule } from '../../node_modules/@angular/common/http';
import { MenuComponent } from './components/menu/menu.component';
import { EventcardComponent } from './widgets/eventcard/eventcard.component';

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
    HomeComponent,
    VerifyEmailComponent,
    SpinnerComponent,
    VerifyAdminComponent,
    RequestAdminComponent,
    MenuComponent,
    EventcardComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireAuthModule,
    AngularFireFunctionsModule,
    NgxSpinnerModule,
    HttpClientModule,
    QRCodeModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
