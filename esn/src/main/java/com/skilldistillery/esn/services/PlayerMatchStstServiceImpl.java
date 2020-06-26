package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.PlayerMatchStat;
import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.enums.Role;
import com.skilldistillery.esn.repositories.PlayerMatchStatRepo;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class PlayerMatchStstServiceImpl implements PlayerMatchStatService {

	@Autowired
	private PlayerMatchStatRepo playerMatchStatRepo;

	@Autowired
	private UserRepository userRepo;

	@Override
	public List<PlayerMatchStat> getPlayerStats(String username, int id) {
		return playerMatchStatRepo.findByPlayer_Id(id);

	}

	@Override
	public List<PlayerMatchStat> getPlayerStatsByMatch(String username, int matchId, int playerId) {
		// TODO Auto-generated method stub
		return playerMatchStatRepo.findByPlayer_IdAndMatch_Id(playerId, matchId);
	}

	@Override
	public PlayerMatchStat editPlayerStats(String username, int statId, PlayerMatchStat stat) {
		User loggedInUser = userRepo.findByUsername(username);
		if (loggedInUser.getRole().equals(Role.Admin)) {

			Optional<PlayerMatchStat> optionalStat = playerMatchStatRepo.findById(statId);
			if (optionalStat.isPresent()) {
				PlayerMatchStat singleStat = optionalStat.get();

				singleStat.setValue(stat.getValue());
				return playerMatchStatRepo.saveAndFlush(singleStat);
			}
		}
		return null;
	}

}
