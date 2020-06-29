import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Organization } from '../models/organization';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class OrganizationService {

  private url = environment.baseURL + 'api/organizations';

  constructor(private http: HttpClient) {}

  index() {
    return this.http.get<Organization[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          'OrganizationService.index(): Error retrieving organizations: ' + err
        );
      })
    );
  }
}
