import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { Profile } from '../models/profile';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {

  private url = environment.baseURL + 'api/profiles';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private router: Router
  ) { }

  create(profile: Profile) {
    const httpOptions = this.getHttpOptions();

    // if (!this.auth.checkLogin()) {
    //   this.router.navigateByUrl('login');
    // }

    return this.http.post<Profile>(this.url, profile, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ProfileService.create(): Error creating profile: ' + err);
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
