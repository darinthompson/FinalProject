package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.PlayerMatchStat;

public interface PlayerMatchStatService {
	
	public List<PlayerMatchStat> getPlayerStats(String username, int id);
	
	public List<PlayerMatchStat> getPlayerStatsByMatch(String username, int matchId, int playerId);
	
	public PlayerMatchStat editPlayerStats(String username, int statId, PlayerMatchStat stat);

}
