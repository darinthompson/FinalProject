import {Profile} from "./profile";
import {Article} from "./article";

export class Comment {

  id: number;
  content: string;
  profile: Profile;
  article: Article;
  createAt: Date;

  constructor(id?: number, content?: string, profile?: Profile, article?: Article, createAt?: Date) {
    this.id = id;
    this.content = content;
    this.profile = profile;
    this.article = article;
    this.createAt = createAt;
  }
}
