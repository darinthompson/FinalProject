package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Series;

public interface SeriesRepo extends JpaRepository<Series, Integer> {

}
