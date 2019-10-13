import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VerifyOrganizationComponent } from './verify-organization.component';

describe('VerifyOrganizationComponent', () => {
  let component: VerifyOrganizationComponent;
  let fixture: ComponentFixture<VerifyOrganizationComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VerifyOrganizationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VerifyOrganizationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
