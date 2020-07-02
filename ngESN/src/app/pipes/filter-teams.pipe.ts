import { Pipe, PipeTransform } from '@angular/core';
import { Team } from '../models/team';
import { Game } from '../models/game';

@Pipe({
  name: 'filterTeams'
})
export class FilterTeamsPipe implements PipeTransform {

  transform(teams: Team[], game: Game): Team[] {
    const filteredTeams: Team[] = [];

    for (let i = 0; i < teams.length; i++) {
        if (teams[i].game.id === game.id) {
          filteredTeams.push(teams[i]);
        }
    }

    console.log(filteredTeams);

    return filteredTeams;
  }

}
