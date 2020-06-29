import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Article} from "../models/article";
import {catchError} from "rxjs/operators";
import {throwError} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class ArticleService {

  private url = environment.baseURL;

  constructor(private http: HttpClient) { }

  getAllArticles(){
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

}
