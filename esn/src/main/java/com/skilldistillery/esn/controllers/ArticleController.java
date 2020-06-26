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

import com.skilldistillery.esn.entities.Article;
import com.skilldistillery.esn.services.ArticleService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http:localhost:4209"})
public class ArticleController {

	@Autowired
	private ArticleService articleSvc;
	
	@GetMapping("articles")
	public List<Article> index(
			HttpServletResponse res)
	{
		List<Article> results;
		try {
			results = articleSvc.getAllEnabledArticles();
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
	
	@GetMapping("articles/author")
	public List<Article> getAllAuthorArticlesEnabled(
			HttpServletResponse res,
			Principal principal)
	{
		System.out.println("----------"+principal.getName()+"----------");
		List<Article> results;
		try {
			results = articleSvc.getAllAuthorEnabledArticles(principal.getName());
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
	
	@GetMapping("articles/{aid}")
	public Article getById(
			@PathVariable Integer aid,
			HttpServletResponse res,
			Principal principal
			)
	{
		Article result;
		try {
			result = articleSvc.show(aid);
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
	
	@PostMapping("articles")
	public Article create(
			@RequestBody Article article,
			HttpServletRequest req,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			article = articleSvc.create(article, principal.getName());
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(article.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			article = null;
		}
		
		return article;
	}
	
	@PutMapping("articles/{aid}")
	public Article update(
			@PathVariable Integer aid,
			@RequestBody Article article,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			article = articleSvc.update(article, aid, principal.getName());
			if (article == null) {
				res.setStatus(404);
			}
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			article = null;
		}
		
		return article;
	}
	
	@PutMapping("articles/enable/{aid}")
	public void enable(
			@PathVariable Integer aid,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			if (articleSvc.enable(aid, principal.getName())) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}
	
	@DeleteMapping("articles/disable/{aid")
	public void disable(
			@PathVariable Integer aid,
			HttpServletResponse res,
			Principal principal)
	{
		try {
			if (articleSvc.disable(aid, principal.getName())) {
				res.setStatus(204);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}
}
