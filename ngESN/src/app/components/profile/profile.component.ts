import { Component, OnInit } from '@angular/core';
import { ProfileService } from 'src/app/services/profile.service';
import { Profile } from 'src/app/models/profile';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  userProfile: Profile;
  username: string;
  dashboardView = null;
  accountView = null;
  articlesView = null;
  adminView = null;

  constructor(
    private profileService: ProfileService
  ) { }

  ngOnInit(): void {
    this.dashboardView = true;
    this.getUsername();
    this.getProfile();
  }

  getUsername() {
    this.username = localStorage.getItem('username');
  }

  getProfile() {
    this.profileService.getByUsername().subscribe(
      profile => {
        console.log(profile);
        this.userProfile = profile;
      },
      fail => {
        console.error('ProfileComponent.getProfile(): Error retrieving profile:');
        console.error(fail);
      }
    );
  }

  setDashboardView() {
    this.dashboardView = true;
    this.accountView = false;
    this.articlesView = false;
    this.adminView  = false;
  }

  setAccountView() {
    this.dashboardView = false;
    this.accountView = true;
    this.articlesView = false;
    this.adminView  = false;
  }

  setArticlesView() {
    this.dashboardView = false;
    this.accountView = false;
    this.articlesView = true;
    this.adminView  = false;
  }

  setAdminView() {
    this.dashboardView = false;
    this.accountView = false;
    this.articlesView = false;
    this.adminView  = true;
  }
}
