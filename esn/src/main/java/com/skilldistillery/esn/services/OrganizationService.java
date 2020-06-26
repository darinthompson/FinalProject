package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Organization;

public interface OrganizationService {

	List<Organization> index();
	
	List<Organization> getOrgsByRegion(Integer rid);
	
	Organization show(Integer oid);
}
