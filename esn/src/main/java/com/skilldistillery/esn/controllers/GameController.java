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

import com.skilldistillery.esn.entities.Game;
import com.skilldistillery.esn.services.GameService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class GameController {

	@Autowired
	private GameService gameSvc;
	
	@GetMapping("games")
	public List<Game> index(
			HttpServletResponse res,
			Principal principal)
	{
		List<Game> results;
		try {
			results = gameSvc.index();
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
	
	@GetMapping("games/{gid}")
	public Game show(
			@PathVariable Integer gid,
			HttpServletResponse res,
			Principal principal)
	{
		Game result;
		try {
			result = gameSvc.show(gid);
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
