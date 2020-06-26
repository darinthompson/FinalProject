package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public List<User> getUsers(Principal principal) {
		return userService.getUsers();
	}
	
	@GetMapping("users/{id}")
	public User getUserById(@PathVariable int id, Principal principal) {
		return userService.getUserByID(id);
	}
	
	@PostMapping("users")
	public User createUser(@RequestBody User user, HttpServletRequest request, HttpServletResponse response, Principal principal) {
		User newUser = null;
		try {
			newUser = userService.create(user);
			response.setStatus(201);
			StringBuffer url = request.getRequestURL();
			url.append("/" + user.getId());
			response.setHeader("Location", url.toString());
		} catch(Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			newUser = null;
		}
		return newUser;
	}
	
	@DeleteMapping("users/{id}")
	public boolean delete(@PathVariable int id, HttpServletRequest request, HttpServletResponse response, Principal principal) {
		if(userService.delete(id)) {
			response.setStatus(204);
			return true;
		} else {
			response.setStatus(400);
			return false;
		}
	}
	
	@PutMapping("users/{id}")
	public User update(@PathVariable int id, @RequestBody User user, HttpServletRequest request, HttpServletResponse response, Principal principal) {
		return userService.update(user, id);
	}
	
}
