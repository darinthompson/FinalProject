package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	public List<User> getUsers(
			HttpServletResponse res,
			Principal principal)
	{
		List<User> results;
		try {
			results = userService.getUsers(principal.getName());
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		
		return results;
	}
	
	@GetMapping("users/{id}")
	public User getUserById(
			@PathVariable int id,
			HttpServletResponse res,
			Principal principal)
	{
		User result;
		try {
			result = userService.getUserByID(id, principal.getName());
			if (result != null) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			result = null;
		}
		
		return result;
	}
	
	@PutMapping("users/{id}")
	public User update(
			@PathVariable int id,
			@RequestBody User user,
			HttpServletResponse res,
			Principal principal)
	{
		User updated;
		try {
			updated = userService.update(user, id, principal.getName());
			if (updated != null) {
				res.setStatus(200);				
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			updated = null;
		}
		
		return updated;
	}
	
	@DeleteMapping("users/{id}")
	public boolean disable(
			@PathVariable int id,
			HttpServletRequest request,
			HttpServletResponse response,
			Principal principal)
	{
		try {
			if(userService.disable(id, principal.getName())) {
				response.setStatus(204);
				return true;
			} else {
				response.setStatus(404);
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return false;
		}
	}
		
}
