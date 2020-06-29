import {GameStat} from "./game-stat";
import {Player} from "./player";
import {SeriesMatch} from "./series-match";

export class PlayerMatchStat {

  id: number;
  stat: GameStat;
  player: Player;
  match: SeriesMatch;
  value: number;

  constructor(id?: number, stat?: GameStat, player?: Player, match?: SeriesMatch, value?: number) {
    this.id = id;
    this.stat =stat;
    this.player = player;
    this.match = match;
    this.value = value;
  }
}
