package com.skilldistillery.esn.entities;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name="series_match")
public class SeriesMatch {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String title;
	
	@Column(name = "start_date")
	private LocalDate startDate;
	
	@Column(name = "start_time")
	private LocalTime startTime;
	
	@JsonIgnoreProperties({"seriesMatch"})
	@ManyToOne
	@JsonIgnore
	@JoinColumn(name="series_id")
	private Series series;
	
	@JsonIgnoreProperties({"matches"})
	@ManyToOne
	@JoinColumn(name="team1_id")
	private Team team1;

	@JsonIgnoreProperties({"matches"})
	@ManyToOne
	@JoinColumn(name="team2_id")
	private Team team2;
	
	@ManyToOne
	@JoinColumn(name = "winner_id")
	private Team winner;
	
	public SeriesMatch() {}

	public SeriesMatch(int id, String title, String team1Title, String team2Title, LocalDate startDate,
			LocalTime startTime) {
		super();
		this.id = id;
		this.title = title;
		this.startDate = startDate;
		this.startTime = startTime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public Series getSeries() {
		return series;
	}

	public void setSeries(Series series) {
		this.series = series;
	}

	public Team getTeam1() {
		return team1;
	}

	public void setTeam1(Team team1) {
		this.team1 = team1;
	}

	public Team getTeam2() {
		return team2;
	}

	public void setTeam2(Team team2) {
		this.team2 = team2;
	}

	public Team getWinner() {
		return winner;
	}

	public void setWinner(Team winner) {
		this.winner = winner;
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
		SeriesMatch other = (SeriesMatch) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SeriesMatch [id=");
		builder.append(id);
		builder.append(", title=");
		builder.append(title);
		builder.append(", startDate=");
		builder.append(startDate);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append(", series=");
		builder.append(series);
		builder.append(", team1=");
		builder.append(team1);
		builder.append(", team2=");
		builder.append(team2);
		builder.append(", winner=");
		builder.append(winner);
		builder.append("]");
		return builder.toString();
	}
	
}
