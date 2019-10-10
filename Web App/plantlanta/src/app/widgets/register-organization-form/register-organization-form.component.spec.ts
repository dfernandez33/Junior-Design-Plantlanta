import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegisterOrganizationFormComponent } from './register-organization-form.component';

describe('RegisterOrganizationFormComponent', () => {
  let component: RegisterOrganizationFormComponent;
  let fixture: ComponentFixture<RegisterOrganizationFormComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegisterOrganizationFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegisterOrganizationFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
