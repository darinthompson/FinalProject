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
	
}
