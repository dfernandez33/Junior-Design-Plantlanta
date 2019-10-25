import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { MarketplaceItem } from '../../interfaces/marketplace-item';
import { MarketplaceService } from '../../services/Marketplace/marketplace.service';
import * as algoliasearch from 'algoliasearch';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-marketplace-dashboard',
  templateUrl: './marketplace-dashboard.component.html',
  styleUrls: ['./marketplace-dashboard.component.sass']
})
export class MarketplaceDashboardComponent implements OnInit {

  searchClient;
  index;

  items: MarketplaceItem[];
  filteredItems: MarketplaceItem[] = [];
  loading = true;

  constructor(private marketpalceService: MarketplaceService) { }

  ngOnInit() {
    this.searchClient = algoliasearch(environment.algolia.app, environment.algolia.search_key);
    this.index = this.searchClient.initIndex('Items');
    this.marketpalceService.getItems().subscribe(items => {
      this.loading = false;
      this.items = items;
      this.filteredItems = this.items;
    });
  }

  updateQuery(query) {
    this.index.search({ query: query.srcElement.value }).then(result => {
      let hits = result.hits;
      this.filteredItems = this.items.filter(item => {
        return hits.map(hit => hit.name).includes(item.name) || hits.map(hit => hit.brand).includes(item.brand);
      });
    });
  }

}
