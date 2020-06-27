import {Region} from "./region";
import {Team} from "./team";

export class Organization {

  id: number;
  name: string;
  description: string;
  logoURL: string;
  region: Region;
  teams: Team[];

  constructor(id?: number, name?: string, description?: string, logoURL?: string, region?: Region, teams?: Team[]) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.logoURL = logoURL;
    this.region = region;
    this.teams = teams;
  }
}
