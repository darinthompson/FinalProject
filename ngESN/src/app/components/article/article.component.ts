import { Component, OnInit } from '@angular/core';
import { ArticleService } from 'src/app/services/article.service';
import { Article } from 'src/app/models/article';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-article',
  templateUrl: './article.component.html',
  styleUrls: ['./article.component.css']
})
export class ArticleComponent implements OnInit {

  selectedArticle: Article = null;
  constructor(
    private articleService: ArticleService,
    private currentRoute: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.checkRouteForId();
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

  checkRouteForId() {
    const articleIdParam = this.currentRoute.snapshot.paramMap.get('id');
    console.log(articleIdParam);
    const id = parseInt(articleIdParam, 10);
    console.log(id);
    this.articleService.getArticleById(id).subscribe(
      (article) => {
        this.selectedArticle = article;
        console.log(article);
      },
      (fail) => {
        console.log("Error retrieving article");
        console.log(fail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }
}
