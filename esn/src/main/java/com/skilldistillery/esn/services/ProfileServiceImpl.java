package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Game;
import com.skilldistillery.esn.entities.Organization;
import com.skilldistillery.esn.entities.Player;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.entities.Team;
import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.repositories.ProfileRepo;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class ProfileServiceImpl implements ProfileService {

	@Autowired
	private ProfileRepo profileRepo;
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Profile> index() {
		return profileRepo.findAll();

	}

	@Override
	public Profile show(int id) {
		Optional optionalProfile = profileRepo.findById(id);
		if (optionalProfile.isPresent()) {
			Profile profile = (Profile) optionalProfile.get();
			return profile;
		}
		return null;
	}

	@Override
	public Profile create(int userId, Profile profile) {
		try {
			Optional<User> optionalUser = userRepo.findById(userId);
			User user = null;
			if (optionalUser.isPresent()) {
				user = optionalUser.get();
				profile.setUser(user);
				return profileRepo.saveAndFlush(profile);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	@Override
	public Profile update(String username, Profile profile) {
		Profile managedProfile = profileRepo.findByUser_Username(username);

		if (managedProfile != null) {
			managedProfile.setAvatar(profile.getAvatar());
			managedProfile.setEmail(profile.getEmail());
			managedProfile.setFirstName(profile.getFirstName());
			managedProfile.setLastName(profile.getLastName());

			return profileRepo.saveAndFlush(managedProfile);
		}

		return null;
	}

	@Override
	public Profile addTeam(String username, Team team) {
		Profile profile = profileRepo.findByUser_Username(username);

		if (profile != null) {
			profile.addTeam(team);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile addPlayer(String username, Player player) {
		Profile profile = profileRepo.findByUser_Username(username);

		if (profile != null) {
			profile.addPlayer(player);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile addOrg(String username, Organization organization) {
		Profile profile = profileRepo.findByUser_Username(username);
		
		if(profile != null) {
			profile.addOrganization(organization);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile addGame(String username, Game game) {
		Profile profile = profileRepo.findByUser_Username(username);
		
		if(profile != null) {
			profile.addGame(game);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile removeTeam(String username, Team team) {
		Profile profile = profileRepo.findByUser_Username(username);
		
		if (profile != null) {
			profile.removeTeam(team);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile removePlayer(String username, Player player) {
	Profile profile = profileRepo.findByUser_Username(username);
		
		if (profile != null) {
			profile.removePlayer(player);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile removeOrg(String username, Organization organization) {
	Profile profile = profileRepo.findByUser_Username(username);
		
		if (profile != null) {
			profile.removeOrganization(organization);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

	@Override
	public Profile removeGame(String username, Game game) {
	Profile profile = profileRepo.findByUser_Username(username);
		
		if (profile != null) {
			profile.removeGame(game);
			return profileRepo.saveAndFlush(profile);
		}
		return null;
	}

}
