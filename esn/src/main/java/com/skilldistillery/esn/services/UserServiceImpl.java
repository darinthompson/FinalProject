package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserRepository userRepo;
	
	@Override
	public List<User> getUsers(String username) {
		if (username.equals("admin")) {
			return userRepo.findAll();			
		} else {
			return null;
		}
	}
	
	@Override
	public User getUserByID(int id, String username) {
		if (username.equals("admin")) {
			Optional<User> optUser = userRepo.findById(id);
			User userActual = null;
			if(optUser.isPresent()) {
				userActual = optUser.get();
			}
			return userActual;			
		} else {
			return null;
		}
	}

	@Override
	public User create(User user, String username) {
		user.setEnabled(true);
		User newUser = userRepo.save(user);
		return newUser;
	}
	
	@Override
	public User update(User user, int id, String username) {
		if (username.equals("admin")) {
			Optional<User> optUser = userRepo.findById(id);
			User updateUser = null;
			if(optUser.isPresent()) {
				updateUser = optUser.get();
				updateUser.setUsername(user.getUsername());
				updateUser.setEnabled(user.isEnabled());
				updateUser.setRole(user.getRole());
				updateUser.setPassword(user.getPassword());
				userRepo.saveAndFlush(updateUser);
				return updateUser;
			} else {
				return null;
			}
		}
		else {
			User updateUser = userRepo.findByUsername(username);
			if (updateUser != null) {
				updateUser.setUsername(user.getUsername());
				updateUser.setEnabled(user.isEnabled());
				updateUser.setRole(user.getRole());
				updateUser.setPassword(user.getPassword());
				userRepo.saveAndFlush(updateUser);
				return updateUser;
			} else {
				return null;
			}
		}
	}
	
	@Override
	public boolean disable(int id, String username) {
		if (username.equals("admin")) {
			Optional<User> optUser = userRepo.findById(id);
			if(optUser.isPresent()) {
				User toDisable = optUser.get();
				toDisable.setEnabled(false);
				userRepo.saveAndFlush(toDisable);
				return true;
			} else {
				return false;
			}
		}
		else {
			User toDisable = userRepo.findByUsername(username);
			if (toDisable != null) {
				toDisable.setEnabled(false);
				userRepo.saveAndFlush(toDisable);
				return true;				
			} else {
				return false;
			}
		}
	}

	@Override
	public boolean enable(int id, String username) {
		if (username.equals("admin")) {
			Optional<User> optUser = userRepo.findById(id);
			if(optUser.isPresent()) {
				User toEnable = optUser.get();
				toEnable.setEnabled(true);
				userRepo.saveAndFlush(toEnable);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
}
