import { Component, OnInit } from '@angular/core';
import { SeriesMatchService } from "../../services/series-match.service";
import { Router } from "@angular/router";
import { SeriesMatch } from "../../models/series-match";
import { ArticleService } from "../../services/article.service";
import { Article } from "../../models/article";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  matches: SeriesMatch[];
  articles: Article[];
  selectedArticle = null;

  constructor(
    private seriesMatchService: SeriesMatchService,
    private articleService: ArticleService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.seriesMatchService.index().subscribe(
      match => {
        this.matches = match;
      },
      fail => {
        console.error(fail);
        this.router.navigateByUrl('badNews');
      }
    );
    this.articleService.getAllArticles().subscribe(
      aritcle => {
        this.articles = aritcle;
      },
      fail => {
        this.router.navigateByUrl('badnews');
      }
    );
  }

  navigateToArticle(id: number) {
    this.getArticle(id);
    this.router.navigateByUrl(`article/${id}`);
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
}


