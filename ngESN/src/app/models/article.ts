import DateTimeFormat = Intl.DateTimeFormat;
import {Profile} from "./profile";
import {Comment} from "./comment";

export class Article {

  id: number;
  title: string;
  content: string;
  image: string;
  createDate: Date;
  author: Profile;
  enabled: boolean;
  comments: Comment[];

  constructor(id?: number, title?: string, content?: string, image?: string, createDate?: Date, author?: Profile, enabled?: boolean, comments?: Comment[]) {
    this.id =id;
    this.title = title;
    this.content = content;
    this.createDate = createDate;
    this.author = author;
    this.enabled = enabled;
    this.comments = comments;
  }
}
