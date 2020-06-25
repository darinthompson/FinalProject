package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}
