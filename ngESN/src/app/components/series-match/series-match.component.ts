import {Component, OnInit} from '@angular/core';
import {SeriesMatchService} from "../../services/series-match.service";
import {SeriesMatch} from "../../models/series-match";
import {ActivatedRoute, Router} from "@angular/router";
import {Player} from "../../models/player";
import {Game} from "../../models/game";

@Component({
  selector: 'app-series-match',
  templateUrl: './series-match.component.html',
  styleUrls: ['./series-match.component.css']
})
export class SeriesMatchComponent implements OnInit {

  bout: SeriesMatch;
  team1Players: Player[];
  team2Players: Player[];


  constructor(private seriesMatchService: SeriesMatchService, private router: Router, private currentRoute: ActivatedRoute) {
  }

  ngOnInit(): void {
    this.checkRouteForId();
  }


  getMatchById(id: number) {
    this.seriesMatchService.getMatchById(id).subscribe(
      data => {
        this.bout = data;
      },
      fail => {
        console.log(fail)
        this.router.navigateByUrl('fourohfour');
      }
    )
  }

  checkRouteForId() {
    const articleIdParam = this.currentRoute.snapshot.paramMap.get('id');
    console.log(articleIdParam);
    const id = parseInt(articleIdParam, 10);
    console.log(id)
    this.seriesMatchService.getMatchById(id).subscribe(
      (game) => {
        this.bout = game;
        console.log(this.bout);
        this.team1Players = this.team1StatsByMatchId(game);
        this.team2Players = this.team2StatsByMatchId(game);
        console.log()
      },
      (fail) => {
        console.log("Error retrieving match");
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }

  team1StatsByMatchId(game: SeriesMatch) {
    let gameplayer: Player[] = [];
    for (let i = 0; i < game.team1.players.length; i++) {
     let newPlayer: Player = new Player();
     newPlayer.stats = [];
     newPlayer.handle = game.team1.players[i].handle;
     newPlayer.id = game.team1.players[i].id;
      for (let j = 0; j < game.team1.players[i].stats.length; j++) {
        if (game.team1.players[i].stats[j].match.id === this.bout.id) {
          newPlayer.stats.push(game.team1.players[i].stats[j]);
        }
      }
      gameplayer.push(newPlayer);
    }
    return gameplayer;
  }

  team2StatsByMatchId(game: SeriesMatch) {
    let gameplayer: Player[] = [];
    for (let i = 0; i < game.team2.players.length; i++) {
      let newPlayer: Player = new Player();
      newPlayer.stats = [];
      newPlayer.handle = game.team2.players[i].handle;
      newPlayer.id = game.team2.players[i].id;
      for (let j = 0; j < game.team2.players[i].stats.length; j++) {
        if (game.team2.players[i].stats[j].match.id === this.bout.id) {
          newPlayer.stats.push(game.team2.players[i].stats[j]);
        }
      }
      gameplayer.push(newPlayer);
    }
    return gameplayer;
  }
}
