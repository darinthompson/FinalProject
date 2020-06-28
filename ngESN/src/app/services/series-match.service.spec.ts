import { TestBed } from '@angular/core/testing';

import { SeriesMatchService } from './series-match.service';

describe('SeriesMatchService', () => {
  let service: SeriesMatchService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SeriesMatchService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
