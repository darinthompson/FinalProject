package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Profile;

public interface ProfileRepo extends JpaRepository<Profile, Integer> {
	
	Profile findByUser_Username(String username);
}
