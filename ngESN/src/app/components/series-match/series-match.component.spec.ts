import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SeriesMatchComponent } from './series-match.component';

describe('SeriesMatchComponent', () => {
  let component: SeriesMatchComponent;
  let fixture: ComponentFixture<SeriesMatchComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SeriesMatchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SeriesMatchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
