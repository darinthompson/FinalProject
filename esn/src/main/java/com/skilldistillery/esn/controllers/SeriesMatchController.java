package com.skilldistillery.esn.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.SeriesMatch;
import com.skilldistillery.esn.services.SeriesMatchService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class SeriesMatchController {

	@Autowired
	SeriesMatchService seriesMatchService;

	@GetMapping("matches")
	public List<SeriesMatch> getAllMatches(HttpServletResponse response) {
		List<SeriesMatch> matches = null;
		try {
			matches = seriesMatchService.getAllMatches();
			if (matches.size() > 0) {
				response.setStatus(200);
			} else {
				response.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
		}
		return matches;
	}

	@GetMapping("matches/{id}")
	public SeriesMatch getMatchById(
			@PathVariable Integer id,
			HttpServletResponse response)
	{
		SeriesMatch match = null;
		try {
			match = seriesMatchService.getMatchById(id);
			if (match != null) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
		}
		return match;
	}
	
	@GetMapping("matches/game/{gid}")
	public List<SeriesMatch> getMatchesByGameId(
			@PathVariable Integer gid,
			HttpServletResponse res)
	{
		List<SeriesMatch> results;
		try {
			results = seriesMatchService.getAllByGameId(gid);
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		
		return results;
	}
}
