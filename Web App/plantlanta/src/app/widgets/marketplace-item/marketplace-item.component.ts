import { Component, OnInit, Input } from '@angular/core';
import { MarketplaceItem } from '../../interfaces/marketplace-item';

@Component({
  selector: 'app-marketplace-item',
  templateUrl: './marketplace-item.component.html',
  styleUrls: ['./marketplace-item.component.sass']
})
export class MarketplaceItemComponent implements OnInit {

  @Input() item: MarketplaceItem;

  displayColumns: string[] = ['#', 'code'];

  constructor() { }

  ngOnInit() {
  }

}
