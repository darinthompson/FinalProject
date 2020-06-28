import { Component, OnInit } from '@angular/core';
import {User} from "../../models/user";
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

  constructor(private authService: AuthService) { }

  ngOnInit(): void {}

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  getUsername(){
    return localStorage.getItem('username');
  }

}
