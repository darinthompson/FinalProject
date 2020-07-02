package com.skilldistillery.esn.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.SeriesMatch;
import com.skilldistillery.esn.entities.Team;
import com.skilldistillery.esn.repositories.SeriesMatchRepository;
import com.skilldistillery.esn.repositories.TeamRepo;

@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private TeamRepo repo;
	
	@Autowired
	private SeriesMatchRepository matchRepo;

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

	@Override
	public List<SeriesMatch> getMatchesByTeamId(int id) {
		List<SeriesMatch> fiveMatchResult = new ArrayList<>();
		List<SeriesMatch> allMatches = matchRepo.findByTeam1IdOrTeam2IdOrderByStartDateDesc(id, id);
		for(int i=0; i < 5 && i < allMatches.size(); i++) {
			if(allMatches.get(i) != null) {
				fiveMatchResult.add(allMatches.get(i));
			}else {
				break;
			}
		}
		return fiveMatchResult;
	}

	@Override
	public List<SeriesMatch> getMatchesByFavTeams(Team[] teams) {		
		List<SeriesMatch> results = new ArrayList<>();
		for (Team team : teams) {
			List<SeriesMatch> temp = matchRepo.findByTeam1IdOrTeam2IdOrderByStartDateDesc(team.getId(), team.getId());
			results.addAll(temp);
		}
		return results;
	}

}
