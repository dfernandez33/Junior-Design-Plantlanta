import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { MarketplaceDashboardComponent } from './marketplace-dashboard.component';

describe('MarketplaceDashboardComponent', () => {
  let component: MarketplaceDashboardComponent;
  let fixture: ComponentFixture<MarketplaceDashboardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ MarketplaceDashboardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MarketplaceDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
