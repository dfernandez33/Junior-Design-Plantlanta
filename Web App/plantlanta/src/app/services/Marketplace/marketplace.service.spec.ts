import { TestBed } from '@angular/core/testing';

import { MarketplaceService } from './marketplace.service';

describe('MarketplaceService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MarketplaceService = TestBed.get(MarketplaceService);
    expect(service).toBeTruthy();
  });
});
