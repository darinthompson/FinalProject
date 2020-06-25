package com.skilldistillery.esn.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.services.UserService;

@RestController
@RequestMapping("api")
public class UserController {

	@Autowired
	UserService userService;
	
	@GetMapping("users")
	public List<User> getUsers() {
		return userService.getUsers();
	}
	
	@GetMapping("users/{id}")
	public User getUserById(@PathVariable int id) {
		return userService.getUserByID(id);
	}
	
	
}
