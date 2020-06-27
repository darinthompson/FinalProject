import { Organization } from './organization';

export class Region {
  id: number;
  name: string;
  organizations: Organization[];

  constructor(id?: number, name?: string, organization?: Organization[]) {
    this.id = id;
    this.name = name;
    this.organizations = organization;
  }
}
