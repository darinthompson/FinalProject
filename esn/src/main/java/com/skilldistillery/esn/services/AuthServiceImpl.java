package com.skilldistillery.esn.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.enums.Role;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {
//	https://github.com/SkillDistillery/SD26/blob/master/angular/authentication/encryption.md
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private UserRepository userRepo;

	@Override
	public User register(User user) {
		String encodedPW = encoder.encode(user.getPassword());
		user.setPassword(encodedPW); // only persist encoded password
		// set other fields to default values
		user.setEnabled(true);
		user.setRole(Role.User);
		userRepo.saveAndFlush(user);
		return user;
	}
}