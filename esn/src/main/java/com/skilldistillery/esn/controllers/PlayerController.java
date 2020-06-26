package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Player;
import com.skilldistillery.esn.services.PlayerService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class PlayerController {

	@Autowired
	private PlayerService playerSvc;
	
	@GetMapping("players")
	public List<Player> index(
			HttpServletResponse res,
			Principal principal)
	{
		List<Player> results;
		try {
			results = playerSvc.index();
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
	
	@GetMapping("players/team/{tid}")
	public List<Player> getPlayersByTeam(
			@PathVariable Integer tid,
			HttpServletResponse res,
			Principal principal)
	{
		List<Player> results;
		try {
			results = playerSvc.getPlayersByTeam(tid);
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
	
	@GetMapping("players/{pid}")
	public Player show(
			@PathVariable Integer pid,
			HttpServletResponse res,
			Principal principal)
	{
		Player result;
		try {
			result =  playerSvc.show(pid);
			if (result != null) {
				res.setStatus(200);				
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			result = null;
		}
		
		return result;
	}
}
