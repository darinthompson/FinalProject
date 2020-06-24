package com.skilldistillery.esn.entities;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="series_match")
public class SeriesMatch {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String title;
	@Column(name = "team1_title")
	private String team1Title;
	@Column(name = "team2_title")
	private String team2Title;
	@Column(name = "start_date")
	private LocalDate startDate;
	@Column(name = "start_time")
	private LocalTime startTime;
	
	public SeriesMatch() {}

	public SeriesMatch(int id, String title, String team1Title, String team2Title, LocalDate startDate,
			LocalTime startTime) {
		super();
		this.id = id;
		this.title = title;
		this.team1Title = team1Title;
		this.team2Title = team2Title;
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

	public String getTeam1Title() {
		return team1Title;
	}

	public void setTeam1Title(String team1Title) {
		this.team1Title = team1Title;
	}

	public String getTeam2Title() {
		return team2Title;
	}

	public void setTeam2Title(String team2Title) {
		this.team2Title = team2Title;
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
		builder.append(", team1Title=");
		builder.append(team1Title);
		builder.append(", team2Title=");
		builder.append(team2Title);
		builder.append(", startDate=");
		builder.append(startDate);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append("]");
		return builder.toString();
	}
	
}
