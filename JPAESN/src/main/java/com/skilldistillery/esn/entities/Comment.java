package com.skilldistillery.esn.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Comment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String content;
	
	@JsonIgnoreProperties({"articles", "comments", "favoriteOrganizations", "favoriteTeams",
							"favoritePlayers", "favoriteGames", "user"})
	@ManyToOne
	@JoinColumn(name = "profile_id")
	private Profile profile;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="article_id")
	private Article article;
	
	@Column(name="create_date")
	private LocalDateTime createAt;
	private boolean enabled;
	
	public Comment() {}
	
	public Comment(int id, String content, Profile profile, Article article, LocalDateTime createAt) {
		super();
		this.id = id;
		this.content = content;
		this.profile = profile;
		this.article = article;
		this.createAt = createAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}
	
	public void deleteArticle() {
		this.article = null;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
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
		Comment other = (Comment) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Comment [id=");
		builder.append(id);
		builder.append(", content=");
		builder.append(content);
		builder.append(", profile=");
		builder.append(profile);
		builder.append(", article=");
		builder.append(article);
		builder.append(", createAt=");
		builder.append(createAt);
		builder.append(", enabled=");
		builder.append(enabled);
		builder.append("]");
		return builder.toString();
	}
	
}
