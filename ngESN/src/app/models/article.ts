import DateTimeFormat = Intl.DateTimeFormat;
import {Profile} from "./profile";
import {Comment} from "./comment";
import {Game} from "./game";

export class Article {

  id: number;
  title: string;
  content: string;
  image: string;
  createDate: Date;
  author: Profile;
  enabled: boolean;
  comments: Comment[];
  game: Game;

  constructor(id?: number, title?: string, content?: string, image?: string, createDate?: Date, author?: Profile, enabled?: boolean, comments?: Comment[], game?: Game) {
    this.id =id;
    this.title = title;
    this.content = content;
    this.createDate = createDate;
    this.author = author;
    this.enabled = enabled;
    this.comments = comments;
    this.game = game;
  }
}
