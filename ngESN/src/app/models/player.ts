import { Team } from './team';
import { PlayerMatchStat } from './player-match-stat';

export class Player {
  id: number;
  firstName: string;
  lastName: string;
  handle: string;
  streamURL: string;
  teams: Team[];
  stats: PlayerMatchStat[];

  constructor(id?: number, firstName?: string, lastName?: string, handle?: string, streamURL?: string, teams?: Team[], stats?: PlayerMatchStat[]) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.handle = handle;
    this.streamURL = streamURL;
    this.teams = teams;
    this.stats = stats;
  }
}
