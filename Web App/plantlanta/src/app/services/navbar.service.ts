import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class NavbarService {

  visible: boolean;
  dashboard: boolean;
  newEvent: boolean;

  constructor() { this.visible = false; }

  show() { this.visible = true; }

  hide() { this.visible = false; }

  setActive(url: string) {
    if (url == "/dashboard" || url == "/") {
      this.dashboard = true;
      this.newEvent = false;
    } else if (url == "/create_event") {
      this.dashboard == false;
      this.newEvent == true;
    }
  }
}
