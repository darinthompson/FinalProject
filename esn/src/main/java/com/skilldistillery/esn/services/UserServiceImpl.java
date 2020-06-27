package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.enums.Role;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserRepository userRepo;

	@Override
	public List<User> getUsers(String username) {
		User loggedInUser = userRepo.findByUsername(username);
		if (loggedInUser.getRole().equals(Role.Admin)) {
			return userRepo.findAll();
		} else {
			return null;
		}
	}

	@Override
	public User getUserByID(int id, String username) {
		User result = null;
		
		if (userRepo.findByUsername(username) != null) {
			Optional<User> optUser = userRepo.findById(id);
			if (optUser.isPresent()) {
				result = optUser.get();
			}
		}
		
		return result;			
	}

	@Override
	public User update(User user, int id, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Optional<User> optUser = userRepo.findById(id);
		if (optUser.isPresent()) {
			User updateUser = optUser.get();
			if (updateUser.equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
				updateUser.setUsername(user.getUsername());
				if (loggedInUser.getRole().equals(Role.Admin) && user.getRole() != null) {
					updateUser.setRole(user.getRole());
				}
				updateUser.setPassword(user.getPassword());
				return userRepo.saveAndFlush(updateUser);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
	
	@Override
	public boolean disable(int id, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Optional<User> optUser = userRepo.findById(id);
		if (optUser.isPresent()) {
			User toDisable = optUser.get();
			if (toDisable.equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
				toDisable.setEnabled(false);
				userRepo.saveAndFlush(toDisable);
				return true;
			} else {
				return false;
			}	
		} else {
			return false;
		}
	}

	@Override
	public boolean enable(int id, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Optional<User> optUser = userRepo.findById(id);
		if (optUser.isPresent()) {
			User toEnable = optUser.get();
			if (toEnable.equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
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
