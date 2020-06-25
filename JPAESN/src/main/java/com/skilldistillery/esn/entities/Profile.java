package com.skilldistillery.esn.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Profile {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	private String email;
	
	@Column(name="avatar_url")
	private String avatar;
	
	@JsonManagedReference
	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@OneToMany(mappedBy = "author")
	private List<Article> articles;
	
	@OneToMany(mappedBy = "profile")
	private List<Comment> comments;
	
	@OneToMany
	@JoinColumn(name = "id")
	private List<Organization> favoriteOrganizations;
	
	@OneToMany
	@JoinColumn(name = "id")
	private List<Team> favoriteTeams;
	
	@OneToMany
	@JoinColumn(name = "id")
	private List<Player> favoritePlayers;
	
	@OneToMany
	@JoinColumn(name = "id")
	private List<Game> favoriteGames;
	
	public Profile() {
		
	}

	public Profile(int id, String firstName, String lastName, String email, String avatar, User user,
			List<Article> articles, List<Comment> comments, List<Organization> favoriteOrganizations,
			List<Team> favoriteTeams, List<Player> favoritePlayers, List<Game> favoriteGames) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.avatar = avatar;
		this.user = user;
		this.articles = articles;
		this.comments = comments;
		this.favoriteOrganizations = favoriteOrganizations;
		this.favoriteTeams = favoriteTeams;
		this.favoritePlayers = favoritePlayers;
		this.favoriteGames = favoriteGames;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Organization> getFavoriteOrganizations() {
		return favoriteOrganizations;
	}

	public void setFavoriteOrganizations(List<Organization> favoriteOrganizations) {
		this.favoriteOrganizations = favoriteOrganizations;
	}

	public List<Team> getFavoriteTeams() {
		return favoriteTeams;
	}

	public void setFavoriteTeams(List<Team> favoriteTeams) {
		this.favoriteTeams = favoriteTeams;
	}

	public List<Player> getFavoritePlayers() {
		return favoritePlayers;
	}

	public void setFavoritePlayers(List<Player> favoritePlayers) {
		this.favoritePlayers = favoritePlayers;
	}

	public List<Game> getFavoriteGames() {
		return favoriteGames;
	}

	public void setFavoriteGames(List<Game> favoriteGames) {
		this.favoriteGames = favoriteGames;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((avatar == null) ? 0 : avatar.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((firstName == null) ? 0 : firstName.hashCode());
		result = prime * result + id;
		result = prime * result + ((lastName == null) ? 0 : lastName.hashCode());
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
		Profile other = (Profile) obj;
		if (avatar == null) {
			if (other.avatar != null)
				return false;
		} else if (!avatar.equals(other.avatar))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (firstName == null) {
			if (other.firstName != null)
				return false;
		} else if (!firstName.equals(other.firstName))
			return false;
		if (id != other.id)
			return false;
		if (lastName == null) {
			if (other.lastName != null)
				return false;
		} else if (!lastName.equals(other.lastName))
			return false;
		return true;
	}

	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Profile [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", email=");
		builder.append(email);
		builder.append(", avatar=");
		builder.append(avatar);
		builder.append(", user=");
		builder.append(user);
		builder.append("]");
		return builder.toString();
	}

}
