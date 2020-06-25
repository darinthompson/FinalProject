package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Article;

public interface ArticleService {

	List<Article> getAllArticles();
	List<Article> getAllEnabledArticles();
	List<Article> getAllAuthorEnabledArticles(String username);
	Article show(Integer id);
	Article create(Article article, String username);
	Article update(Article article, Integer articleId, String username);
	boolean enable(Integer articleId, String username);
	boolean disable(Integer articleId, String username);
}
