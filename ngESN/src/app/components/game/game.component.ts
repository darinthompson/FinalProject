import {SeriesMatchService} from './../../services/series-match.service';
import {Component, OnInit} from '@angular/core';
import {GameService} from "../../services/game.service";
import {ActivatedRoute, NavigationEnd, Router} from "@angular/router";
import {Game} from "../../models/game";
import {SeriesMatch} from "../../models/series-match";
import { ArticleService } from 'src/app/services/article.service';
import { Article } from "../../models/article";

@Component({
  selector: 'app-game',
  templateUrl: './game.component.html',
  styleUrls: ['./game.component.css']
})
export class GameComponent implements OnInit {

  navSubscription;
  selected: Game;
  selectedArticle = null;
  matchList: SeriesMatch[];
  gameArticles: Article[] = [];

  constructor(private gameService: GameService,
    private seriesMatchService: SeriesMatchService,
     private currentRoute: ActivatedRoute,
     private router: Router,
     private articleService: ArticleService) {
    this.navSubscription = this.router.events.subscribe((e: any) => {
      if (e instanceof NavigationEnd) {
        this.initialize();
      }
    });

  }

  ngOnInit(): void {
    this.checkRouteForId();
  }

  ngOnDestroy() {
    if (this.navSubscription) {
      this.navSubscription.unsubscribe();
    }
  }

  checkRouteForId() {
    const gameIdParam = this.currentRoute.snapshot.paramMap.get('id');
    const gameId = parseInt(gameIdParam, 10);
    this.gameService.getGameById(gameId).subscribe(
      (game) => {
        this.getArticlesByGameId(gameId);
        this.selected = game;
        this.seriesMatchService.getMatchesById(gameId).subscribe(
          matches => {
            this.matchList = matches;
          },
          fail => {
            this.matchList = null;
          }
        )
      },
      (fail) => {
        console.error('Error retrieving game');
        console.error(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }

  initialize() {
    this.selected = null;
    this.matchList = [];
    this.checkRouteForId();
  }

  getArticlesByGameId(id: number) {
    this.articleService.getArticlesByGameId(id).subscribe(
      success => {
        this.gameArticles = success;
        console.log("SUCCESS retrieving articles");
      },
      fail => {
        console.log('ERROR retrieving articles.');
      }
    )
  }

  getSeriesMatchById(id: number){
    this.seriesMatchService.getMatchById(id).subscribe(
      success => {
        this.router.navigateByUrl(`match/${id}`)
      },
      fail => {
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    )
  }

  getArticle(id: number) {
    this.articleService.getArticleById(id).subscribe(
      success => {
        this.selectedArticle = success;
      },
      fail => {
        console.log("error getting article");
      }
    )
  }

  navigateToArticle(id: number) {
    this.getArticle(id);
    this.router.navigateByUrl(`article/${id}`);
  }

}
