package com.skilldistillery.esn.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Comment;

public interface CommentRepo extends JpaRepository<Comment, Integer> {

}
