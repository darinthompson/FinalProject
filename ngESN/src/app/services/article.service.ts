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

  private url = environment.baseURL;

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }

  getAllArticles() {
    return this.http.get<Article[]>(this.url + 'api/articles').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('index: ' + err);
      })
    )
  }

  getArticleById(id: number) {
    return this.http.get<Article>(this.url + `api/articles/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('index: ' + err);
      })
    )
  }

  create(article: Article) {
    return this.http.post<Article>(this.url + `api/articles`, article, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('index: ' + err);
      })
    )
  }

  destroy(id: number) {
    return this.http.delete<Article>(this.url + `api/articles/disable/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('index: ' + err);
      })
    )
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


