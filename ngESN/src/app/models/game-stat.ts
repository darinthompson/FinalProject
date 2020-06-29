import {Game} from "./game";

export class GameStat {

  id: number;
  statName: string;
  statDescription: string;
  game: Game;

  constructor(id?: number, statName?: string, statDescription?: string, game?: Game) {
    this.id = id;
    this.statName = statName;
    this.statDescription = statDescription;
    this.game = game;
  }
}
