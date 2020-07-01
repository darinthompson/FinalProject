import { Team } from './team';
import { PlayerMatchStat } from './player-match-stat';

export class Player {
  id: number;
  firstName: string;
  lastName: string;
  handle: string;
  imgURL: string;
  teams: Team[];
  stats: PlayerMatchStat[];

  constructor(id?: number, firstName?: string, lastName?: string, handle?: string, imgURL?: string, teams?: Team[], stats?: PlayerMatchStat[]) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.handle = handle;
    this.imgURL = imgURL;
    this.teams = teams;
    this.stats = stats;
  }
}
