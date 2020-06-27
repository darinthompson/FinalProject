import { Game } from './game';
import { Serializer } from 'v8';
import { SeriesMatch } from './series-match';
import { Organization } from './organization';
import { Player } from './player';

export class Team {
  id: number;
  image: string;
  game: Game;
  matchesTeam1: SeriesMatch[];
  matchesTeam2: SeriesMatch[];
  organization: Organization;
  players: Player[];

  constructor(id?: number, image?: string, game?: Game, matchesTeam1?: SeriesMatch[], matchesTeam2?: SeriesMatch[], organization?: Organization, players?: Player[]) {
    this.id = id;
    this.image = image;
    this.game = game;
    this.matchesTeam1 = matchesTeam1;
    this.matchesTeam2 = matchesTeam2;
    this.organization = organization;
    this.players = players;
  }
}
