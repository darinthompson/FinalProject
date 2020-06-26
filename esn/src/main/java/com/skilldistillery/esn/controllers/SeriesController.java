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
		return seriesService.index(principal.getName());
	}

	@GetMapping("series/{id}")
	public Series show(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int id) {
		return seriesService.show(principal.getName(), id);
	}

}
