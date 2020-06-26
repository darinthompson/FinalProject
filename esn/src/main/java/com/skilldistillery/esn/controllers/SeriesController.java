package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Series;
import com.skilldistillery.esn.services.SeriesService;

@RestController
@RequestMapping("api")
public class SeriesController {

	@Autowired
	private SeriesService seriesService;

	@GetMapping("series")
	public List<Series> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Series> results;
		try {
			results = seriesService.index(principal.getName());
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

	@GetMapping("series/{id}")
	public Series show(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int id) {
		Series result;
		try {
			result = seriesService.show(principal.getName(), id);
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

}
