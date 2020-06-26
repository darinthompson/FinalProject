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

import com.skilldistillery.esn.entities.Organization;
import com.skilldistillery.esn.services.OrganizationService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class OrganizationController {

	@Autowired
	private OrganizationService orgSvc;
	
	@GetMapping("organizations")
	public List<Organization> index(
			HttpServletResponse res,
			Principal principal)
	{
		List<Organization> results;
		try {
			results = orgSvc.index();
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
	
	@GetMapping("{rid}/organizations")
	public List<Organization> getOrgsByRegion(
			@PathVariable Integer rid,
			HttpServletResponse res,
			Principal principal)
	{
		List<Organization> results;
		try {
			results = orgSvc.getOrgsByRegion(rid);
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
	
	@GetMapping("organizations/{oid}")
	public Organization show(
			@PathVariable Integer oid,
			HttpServletResponse res,
			Principal principal)
	{
		Organization result;
		try {
			result = orgSvc.show(oid);
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
