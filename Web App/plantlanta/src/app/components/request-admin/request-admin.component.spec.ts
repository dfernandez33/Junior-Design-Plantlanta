import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RequestAdminComponent } from './request-admin.component';

describe('RequestAdminComponent', () => {
  let component: RequestAdminComponent;
  let fixture: ComponentFixture<RequestAdminComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RequestAdminComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RequestAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
