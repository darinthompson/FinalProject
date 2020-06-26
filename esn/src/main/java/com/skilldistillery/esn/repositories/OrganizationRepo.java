package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Organization;

public interface OrganizationRepo extends JpaRepository<Organization, Integer> {

	List<Organization> findByRegion_Id(Integer rid);
}
