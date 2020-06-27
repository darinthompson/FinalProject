import { TestBed } from '@angular/core/testing';

import { GameStatService } from './game-stat.service';

describe('GameStatService', () => {
  let service: GameStatService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GameStatService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
