package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Team;

public interface TeamRepo extends JpaRepository<Team, Integer> {

	List<Team> findByOrganization_Id(Integer oid);
	
	List<Team> findByOrganization_Region_Id(Integer rid);
}
