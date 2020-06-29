import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { Profile } from '../models/profile';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Team } from '../models/team';
import { Game } from '../models/game';
import { Organization } from '../models/organization';
import { Player } from '../models/player';

@Injectable({
  providedIn: 'root',
})
export class ProfileService {
  private url = environment.baseURL + 'api/profiles';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private router: Router
  ) {}

  index() {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.get<Profile>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.index(): Error retrieving profiles: ' + err
        );
      })
    );
  }

  show(id: number) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.get<Profile>(this.url+`/${id}`, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.show(): Error retrieving profile: ' + err
        );
      })
    );
  }

  create(profile: Profile) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.post<Profile>(this.url, profile, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.create(): Error creating profile: ' + err
        );
      })
    );
  }

  update(profile: Profile, id: number) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+`/${id}`, profile, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.update(): Error updating profile: ' + err
        );
      })
    );
  }

  addTeam(team: Team) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/addTeam', team, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.addTeam(): Error adding team to profile: ' + err
        );
      })
    );
  }

  addGame(game: Game) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/addGame', game, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.addGame(): Error adding game to profile: ' + err
        );
      })
    );
  }

  addOrg(org: Organization) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/addOrg', org, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.addOrg(): Error adding organization to profile: ' + err
        );
      })
    );
  }

  addPlayer(player: Player) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/addPlayer', player, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.addPlayer(): Error adding player to profile: ' + err
        );
      })
    );
  }

  removeTeam(team: Team) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/removeTeam', team, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.removeTeam(): Error removing team from profile: ' + err
        );
      })
    );
  }

  removeGame(game: Game) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/removeGame', game, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.removeGame(): Error removing game from profile: ' + err
        );
      })
    );
  }

  removeOrg(org: Organization) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/removeOrg', org, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.removeOrg(): Error removing organization from profile: ' + err
        );
      })
    );
  }

  removePlayer(player: Player) {
    const httpOptions = this.getHttpOptions();

    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('home');
    }

    return this.http.put<Profile>(this.url+'/removePlayer', player, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'ProfileService.removePlayer(): Error removing player from profile: ' + err
        );
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
