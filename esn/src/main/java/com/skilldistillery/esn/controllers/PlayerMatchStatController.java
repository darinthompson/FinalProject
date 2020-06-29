package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.PlayerMatchStat;
import com.skilldistillery.esn.services.PlayerMatchStatService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class PlayerMatchStatController {

	@Autowired
	private PlayerMatchStatService playerMatchStatService;

	@GetMapping("stats/player/{id}")
	public List<PlayerMatchStat> getPlayerStats(HttpServletRequest req, HttpServletResponse res, @PathVariable int id,
			Principal principal) {
		List<PlayerMatchStat> results;
		try {
			results = playerMatchStatService.getPlayerStats(principal.getName(), id);
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		return results;
	}

	@GetMapping("stats/match/{matchId}/player/{playerId}")
	public List<PlayerMatchStat> getPlayerStatByMatch(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int matchId, @PathVariable int playerId, Principal principal) {
		List<PlayerMatchStat> results;
		try {
			results = playerMatchStatService.getPlayerStatsByMatch(principal.getName(), matchId, playerId);
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		return results;
	}

	@PutMapping("stats/{id}")
	public PlayerMatchStat editPlayerStats(HttpServletRequest req, HttpServletResponse res, @PathVariable int id,
			Principal principal, @RequestBody PlayerMatchStat stat) {
		PlayerMatchStat result;
		try {
			result = playerMatchStatService.editPlayerStats(principal.getName(), id, stat);
			if (result != null) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			result = null;
		}
		return result;
	}
	
	@GetMapping("stats/match/{matchId}")
	public List<PlayerMatchStat> getMatchStats(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int matchId, Principal principal) {
		List<PlayerMatchStat> results;
		try {
			results = playerMatchStatService.statsForMatch(matchId);
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		return results;
	}
}
