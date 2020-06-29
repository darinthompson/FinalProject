import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import {environment} from "../../environments/environment";
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Comment } from 'src/app/models/comment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CommentService {
  private url = environment.baseURL + "api/comments";

  constructor(
    private http: HttpClient,
    private auth: AuthService,
  ) { }

  createComment(aid: number, comment: Comment) {
    return this.http.post<Comment>(`${this.url}/${aid}`, comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating comment');
      })
    );
  }

  getAllArticleComments(aid: number) {
    return this.http.get<Comment[]>(`${this.url}/${aid}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('ERROR retrieving comments');
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
