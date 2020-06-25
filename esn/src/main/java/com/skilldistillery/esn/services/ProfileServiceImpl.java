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
		if(optionalProfile.isPresent()) {
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
	public Profile update(int profileId, Profile profile) {
		Optional<Profile> optionalProfile = profileRepo.findById(profileId);
		if(optionalProfile.isPresent()) {
			Profile managedProfile = optionalProfile.get();
			if(managedProfile != null) {
				managedProfile.setAvatar(profile.getAvatar());
				managedProfile.setEmail(profile.getEmail());
				managedProfile.setFirstName(profile.getFirstName());
				managedProfile.setLastName(profile.getLastName());
				
				return profileRepo.saveAndFlush(managedProfile);
			}
		}
		return null;
	}

	@Override
	public List<Team> addTeam(int profileId, Team team) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Player> addPlayer(int profileId, Player player) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Organization> addOrg(int profileId, Organization organization) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Game> addGame(int profileId, Game game) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Team> removeTeam(int profileId, Team team) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Player> removePlayer(int profileId, Player player) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Organization> removeOrg(int profileId, Organization organization) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Game> removeGame(int profileId, Game game) {
		// TODO Auto-generated method stub
		return null;
	}

}
