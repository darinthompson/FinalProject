package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Team;

public interface TeamService {

	List<Team> index();
	
	List<Team> getTeamsByOrg(Integer oid);
	
	List<Team> getTeamsByRegion(Integer rid);
	
	Team show(Integer tid);
}
