package com.skilldistillery.esn.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Region;
import com.skilldistillery.esn.repositories.RegionRepository;

@Service
public class RegionServiceImpl implements RegionService {

	@Autowired
	RegionRepository regionRepo;
	
	@Override
	public List<Region> getAllRegions() {
		return regionRepo.findAll();
	}

}
