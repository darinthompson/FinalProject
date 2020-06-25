package com.skilldistillery.esn.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.services.ProfileService;

@RestController
@RequestMapping("api")
public class ProfileController {

	@Autowired
	private ProfileService profileService;
	
	@GetMapping("profiles")
	public List<Profile> index(HttpServletRequest req, HttpServletResponse res){
		return profileService.index();
	}
	
	@GetMapping("profiles/{id}")
	public Profile getById(HttpServletRequest req, HttpServletResponse res, @PathVariable int id) {
		return profileService.show(id);
	}
}
