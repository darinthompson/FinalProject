import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { ProfileService } from 'src/app/services/profile.service';
import { Profile } from 'src/app/models/profile';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit {
  newUser: User = new User();
  newProfile: Profile = new Profile();

  constructor(
    private auth: AuthService,
    private profileSvc: ProfileService,
    private router: Router,
    private userSvc: UserService
  ) {}

  ngOnInit(): void {}

  registerUserAndProfile(user: User, profile: Profile) {
    this.auth.register(user).subscribe(
      (regSuccess) => {
        console.log('User ' + regSuccess + ' created');
        this.newUser = new User();
        this.auth.login(user.username, user.password).subscribe(
          (logSuccess) => {
            this.profileSvc.create(profile).subscribe(
              (createSuccess) => {
                console.log('Successfully created: ' + createSuccess);
                this.router.navigateByUrl('home');
              },
              (createFail) => {
                console.error('RegisterComponent.createProfile(): Error on profile creation');
                console.error(createFail);
                this.router.navigateByUrl('fourohfour');
              }
            );
          },
          (logFail) => {
            console.error('AuthService.login(): Error logging in');
            console.error(logFail);
            this.router.navigateByUrl('fourohfour');
          }
        );
      },
      (regFail) => {
        console.error('RegisterComponent.register(): Error on register');
        console.error(regFail);
        this.router.navigateByUrl('fourohfour');
      }
    );
  }
}
