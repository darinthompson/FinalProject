import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Profile} from "../models/profile";
import {catchError} from "rxjs/operators";
import {throwError} from "rxjs";
import {PlayerMatchStat} from "../models/player-match-stat";

@Injectable({
  providedIn: 'root'
})
export class PlayerMatchStatService {

  constructor(private http: HttpClient) { }

  private url = environment.baseURL + 'api/stats';


  getStatByPlayerAndMatch(playerId: number, matchId: number){
    return this.http.get<PlayerMatchStat[]>(`${this.url}/match/${matchId}/player/${playerId}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          ' Error retrieving Match Stats: ' + err
        );
      })
    );
  }
}
