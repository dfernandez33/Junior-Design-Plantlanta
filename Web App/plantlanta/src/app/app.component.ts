import { Component } from '@angular/core';
import { AngularFireAuth } from '../../node_modules/@angular/fire/auth';
import { Router } from '../../node_modules/@angular/router';
import { first } from "../../node_modules/rxjs/operators";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})
export class AppComponent {

  constructor() {}

}
