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

  constructor(
    private profileService: ProfileService
  ) { }

  ngOnInit(): void {
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

}
