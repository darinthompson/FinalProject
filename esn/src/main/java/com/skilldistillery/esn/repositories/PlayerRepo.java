package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Player;

public interface PlayerRepo extends JpaRepository<Player, Integer> {

//	List<Player> findByTeam_TeamId(Integer tid);
}
