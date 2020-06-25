package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.SeriesMatch;

public interface SeriesMatchRepository extends JpaRepository<SeriesMatch, Integer>{
	
}
