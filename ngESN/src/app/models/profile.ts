import { User } from './user';
import { Organization } from './organization';
import { Article } from './article';
import { Team } from './team';
import { Player } from './player';
import { Game } from './game';

export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  avatar: string;
  user: User;
  articles: Article[];
  comments: Comment[];
  favoriteOrganizations: Organization[];
  favoriteTeams: Team[];
  favoritePlayers: Player[];
  favoriteGames: Game[];

  constructor(id?: number, firstName?: string, lastName?: string, email?: string, avatar?: string, user?: User, articles?: Article[], comments?: Comment[], favoriteOrganizations?: Organization[], favoriteTeams?: Team[], favoritePlayers?: Player[], favoriteGames?: Game[]) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.avatar = avatar;
    this.user = user;
    this.articles = articles;
    this.comments = comments;
    this.favoriteOrganizations = favoriteOrganizations;
    this.favoriteTeams = favoriteTeams;
    this.favoritePlayers = favoritePlayers;
    this.favoriteGames = favoriteGames;
  }
}
