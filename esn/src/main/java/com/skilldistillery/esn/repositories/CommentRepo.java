package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Comment;

public interface CommentRepo extends JpaRepository<Comment, Integer> {

	List<Comment> findByProfile_Id(Integer pid);
	
	List<Comment> findByArticle_Id(Integer aid);
}
