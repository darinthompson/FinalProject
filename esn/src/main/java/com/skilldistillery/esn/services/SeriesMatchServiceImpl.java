package com.skilldistillery.esn.services;

import java.util.List;

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
}
