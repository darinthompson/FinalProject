package com.skilldistillery.esn.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "player_match_stat")
public class PlayerMatchStat {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private double value;
	
	@ManyToOne
	@JoinColumn(name = "game_stat_id")
	private GameStat stat;
	
	@ManyToOne
	@JsonIgnoreProperties("stats")
	@JoinColumn(name = "player_match_player_id")
	private Player player;
	
	@ManyToOne
	@JsonIgnoreProperties({"team1", "team2", "winner"})
	@JoinColumn(name = "player_match_series_match_id")
	private SeriesMatch match;

	public PlayerMatchStat() {

	}

	public PlayerMatchStat(int id, double value) {
		super();
		this.id = id;
		this.value = value;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public GameStat getStat() {
		return stat;
	}

	public void setStat(GameStat stat) {
		this.stat = stat;
	}

	public Player getPlayer() {
		return player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}

	public SeriesMatch getMatch() {
		return match;
	}

	public void setMatch(SeriesMatch match) {
		this.match = match;
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
		PlayerMatchStat other = (PlayerMatchStat) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("PlayerMatchStat [id=");
		builder.append(id);
		builder.append(", value=");
		builder.append(value);
		builder.append("]");
		return builder.toString();
	}

}
