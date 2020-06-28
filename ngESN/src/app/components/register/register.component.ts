import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { ProfileService } from 'src/app/services/profile.service';
import { Profile } from 'src/app/models/profile';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  newUser: User = new User();

  constructor(
    private auth: AuthService,
    private profileSvc: ProfileService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  register(user: User) {
    this.auth.register(user).subscribe(
      regSuccess => {
        console.log('User ' + regSuccess + ' created');
        this.newUser = new User();
      },
      regFail => {
        console.error('RegisterComponent.register(): Error on register');
        console.error(regFail);
        this.router.navigateByUrl('fourohfour')
      }
    );
  }

  createProfile(form: NgForm) {
    const profile: Profile = form.value;
    console.log(profile);
    this.profileSvc.create(profile).subscribe(
      createSuccess => {
        this.auth.login(this.newUser.username, this.newUser.password).subscribe(
          logSuccess => {
            this.router.navigateByUrl('home');
            console.log(logSuccess);
          },
          logFail => {
            console.error('AuthService.login(): Error logging in');
            console.error(logFail);
            this.router.navigateByUrl('fourohfour')
          }
        );
      },
      createFail => {
        console.error('RegisterComponent.createProfile(): Error on profile creation');
        console.error(createFail);
        this.router.navigateByUrl('fourohfour')
      }
    );
  }

}
