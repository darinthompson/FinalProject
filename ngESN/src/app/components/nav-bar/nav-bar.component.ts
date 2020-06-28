import {Component, OnInit} from '@angular/core';
import {User} from "../../models/user";
import {AuthService} from "../../services/auth.service";
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import {NgForm} from "@angular/forms";
import {Router} from "@angular/router";

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {

  constructor(private authService: AuthService, private modalService: NgbModal, private router: Router) {
  }

  closeResult = '';

  ngOnInit(): void {
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  getUsername() {
    return localStorage.getItem('username');
  }

  logIn(form: NgForm) {
    const login = form.value;
    this.authService.login(login.username, login.password).subscribe(
      logSuccess => {
        this.router.navigateByUrl('home');
        console.log(logSuccess);
        this.modalService.dismissAll();
      },
      logFail => {
        this.router.navigateByUrl('fourohfour');
        console.error('LoginComponent.login(): Error loggin in');
        console.error(logFail);
      }
    );
  }

  logOut() {
    this.authService.logout();
  }

  open(content) {
    this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return `with: ${reason}`;
    }
  }
}


