package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Game;
import com.skilldistillery.esn.entities.Organization;
import com.skilldistillery.esn.entities.Player;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.entities.Team;

public interface ProfileService {

	public List<Profile> index();

	public Profile show(int id);

	public Profile create(int userId, Profile profile);

	public Profile update(int profileId, Profile profile);

	public List<Team> addTeam(int profileId, Team team);

	public List<Player> addPlayer(int profileId, Player player);

	public List<Organization> addOrg(int profileId, Organization organization);

	public List<Game> addGame(int profileId, Game game);

	public List<Team> removeTeam(int profileId, Team team);

	public List<Player> removePlayer(int profileId, Player player);

	public List<Organization> removeOrg(int profileId, Organization organization);

	public List<Game> removeGame(int profileId, Game game);
}
