package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.User;

public interface UserService {
	List<User> getUsers(String username);
	User getUserByID(int id, String username);
	User update(User user, int id, String username);
	boolean disable(int id, String username);
	boolean enable(int id, String username);
}
