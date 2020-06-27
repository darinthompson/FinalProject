import { TestBed } from '@angular/core/testing';

import { PlayerMatchStatService } from './player-match-stat.service';

describe('PlayerMatchStatService', () => {
  let service: PlayerMatchStatService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PlayerMatchStatService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
