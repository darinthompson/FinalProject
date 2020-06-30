import { Component, OnInit } from '@angular/core';
import { ArticleService } from 'src/app/services/article.service';
import { Article } from 'src/app/models/article';
import { ActivatedRoute, Router } from '@angular/router';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { Form } from '@angular/forms';

@Component({
  selector: 'app-article',
  templateUrl: './article.component.html',
  styleUrls: ['./article.component.css']
})
export class ArticleComponent implements OnInit {

  selectedArticle: Article = null;
  newComment: Comment = new Comment();
  newArticle: Article = new Article();
  commentForm: Form;
  comments = [];

  constructor(
    private articleService: ArticleService,
    private currentRoute: ActivatedRoute,
    private commentService: CommentService,
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

  createNewComment(aid: number, comment: Comment) {
    this.commentService.createComment(aid, comment).subscribe(
      success => {
        console.log(comment);
        this.checkRouteForId();
      },
      fail => {
        console.log('ERROR creating comment');
      }
    )
  }

  createNewArticle(article: Article) {
    this.articleService.create(article).subscribe(
      success => {
        console.log(article);
      }
    )
  }

  reload() {
    return this.articleService.getArticleById(this.selectedArticle.id).subscribe(
      success => {
        console.log('SUCCESS');
      },
      fail => {
        console.log('ERROR retrieving data');
      }
    )
  }

  delete() {
    return this.articleService.destroy(this.selectedArticle.id).subscribe(
      success => {
        console.log('SUCCESS deleting article');
        this.checkRouteForId();
      },
      fail => {
        console.log('ERROR deleting article');
      }
    )
  }

  checkRouteForId() {
    const articleIdParam = this.currentRoute.snapshot.paramMap.get('id');
    console.log(articleIdParam);
    const id = parseInt(articleIdParam, 10);
    console.log(id)
    this.articleService.getArticleById(id).subscribe(
      (article) => {
        this.selectedArticle = article;
        this.comments = this.selectedArticle.comments;
        console.log(this.selectedArticle.comments);
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
