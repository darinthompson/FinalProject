import { Component, OnInit } from '@angular/core';
import {GameService} from "../../services/game.service";
import {ActivatedRoute, Router} from "@angular/router";
import {Game} from "../../models/game";

@Component({
  selector: 'app-game',
  templateUrl: './game.component.html',
  styleUrls: ['./game.component.css']
})
export class GameComponent implements OnInit {

  constructor(private gameService: GameService, private currentRoute: ActivatedRoute, private router: Router) { }

  selected: Game

  ngOnInit(): void {
    this.checkRouteForId();
  }

  checkRouteForId() {
    const gameIdParam = this.currentRoute.snapshot.paramMap.get('id');
    console.log(gameIdParam);
    const gameId = parseInt(gameIdParam, 10);
    console.log(gameId);
    this.gameService.getGameById(gameId).subscribe(
      (game) => {
        this.selected = game;
        console.log(game);
      },
      (fail) => {
        console.error('Error retrieving game');
        console.error(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }
}
