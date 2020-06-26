package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Player;

public interface PlayerService {

	List<Player> index();
	
//	List<Player> getPlayersByTeam(Integer tid);
	
	Player show(Integer pid);
}
