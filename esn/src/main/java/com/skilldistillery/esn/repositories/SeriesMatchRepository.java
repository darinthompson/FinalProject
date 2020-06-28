package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.SeriesMatch;

public interface SeriesMatchRepository extends JpaRepository<SeriesMatch, Integer>{
	
	List<SeriesMatch> findByWinner_Game_Id(Integer gid);
}
