package com.skilldistillery.esn.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Article {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String title;
	private String content;
	
	@Column(name="img_url")
	private String image;
	
	@CreationTimestamp
	@Column(name="create_date")
	private LocalDateTime createDate;

	@JsonIgnoreProperties({"user", "articles"})
	@ManyToOne
	@JoinColumn(name = "profile_id")
	private Profile author;
	private boolean enabled;

	@JsonIgnoreProperties("article")
	@OneToMany(mappedBy = "article")
	private List<Comment> comments;
	
	@ManyToOne
	@JoinColumn(name = "game_id")
	private Game game;
	
	public Article() {
		super();
	}

	public Article(int id, String title, String content, String image, LocalDateTime createDate, Profile author,
			boolean enabled, List<Comment> comments, Game game) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.image = image;
		this.createDate = createDate;
		this.author = author;
		this.enabled = enabled;
		this.comments = comments;
		this.game = game;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public Profile getAuthor() {
		return author;
	}

	public void setAuthor(Profile author) {
		this.author = author;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	
	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public void addComment(Comment comment) {
		if(comments == null) {
			comments = new ArrayList<>();
		}
		
		if(!comments.contains(comment)) {
			comments.add(comment);
		}
	}
	
	public void deleteComment(Comment comment) {
		if(comment != null &&  comments.contains(comment)) {
			comments.remove(comment);
			comment.deleteArticle();
		}
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
		Article other = (Article) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Article [id=");
		builder.append(id);
		builder.append(", title=");
		builder.append(title);
		builder.append(", content=");
		builder.append(content);
		builder.append(", image=");
		builder.append(image);
		builder.append(", createDate=");
		builder.append(createDate);
		builder.append(", author=");
		builder.append(author);
		builder.append(", enabled=");
		builder.append(enabled);
		builder.append("]");
		return builder.toString();
	}
	
}
