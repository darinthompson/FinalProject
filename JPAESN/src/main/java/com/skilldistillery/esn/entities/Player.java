package com.skilldistillery.esn.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Player {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "first_name")
	private String firstName;
	
	@Column(name = "last_name")
	private String lastName;
	private String handle;
	
	@Column(name = "stream_url")
	private String streamURL;

	@JsonIgnoreProperties("players")
	@ManyToMany
	@JoinTable(name = "team_join_player", joinColumns = @JoinColumn(name = "player_id"), inverseJoinColumns = @JoinColumn(name = "team_id"))
	private List<Team> teams;

	@JsonIgnoreProperties("match")
	@OneToMany(mappedBy = "player")
	private List<PlayerMatchStat> stats;

	public Player() {
	}

	public Player(int id, String firstName, String lastName, String handle, String streamURL, List<Team> teams) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.handle = handle;
		this.streamURL = streamURL;
		this.teams = teams;
	}

	public List<Team> getTeams() {
		return teams;
	}

	public void setTeams(List<Team> teams) {
		this.teams = teams;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getHandle() {
		return handle;
	}

	public void setHandle(String handle) {
		this.handle = handle;
	}

	public String getStreamURL() {
		return streamURL;
	}

	public void setStreamURL(String streamURL) {
		this.streamURL = streamURL;
	}

	public List<PlayerMatchStat> getStats() {
		return stats;
	}

	public void setStats(List<PlayerMatchStat> stats) {
		this.stats = stats;
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
		Player other = (Player) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Player [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", handle=");
		builder.append(handle);
		builder.append(", streamURL=");
		builder.append(streamURL);
		builder.append("]");
		return builder.toString();
	}

}
