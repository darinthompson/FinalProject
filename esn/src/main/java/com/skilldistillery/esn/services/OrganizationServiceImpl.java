package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Organization;
import com.skilldistillery.esn.repositories.OrganizationRepo;

@Service
public class OrganizationServiceImpl implements OrganizationService {
	
	@Autowired
	private OrganizationRepo repo;

	@Override
	public List<Organization> index() {
		return repo.findAll();
	}

	@Override
	public List<Organization> getOrgsByRegion(Integer rid) {
		return repo.findByRegion_Id(rid);
	}

	@Override
	public Organization show(Integer oid) {
		Organization org = null;
		
		try {
			Optional<Organization> opt = repo.findById(oid);
			if (opt.isPresent()) {
				org = opt.get();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return org;
	}

}
