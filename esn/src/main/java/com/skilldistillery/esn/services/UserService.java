package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.User;

public interface UserService {
	List<User> getUsers();
	User getUserByID(int id);
}
