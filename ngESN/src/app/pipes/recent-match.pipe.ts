import {Pipe, PipeTransform} from '@angular/core';
import {SeriesMatch} from "../models/series-match";

@Pipe({
  name: 'recentMatch'
})
export class RecentMatchPipe implements PipeTransform {

  transform(matches: SeriesMatch[], howMany: number = 2): SeriesMatch[] {
    console.log(matches);
    matches.sort((m1, m2) => {
      let gameOrder = m1.team1.game.id - m2.team1.game.id;
      if (gameOrder === 0) {
        gameOrder = m2.startDate.localeCompare(m1.startDate);
      }
      return gameOrder;
    });
    console.log(matches);
    const result: SeriesMatch[] = [];
    let gameFound = 0;
    let currentGame = matches[0].team1.game.id;
    for (let match of matches) {
      if (match.team1.game.id === currentGame) {
        if (gameFound++ < howMany) {
          result.push(match);
        } else {
          continue;
        }
      }else{
        currentGame = match.team1.game.id;
        gameFound =1;
        result.push(match);
      }
    }
    return result;
  }

}
