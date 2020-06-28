package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Game;
import com.skilldistillery.esn.repositories.GameRepo;

@Service
public class GameServiceImpl implements GameService {

	@Autowired
	private GameRepo repo;

	@Override
	public List<Game> index() {
		return repo.findAll();
	}

	@Override
	public Game show(Integer gid) {
		Game result = null;

		try {
			Optional<Game> opt = repo.findById(gid);
			if (opt.isPresent()) {
				result = opt.get();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
}