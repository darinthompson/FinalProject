package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Game;
import com.skilldistillery.esn.entities.Organization;
import com.skilldistillery.esn.entities.Player;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.entities.Team;
import com.skilldistillery.esn.services.ProfileService;

@RestController
@RequestMapping("api")
public class ProfileController {

	@Autowired
	private ProfileService profileService;

	@GetMapping("profiles")
	public List<Profile> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return profileService.index(principal.getName());
	}

	@GetMapping("profiles/{pid}")
	public Profile getById(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		return profileService.show(principal.getName());
	}

	@PutMapping("profiles/{pid}")
	public Profile updateProfile(HttpServletRequest req, HttpServletResponse res, @RequestBody Profile profile,
			Principal principal) {
		return profileService.update(principal.getName(), profile);
	}

	@PutMapping("profiles/{id}/addTeam")
	public Profile addTeam(HttpServletRequest req, HttpServletResponse res, @RequestBody Team team,
			Principal principal) {
		return profileService.addTeam(principal.getName(), team);
	}

	@PutMapping("profiles/{id}/addGame")
	public Profile addGame(HttpServletRequest req, HttpServletResponse res, @RequestBody Game game,
			Principal principal) {
		return profileService.addGame(principal.getName(), game);
	}

	@PutMapping("profiles/{id}/addOrg")
	public Profile addOrg(HttpServletRequest req, HttpServletResponse res, @RequestBody Organization organization,
			Principal principal) {
		return profileService.addOrg(principal.getName(), organization);
	}

	@PutMapping("profiles/{id}/addPlayer")
	public Profile addPlayer(HttpServletRequest req, HttpServletResponse res, @RequestBody Player player,
			Principal principal) {
		return profileService.addPlayer(principal.getName(), player);
	}

	@PutMapping("profiles/{id}/removeTeam")
	public Profile removeTeam(HttpServletRequest req, HttpServletResponse res, @RequestBody Team team,
			Principal principal) {
		return profileService.removeTeam(principal.getName(), team);
	}

	@PutMapping("profiles/{id}/removeGame")
	public Profile removeGame(HttpServletRequest req, HttpServletResponse res, @RequestBody Game game,
			Principal principal) {
		return profileService.removeGame(principal.getName(), game);
	}

	@PutMapping("profiles/{id}/removeOrg")
	public Profile removeOrg(HttpServletRequest req, HttpServletResponse res, @RequestBody Organization organization,
			Principal principal) {
		return profileService.removeOrg(principal.getName(), organization);
	}

	@PutMapping("profiles/{id}/removePlayer")
	public Profile removePlayer(HttpServletRequest req, HttpServletResponse res, @RequestBody Player player,
			Principal principal) {
		return profileService.removePlayer(principal.getName(), player);
	}
}
