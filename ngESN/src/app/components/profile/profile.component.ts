import { Component, OnInit } from '@angular/core';
import { ProfileService } from 'src/app/services/profile.service';
import { Profile } from 'src/app/models/profile';
import { OrganizationService } from 'src/app/services/organization.service';
import { Organization } from 'src/app/models/organization';
import { Team } from 'src/app/models/team';
import { Player } from 'src/app/models/player';
import { PlayerService } from 'src/app/services/player.service';
import { TeamService } from 'src/app/services/team.service';
import { Game } from 'src/app/models/game';
import { GameService } from 'src/app/services/game.service';
import { ArticleService } from 'src/app/services/article.service';
import { NgForm } from '@angular/forms';
import { Article } from 'src/app/models/article';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  userProfile: Profile;
  username: string;
  allOrgs: Organization[];
  allTeams: Team[];
  allPlayers: Player[];
  selectedView: string = null;
  games: Game[] = [];
  selectedGame: Game = null;
  profileArticles: Article[] = null;

  constructor(
    private profileService: ProfileService,
    private orgService: OrganizationService,
    private teamService: TeamService,
    private playerService: PlayerService,
    private gameService: GameService,
    private articleService: ArticleService
  ) { }

  ngOnInit(): void {
    this.selectedView = 'dashboard';
    this.getUsername();
    this.getProfile();
    this.getAllGames();
    // this.getAllOrgs();
    this.getProfileArticles();
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

  getAllOrgs() {
    this.orgService.index().subscribe(
      orgs => {
        console.log(orgs);
        this.allOrgs = orgs;
      },
      fail => {
        console.error('ProfileComponent.getAllOrgs(): Error retrieving list of organizations:');
        console.error(fail);
      }
    );
  }

  getAllTeams() {
    this.teamService.index().subscribe(
      teams => {
        console.log(teams);
        this.allTeams = teams;
      },
      fail => {
        console.error('ProfileComponent.getAllTeams(): Error retrieving list of teams:');
        console.error(fail);
      }
    );
  }

  getAllPlayers() {
    this.playerService.index().subscribe(
      players => {
        console.log(players);
        this.allPlayers = players;
      },
      fail => {
        console.error('ProfileComponent.getAllPlayers(): Error retrieving list of players:');
        console.error(fail);
      }
    );
  }

  getAllGames() {
    this.gameService.index().subscribe(
      games => {
        console.log(games);
        this.games = games;
        this.selectedGame = this.games[0];
      },
      fail => {
        console.error('ProfileComponent.getAllGames(): Error retrieving list of games:');
        console.error(fail);
      }
    );
  }

  setSelectedGame(game: Game) {
    console.log('Setting selected game');
    console.log(game);
    this.selectedGame = game;
  }

  publishArticle(form: NgForm) {
    const newArticle: Article = form.value;
    this.articleService.create(newArticle).subscribe(
      article => {
        console.log(article);
        this.getProfileArticles();
      },
      fail => {
        console.error('ProfileComponent.publishArticle(): Error publishing article:');
        console.error(fail);
      }
    );
  }

  getProfileArticles() {
    this.articleService.getAllAuthoredArticles().subscribe(
      articles => {
        console.log(articles);
        this.profileArticles = articles;
      },
      fail => {
        console.error('ProfileComponent.getProfileArticles(): Error retrieving authored articles:');
        console.error(fail);
      }
    );
  }
}
