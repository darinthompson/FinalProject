package com.skilldistillery.esn.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Series {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;
	@Column(name = "img_url")
	private String imgURL;
	@OneToMany(mappedBy = "series")
	private List<SeriesMatch> seriesMatch;

	public Series() {

	}

	public Series(int id, String name, String description, String imgURL, List<SeriesMatch> seriesMatch) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.imgURL = imgURL;
		this.seriesMatch = seriesMatch;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public List<SeriesMatch> getSeriesMatch() {
		return seriesMatch;
	}

	public void setSeriesMatch(List<SeriesMatch> seriesMatch) {
		this.seriesMatch = seriesMatch;
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
		Series other = (Series) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Series [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", description=");
		builder.append(description);
		builder.append(", imgURL=");
		builder.append(imgURL);
		builder.append("]");
		return builder.toString();
	}

}
