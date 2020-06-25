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
	public List<User> getUsers() {
		return userRepo.findAll();
	}
	
	@Override
	public User getUserByID(int id) {
		Optional<User> optUser = userRepo.findById(id);
		User userActual = null;
		if(optUser.isPresent()) {
			userActual = optUser.get();
		}
		return userActual;
	}

	@Override
	public User create(User user) {
		User newUser = userRepo.save(user);
		return newUser;
	}
	
	@Override
	public boolean delete(int id) {
		Optional<User> optUser = userRepo.findById(id);
		if(optUser.isPresent()) {
			userRepo.delete(optUser.get());
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public User update(User user, int id) {
		Optional<User> optUser = userRepo.findById(id);
		User updateUser = null;
		if(optUser.isPresent()) {
			updateUser = optUser.get();
			updateUser.setUserName(user.getUserName());
			updateUser.setEnabled(user.isEnabled());
			updateUser.setRole(user.getRole());
			updateUser.setPassword(user.getPassword());
			userRepo.saveAndFlush(updateUser);
		}
		return updateUser;
	}
	
}
