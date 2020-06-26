package com.skilldistillery.esn.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
public class Team {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "img_url")
	private String image;
	
	@ManyToOne
	@JoinColumn(name = "game_id")
	private Game game;
	
	@OneToMany(mappedBy = "team1")
	@JsonIgnore
	private List<SeriesMatch> matchesTeam1;

	@OneToMany(mappedBy = "team2")
	@JsonIgnore
	private List<SeriesMatch> matchesTeam2;
	
	@ManyToOne
	@JoinColumn(name = "organization_id")
	private Organization organization;
	
	@ManyToMany(mappedBy = "teams")
	private List<Player> players;
	
	@JsonIgnore
	@Transient
	public List<SeriesMatch> getMatches() {
		List<SeriesMatch> matches = new ArrayList<>();
		matches.addAll(matchesTeam1);
		matches.addAll(matchesTeam2);
		return matches;
	}
	
	public Team() {}

	public Team(int id, String image, Game game, List<Player> players) {
		super();
		this.id = id;
		this.image = image;
		this.game = game;
		this.players = players;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public List<SeriesMatch> getMatchesTeam1() {
		return matchesTeam1;
	}

	public void setMatchesTeam1(List<SeriesMatch> matchesTeam1) {
		this.matchesTeam1 = matchesTeam1;
	}

	public List<SeriesMatch> getMatchesTeam2() {
		return matchesTeam2;
	}

	public void setMatchesTeam2(List<SeriesMatch> matchesTeam2) {
		this.matchesTeam2 = matchesTeam2;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public List<Player> getPlayers() {
		return players;
	}

	public void setPlayers(List<Player> players) {
		this.players = players;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Team other = (Team) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Team [id=");
		builder.append(id);
		builder.append(", image=");
		builder.append(image);
		builder.append(", game=");
		builder.append(game);
		builder.append(", matchesTeam1=");
		builder.append(matchesTeam1);
		builder.append(", matchesTeam2=");
		builder.append(matchesTeam2);
		builder.append(", organization=");
		builder.append(organization);
		builder.append("]");
		return builder.toString();
	}

}
