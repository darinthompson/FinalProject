package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Region;
import com.skilldistillery.esn.services.RegionService;

@RestController
@RequestMapping("api")
public class RegionController {
	
	@Autowired
	RegionService regionService;
	
	@GetMapping("regions")
	public List<Region> getAllRegions(Principal principal, HttpServletResponse response) {
		List<Region> regions = null;
		try {
			regions = regionService.getAllRegions();
			if(regions != null) {
				response.setStatus(200);
			} else {
				response.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
		}
		return regions;
	}
}
