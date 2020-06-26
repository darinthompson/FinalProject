package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.PlayerMatchStat;

public interface PlayerMatchStatRepo extends JpaRepository<PlayerMatchStat, Integer> {

	List<PlayerMatchStat> findByPlayer_Id(int id);
	
	List<PlayerMatchStat> findByPlayer_IdAndMatch_Id(int playerId, int matchId);
	
	PlayerMatchStat findByPlayer_IdAndMatch_IdAndStat_Id(int playerId, int matchId, int statId);
}
