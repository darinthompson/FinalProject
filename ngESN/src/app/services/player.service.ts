import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Player } from '../models/player';
import { environment } from 'src/environments/environment';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PlayerService {
  private url = environment.baseURL + 'api/players';

  constructor(private http: HttpClient) {}

  index() {
    return this.http.get<Player[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'PlayerService.index(): Error retrieving players: ' + err
        );
      })
    );
  }
}
