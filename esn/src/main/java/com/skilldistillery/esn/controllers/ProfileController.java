package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@CrossOrigin({"*", "http:localhost:4209"})
public class ProfileController {

	@Autowired
	private ProfileService profileService;

	@GetMapping("profiles")
	public List<Profile> index(
			HttpServletRequest req,
			HttpServletResponse res,
			Principal principal)
	{
		List<Profile> results;
		try {
			results = profileService.index(principal.getName());
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		return results;
	}

	@GetMapping("profiles/{pid}")
	public Profile getById(
			HttpServletRequest req,
			HttpServletResponse res,
			Principal principal)
	{
		Profile result;
		try {
			result = profileService.show(principal.getName());
			if (result != null) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			result = null;
		}
		return result;
	}
	
	@PostMapping("profiles")
	public Profile create(
			@RequestBody Profile profile,
			HttpServletResponse res,
			HttpServletRequest req,
			Principal principal)
	{
		try {
			profile = profileService.create(profile, principal.getName());
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(profile.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		
		return profile;
	}

	@PutMapping("profiles/{pid}")
	public Profile updateProfile(
			HttpServletResponse res,
			@RequestBody Profile profile,
			Principal principal)
	{
		try {
			profile = profileService.update(principal.getName(), profile);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}

		return profile;
	}

	@PutMapping("profiles/addTeam")
	public Profile addTeam(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Team team,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.addTeam(principal.getName(), team);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/addGame")
	public Profile addGame(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Game game,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.addGame(principal.getName(), game);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/addOrg")
	public Profile addOrg(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Organization organization,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.addOrg(principal.getName(), organization);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/addPlayer")
	public Profile addPlayer(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Player player,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.addPlayer(principal.getName(), player);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/removeTeam")
	public Profile removeTeam(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Team team,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.removeTeam(principal.getName(), team);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/removeGame")
	public Profile removeGame(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Game game,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.removeGame(principal.getName(), game);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/removeOrg")
	public Profile removeOrg(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Organization org,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.removeOrg(principal.getName(), org);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}

	@PutMapping("profiles/removePlayer")
	public Profile removePlayer(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestBody Player player,
			Principal principal)
	{
		Profile profile;
		try {
			profile = profileService.removePlayer(principal.getName(), player);
			if (profile == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			profile = null;
		}
		return profile;
	}
}
