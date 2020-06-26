package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Game;

public interface GameRepo extends JpaRepository<Game, Integer> {

}
