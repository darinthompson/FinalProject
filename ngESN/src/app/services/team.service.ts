import { Injectable } from '@angular/core';
import { Team } from '../models/team';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TeamService {

  private url = environment.baseURL + 'api/teams';

  constructor(private http: HttpClient) {}

  index() {
    return this.http.get<Team[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'TeamService.index(): Error retrieving teams: ' + err
        );
      })
    );
  }
}
