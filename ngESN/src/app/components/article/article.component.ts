import { Component, OnInit } from '@angular/core';
import { ArticleService } from 'src/app/services/article.service';
import { Article } from 'src/app/models/article';
import { ActivatedRoute, Router } from '@angular/router';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';

@Component({
  selector: 'app-article',
  templateUrl: './article.component.html',
  styleUrls: ['./article.component.css']
})
export class ArticleComponent implements OnInit {

  selectedArticle: Article = null;
  comments = [];
  newComment: Comment = new Comment();
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
      },
      fail => {
        console.log('ERROR creating comment');
      }
    )
  }

  addComment(comment: Comment) {
    // this.comments.push(this.commentService.createComment(this.newComment));
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
