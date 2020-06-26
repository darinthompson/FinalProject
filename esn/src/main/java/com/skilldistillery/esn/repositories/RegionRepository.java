package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Region;

public interface RegionRepository extends JpaRepository<Region, Integer> {

}
