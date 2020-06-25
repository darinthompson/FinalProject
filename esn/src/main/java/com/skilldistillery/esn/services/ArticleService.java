package com.skilldistillery.esn.services;

import java.util.List;

import com.skilldistillery.esn.entities.Article;

public interface ArticleService {

	List<Article> getAllArticles();
	List<Article> getAllEnabledArticles();
	Article getArticleById(Integer id);
	Article create(Article article, Integer profileId);
	Article update(Article article, Integer articleId, Integer profileId);
	boolean enable(Integer articleId, Integer profileId);
	boolean disable(Integer articleId, Integer profileId);
}
