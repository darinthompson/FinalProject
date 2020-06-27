import { SeriesMatch } from './series-match';

export class Series {
  id: number;
  name: string;
  description: string;
  imgURL: string;
  seriesMatch: SeriesMatch[];

  constructor(id?: number, name?: string, description?: string, imgURL?: string, seriesMatch?: SeriesMatch[]) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imgURL = imgURL;
    this.seriesMatch = seriesMatch;
  }
}
