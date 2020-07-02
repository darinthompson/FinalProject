import { Pipe, PipeTransform } from '@angular/core';
import { Organization } from '../models/organization';
import { Game } from '../models/game';

@Pipe({
  name: 'filterOrgs'
})
export class FilterOrgsPipe implements PipeTransform {

  transform(orgs: Organization[], game: Game): Organization[] {
    const paramOrgs: Organization[] = orgs;
    const filteredOrgs = [];
    const paramGame = game;

    console.log('orgs param: ' + orgs);
    console.log('orgs param var: ' + paramOrgs);

    if (orgs) {
      for (let i = 0; i < orgs.length; i++) {
        if (orgs[i].teams) {
          console.log('orgs[i].teams: ' + orgs[i].teams);

          for (let j = 0; j < orgs[i].teams.length; j++) {
            if (orgs[i].teams[j].game.id === game.id) {
              filteredOrgs.push(orgs[i]);
            }
          }
        }
      }
    }

    // for (let i = 0; i < orgs.length; i++) {
    //   let teamsArray = [];
    //   teamsArray.push(orgs[i].teams);
    //   for (let j = 0; j < teamsArray.length; j++) {
    //     let currentTeam = teamsArray[j];
    //     let currentTeamGame = currentTeam.game;
    //     if (currentTeamGame.id === paramGame.id) {
    //       filteredOrgs.push(orgs[i]);
    //     }
    //   }
    // }

    return filteredOrgs;
  }

}
