import { Component, OnInit } from '@angular/core';
import {SeriesMatchService} from "../../services/series-match.service";
import {SeriesMatch} from "../../models/series-match";
import {ActivatedRoute, Router} from "@angular/router";

@Component({
  selector: 'app-series-match',
  templateUrl: './series-match.component.html',
  styleUrls: ['./series-match.component.css']
})
export class SeriesMatchComponent implements OnInit {

  match: SeriesMatch;

  constructor(private seriesMatchService: SeriesMatchService, private router: Router, private currentRoute: ActivatedRoute) { }

  ngOnInit(): void {
    this.checkRouteForId();
  }


  getMatchById(id: number){
    this.seriesMatchService.getMatchById(id).subscribe(
      data => {
        this.match = data;
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
        this.match = game;
        console.log(this.match);
      },
      (fail) => {
        console.log("Error retrieving match");
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }
}
