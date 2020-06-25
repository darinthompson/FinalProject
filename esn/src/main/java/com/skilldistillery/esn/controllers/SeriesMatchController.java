package com.skilldistillery.esn.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.SeriesMatch;
import com.skilldistillery.esn.services.SeriesMatchService;

@RestController
@RequestMapping("api")
public class SeriesMatchController {
	
	@Autowired
	SeriesMatchService seriesMatchService;
	
	@GetMapping("matches")
	public List<SeriesMatch> getAllMatches() {
		return seriesMatchService.getAllMatches();
	}
}
