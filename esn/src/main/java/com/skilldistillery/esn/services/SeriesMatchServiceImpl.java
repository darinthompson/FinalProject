package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.SeriesMatch;
import com.skilldistillery.esn.repositories.SeriesMatchRepository;

@Service
public class SeriesMatchServiceImpl implements SeriesMatchService {
	
	@Autowired
	SeriesMatchRepository seriesMatchRepo;

	@Override
	public List<SeriesMatch> getAllMatches() {
		return seriesMatchRepo.findAll();
	}

	@Override
	public SeriesMatch getMatchById(Integer id) {
		Optional<SeriesMatch> optMatch = seriesMatchRepo.findById(id);
		if(optMatch.isPresent()) {
			SeriesMatch match = optMatch.get();
			return match;
		} else {
			return null;
		}
	}

	@Override
	public List<SeriesMatch> getAllByGameId(Integer gid) {
		return seriesMatchRepo.findByWinner_Game_Id(gid);
	}
	
}
