
export class RankData {
  name: Resource;
  vote: string; // Number of votes
  id: string;

  constructor(id: string, name: Resource, vote: string) {
    this.id = id;
    this.name = name;
    this.vote = vote;
  }
}