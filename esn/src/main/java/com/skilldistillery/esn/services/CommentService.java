package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Comment;

public interface CommentService {

	List<Comment> index();
	
	Comment show(Integer cid);
	
	List<Comment> getAllProfileComments(String username);
	
	List<Comment> getAllArticleComments(Integer aid);
	
	Comment create(Integer aid, Comment newComment, String username);
	
	boolean enable(Integer cid, String username);
	
	boolean disable(Integer cid, String username);
}
