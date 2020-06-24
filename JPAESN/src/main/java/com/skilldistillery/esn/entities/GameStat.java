package com.skilldistillery.esn.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="game_stat")
public class GameStat {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "stat_name")
	private String statName;
	@Column(name = "stat_description")
	private String statDescription;
	@ManyToOne
	@JoinColumn(name="game_id")
	private Game game;
	
	public GameStat() {
		
	}

	public GameStat(int id, String statName, String statDescription) {
		super();
		this.id = id;
		this.statName = statName;
		this.statDescription = statDescription;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStatName() {
		return statName;
	}

	public void setStatName(String statName) {
		this.statName = statName;
	}

	public String getStatDescription() {
		return statDescription;
	}

	public void setStatDescription(String statDescription) {
		this.statDescription = statDescription;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
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
		GameStat other = (GameStat) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("GameStat [id=");
		builder.append(id);
		builder.append(", statName=");
		builder.append(statName);
		builder.append(", statDescription=");
		builder.append(statDescription);
		builder.append("]");
		return builder.toString();
	}
	
}
