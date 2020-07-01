import {Time} from '@angular/common';
import {Series} from './series';
import {Team} from './team';

export class SeriesMatch {
  id: number;
  title: string;
  startDate: string;
  startTime: string;
  series: Series;
  team1: Team;
  team2: Team;
  winner: Team;

  constructor(
    id?: number,
    title?: string,
    startDate?: string,
    startTime?: string,
    series?: Series,
    team1?: Team,
    team2?: Team,
    winner?: Team
  ) {
    this.id = id;
    this.title = title;
    this.startDate = startDate;
    this.startTime = startTime;
    this.series = series;
    this.team1 = team1;
    this.team2 = team2;
    this.winner = winner;
  }
}
