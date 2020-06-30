import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Game } from '../models/game';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class GameService {
  private url = environment.baseURL + 'api/games';

  constructor(private http: HttpClient) {}

  index() {
    return this.http.get<Game[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('GameService.index(): Error retrieving list of games: ' + err);
      })
    );
  }

  getGameById(id: number) {
    return this.http.get<Game>(this.url + `/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('GameService.getGameById(): Error retrieving game: ' + err);
      })
    );
  }

}
