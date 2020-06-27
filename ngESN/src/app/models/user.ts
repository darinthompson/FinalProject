import {Profile} from "./profile";

export class User {

  id: number;
  username: string;
  password: string;
  enabled: boolean;
  role: string;
  profile: Profile;

  constructor(id?: number, username?: string, password?: string, enabled?: boolean, role?: string, profile?: Profile) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.enabled = enabled;
    this.role = role;
    this.profile = profile;
  }
}
