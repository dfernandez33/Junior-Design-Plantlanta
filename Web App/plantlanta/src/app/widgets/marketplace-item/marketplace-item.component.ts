import { Component, OnInit, Input } from '@angular/core';
import { MarketplaceItem } from '../../interfaces/marketplace-item';
import { Router } from '@angular/router';


@Component({
  selector: 'app-marketplace-item',
  templateUrl: './marketplace-item.component.html',
  styleUrls: ['./marketplace-item.component.sass']
})
export class MarketplaceItemComponent implements OnInit {

  @Input() item;
  itemData;

  displayColumns: string[] = ['#', 'code'];

  constructor(private router: Router) { }

  ngOnInit() {
    this.itemData = this.item.data();
  }

  editItem() {
    this.router.navigate(["/create_item/" + this.item.id])
  }

}
