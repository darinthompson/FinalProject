package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Player;
import com.skilldistillery.esn.repositories.PlayerRepo;

@Service
public class PlayerServiceImpl implements PlayerService {

	@Autowired
	private PlayerRepo repo;
	
	@Override
	public List<Player> index() {
		return repo.findAll();
	}

	@Override
	public List<Player> getPlayersByTeam(Integer tid) {
		return repo.findByTeam_TeamId(tid);
	}

	@Override
	public Player show(Integer pid) {
		Player result = null;
		
		try {
			Optional<Player> opt = repo.findById(pid);
			if (opt.isPresent()) {
				result = opt.get();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
