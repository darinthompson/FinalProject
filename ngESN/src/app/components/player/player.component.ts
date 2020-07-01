import {Component, OnInit} from '@angular/core';
import {PlayerService} from "../../services/player.service";
import {ActivatedRoute, Router} from "@angular/router";
import {Player} from "../../models/player";
import {SeriesMatch} from "../../models/series-match";
import {ProfileService} from "../../services/profile.service";
import {TeamService} from "../../services/team.service";
import {SeriesMatchService} from "../../services/series-match.service";
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.css']
})
export class PlayerComponent implements OnInit {

  player: Player;
  recentMatches: SeriesMatch[] = [];
  loggedIn: boolean;


  constructor(private playerService: PlayerService,
              private profileService: ProfileService,
              private teamService: TeamService,
              private authService: AuthService,
              private seriesMatchService: SeriesMatchService,
              private router: Router,
              private currentRoute: ActivatedRoute) {
  }

  ngOnInit(): void {
    this.checkRouteForId();
    this.checklogin();
  }

  getPlayerById(id: number) {
    this.playerService.getPlayerById(id).subscribe(
      data => {
        this.player = data;
      },
      err => {
        console.log(err);
        this.router.navigateByUrl('fourohfour');
      }
    )
  }

  checkRouteForId() {
    const matchIdParam = this.currentRoute.snapshot.paramMap.get('id');
    const id = parseInt(matchIdParam, 10);
    this.playerService.getPlayerById(id).subscribe(
      (data) => {
        this.player = data;
        this.teamService.getMatchesByTeamId(this.player.teams[this.player.teams.length - 1].id).subscribe(
          data => {
            this.recentMatches = data
          },
          err => {
            console.log(err);
            this.router.navigateByUrl('fourohfour');
          }
        )
      },
      (fail) => {
        console.log("Error retrieving player");
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }

  getPlayersStats(currentPlayer: Player) {
    let statSummary = [];
    let statAverages = [];
    let index = 0;
    let keys = {};
    for (let stat of currentPlayer.stats) {
      if (!keys.hasOwnProperty(stat.stat.id)) {
        keys[stat.stat.id] = index++;
      }
      let gameStatId = keys[stat.stat.id];
      if (statSummary[gameStatId]) {
        statSummary[gameStatId].value += stat.value;
        statSummary[gameStatId].totalMatches += 1;
      } else {
        statSummary[gameStatId] = {};
        statSummary[gameStatId].value = stat.value;
        statSummary[gameStatId].name = stat.stat.statName;
        statSummary[gameStatId].totalMatches = 1;
      }
    }
    for (let stat of statSummary){
      stat.average = stat.value / stat.totalMatches;
      console.log(stat);
    }
    return statSummary;
  }

  addFavoritePlayer(player: Player) {
    this.profileService.addPlayer(player).subscribe(
      data => {
        console.log(data);
      },
      err => {
        console.log(err);
        this.router.navigateByUrl('fourohfour');
      }
    )
  }

navagateToMatch(id: number){
    this.router.navigateByUrl(`match/${id}`)
}

checklogin(){
    this.loggedIn = this.authService.checkLogin();
}
}

