import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private baseURL = environment.baseURL + 'api/users';

  constructor() { }

}
