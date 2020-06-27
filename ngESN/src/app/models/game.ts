import {GameStat} from "./game-stat";
import { Team } from './team';

export class Game {

  id: number;
  title: string;
  genre: string;
  imgURL: string;
  websiteURL: string;
  gameStat: GameStat[];
  teams: Team[];

  constructor(id?: number, title?: string, genre?: string, imgURL?: string, websiteURL?: string, gameStat?: GameStat[], teams?: Team[]) {
    this.id = id;
    this.title = title;
    this.genre = genre;
    this.imgURL = imgURL;
    this.websiteURL = websiteURL;
    this.gameStat = gameStat;
    this.teams = teams;
  }
}
