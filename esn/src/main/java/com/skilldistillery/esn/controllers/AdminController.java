package com.skilldistillery.esn.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.services.ProfileService;
import com.skilldistillery.esn.services.UserService;

@RestController
@RequestMapping("api/admin")
@CrossOrigin({"*", "http:localhost:4209"})
public class AdminController {

	@Autowired
	private UserService userSvc;
	
	@Autowired
	private ProfileService profileSvc;
	
//	@Autowired
//	private PlayerMatchStatService pmsSvc;
	
	
}
