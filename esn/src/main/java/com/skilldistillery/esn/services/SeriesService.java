package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Series;

public interface SeriesService {

	public List<Series> index(String username);
	
	public Series show(String username, int id);
}
