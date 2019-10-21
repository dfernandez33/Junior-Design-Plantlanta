import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { MarketplaceItem } from '../../interfaces/marketplace-item';
import { MarketplaceService } from '../../services/Marketplace/marketplace.service';

@Component({
  selector: 'app-marketplace-dashboard',
  templateUrl: './marketplace-dashboard.component.html',
  styleUrls: ['./marketplace-dashboard.component.sass']
})
export class MarketplaceDashboardComponent implements OnInit {

  items: MarketplaceItem[];
  loading = true;

  constructor(private marketpalceService: MarketplaceService) { }

  ngOnInit() {
    this.marketpalceService.getItems().subscribe(items => {
      this.loading = false;
      this.items = items;
    });
  }

}
