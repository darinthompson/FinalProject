package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Team;

public interface TeamRepo extends JpaRepository<Team, Integer> {

	
}
