package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public List<SeriesMatch> getAllMatches(HttpServletRequest request, HttpServletResponse response,
			Principal principal) {
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
	public SeriesMatch getMatchById(@PathVariable int id, HttpServletResponse response, Principal principal) {
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
}
