import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {Game} from "../models/game";
import {catchError} from "rxjs/operators";
import {throwError} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class GameService {

  private url = environment.baseURL;

  constructor(private http: HttpClient) { }

  getGameById(id: number){
    return this.http.get<Game>(this.url + `api/games/${id}`).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError('index: ' + err);
    })
  )
  }

}
