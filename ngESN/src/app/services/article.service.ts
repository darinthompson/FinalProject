import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { environment } from "../../environments/environment";
import { Article } from "../models/article";
import { catchError } from "rxjs/operators";
import { throwError } from "rxjs";
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ArticleService {

  private url = environment.baseURL + 'api/articles';

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }

  getAllArticles() {
    return this.http.get<Article[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ArticleService.getAllArticles(): Error retrieving list of articles: ' + err);
      })
    );
  }

  getArticleById(id: number) {
    return this.http.get<Article>(this.url + `/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ArticleService.getArticleById(): Error retrieving article: ' + err);
      })
    );
  }

  getAllAuthoredArticles() {
    return this.http.get<Article[]>(this.url + '/author', this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ArticleService.getAllAuthoredArticles(): Error retrieving author articles: ' + err);
      })
    );
  }

  create(article: Article) {
    return this.http.post<Article>(this.url, article, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ArticleService.create(): Error creating article: ' + err);
      })
    );
  }

  destroy(id: number) {
    return this.http.delete<Article>(this.url + `/disable/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ArticleService.destroy(): Error destroying article: ' + err);
      })
    );
  }

  getHttpOptions() {
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };
    return httpOptions;
  }
}
