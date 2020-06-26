package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Series;
import com.skilldistillery.esn.repositories.SeriesRepo;

@Service
public class SeriesServiceImpl implements SeriesService {

	@Autowired
	private SeriesRepo seriesRepo;

	@Override
	public List<Series> index(String username) {
		return seriesRepo.findAll();

	}

	@Override
	public Series show(String username, int id) {
		Optional<Series> optionalSeries = seriesRepo.findById(id);
		if (optionalSeries.isPresent()) {
			Series series = optionalSeries.get();
			return series;
		}
		return null;
	}

}
