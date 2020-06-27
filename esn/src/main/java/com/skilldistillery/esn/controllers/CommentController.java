package com.skilldistillery.esn.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.esn.entities.Comment;
import com.skilldistillery.esn.services.CommentService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class CommentController {

	@Autowired
	private CommentService comSvc;
	
	@GetMapping("comments")
	public List<Comment>index(HttpServletResponse res) {
		List<Comment> results;
		try {
			results = comSvc.index();
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		
		return results;
	}
	
	@GetMapping("comments/{cid}")
	public Comment show(
			@PathVariable Integer cid,
			HttpServletResponse res)
	{
		Comment result;
		try {
			result = comSvc.show(cid);
			if (result != null) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			result = null;
		}
		
		return result;
	}
	
	@GetMapping("comments/profile")
	public List<Comment> allProfileComments(
			HttpServletResponse res,
			Principal principal)
	{
		List<Comment> results;
		try {
			results = comSvc.getAllProfileComments(principal.getName());
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		
		return results;
	}
	
	@GetMapping("comments/article/{aid}")
	public List<Comment> allArticleComments(
			@PathVariable Integer aid,
			HttpServletResponse res)
	{
		List<Comment> results;
		try {
			results = comSvc.getAllArticleComments(aid);
			if (results.size() > 0) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			results = null;
		}
		
		return results;
	}
	
	@PostMapping("comments/{aid}")
	public Comment create(
			@PathVariable Integer aid,
			@RequestBody Comment comment,
			HttpServletRequest req,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			comment = comSvc.create(aid, comment, principal.getName());
			if (comment == null) {
				res.setStatus(401);
			} else {
				res.setStatus(201);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(comment.getId());
				res.setHeader("Location", url.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			comment = null;
		}
		
		return comment;
	}
	
	@PutMapping("comments/enable/{cid}")
	public boolean enable(
			@PathVariable Integer cid,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			if (comSvc.enable(cid, principal.getName())) {
				res.setStatus(200);
				return true;
			} else {
				res.setStatus(404);
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return false;
		}
	}
	
	@DeleteMapping("comments/disable/{cid}")
	public boolean disable(
			@PathVariable Integer cid,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			if (comSvc.disable(cid, principal.getName())) {
				res.setStatus(204);
				return true;
			} else {
				res.setStatus(404);
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return false;
		}
	}
}
