import { Pipe, PipeTransform } from '@angular/core';
import { Organization } from '../models/organization';
import { Game } from '../models/game';

@Pipe({
  name: 'filterOrgs'
})
export class FilterOrgsPipe implements PipeTransform {

  transform(orgs: Organization[], game: Game): Organization[] {
    const filteredOrgs = [];

    for (let i = 0; i < orgs.length; i++) {
      let teamsArray = orgs[i].teams;
      for (let j = 0; j < teamsArray.length; j++) {
        if (teamsArray[j].game.id === game.id) {
          filteredOrgs.push(orgs[i]);
        }
      }
    }

    // orgs.forEach(function(org) {

    //   org.teams.forEach(function(team)  {
    //     if (team.game.id === game.id) {
    //       filteredOrgs.push(org);
    //     }
    //   })
    // })

    return filteredOrgs;
  }

}
