package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Team;
import com.skilldistillery.esn.repositories.TeamRepo;

@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private TeamRepo repo;

	@Override
	public List<Team> index() {
		return repo.findAll();
	}

	@Override
	public List<Team> getTeamsByOrg(Integer oid) {
		return repo.findByOrganization_Id(oid);
	}

	@Override
	public List<Team> getTeamsByRegion(Integer rid) {
		return repo.findByOrganization_Region_Id(rid);
	}

	@Override
	public Team show(Integer tid) {
		Team result = null;
		Optional<Team> opt = repo.findById(tid);
		if (opt.isPresent()) {
			result = opt.get();
		}
		return result;
	}

}
