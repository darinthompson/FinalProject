package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Game;

public interface GameService {

	List<Game> index();
	
	Game show(Integer gid);
}
