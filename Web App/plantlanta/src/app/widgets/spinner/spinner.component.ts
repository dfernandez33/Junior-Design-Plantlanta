import { Component, OnInit, Input } from '@angular/core';
import { NgxSpinnerService } from '../../../../node_modules/ngx-spinner';

@Component({
  selector: 'app-spinner',
  templateUrl: './spinner.component.html',
  styleUrls: ['./spinner.component.sass']
})
export class SpinnerComponent implements OnInit {

  @Input() message: string;
  @Input() isFullScreen: boolean = true;

  constructor(private spinner: NgxSpinnerService) { }

  ngOnInit() {
  }

  show() {
    this.spinner.show();
  }

  hide() {
    this.spinner.hide()
  }
}
