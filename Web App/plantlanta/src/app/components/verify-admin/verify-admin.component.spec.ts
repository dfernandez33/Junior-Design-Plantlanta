import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VerifyAdminComponent } from './verify-admin.component';

describe('VerifyAdminComponent', () => {
  let component: VerifyAdminComponent;
  let fixture: ComponentFixture<VerifyAdminComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VerifyAdminComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VerifyAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
