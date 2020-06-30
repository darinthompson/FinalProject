import { Pipe, PipeTransform } from '@angular/core';
import {SeriesMatch} from "../models/series-match";

@Pipe({
  name: 'recentMatch'
})
export class RecentMatchPipe implements PipeTransform {

  transform(matches: SeriesMatch[], howMany: number = 2): SeriesMatch[] {
    matches.sort((m1,m2) => {
      let gameOrder = m1.team1.game.id - m2.team1.game.id;
      if (gameOrder === 0){
        
      }
    });
    return null;
  }

}
