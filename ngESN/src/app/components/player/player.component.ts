import {Component, OnInit} from '@angular/core';
import {PlayerService} from "../../services/player.service";
import {ActivatedRoute, Router} from "@angular/router";
import {Player} from "../../models/player";

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.css']
})
export class PlayerComponent implements OnInit {

  player: Player;

  constructor(private playerService: PlayerService, private router: Router, private currentRoute: ActivatedRoute) {
  }

  ngOnInit(): void {
    this.checkRouteForId();
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
      },
      (fail) => {
        console.log("Error retrieving player");
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }
}
