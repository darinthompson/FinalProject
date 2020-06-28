import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../../environments/environment";
import {SeriesMatch} from "../models/series-match";
import {catchError} from "rxjs/operators";
import {throwError} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class SeriesMatchService {

  private url = environment.baseURL + 'api/matches';

  constructor(private http: HttpClient) { }

  index(){
    return this.http.get<SeriesMatch[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('index: ' + err);
      })
    )

  }
}
