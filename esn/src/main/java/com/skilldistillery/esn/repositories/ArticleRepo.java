package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Article;

public interface ArticleRepo extends JpaRepository<Article, Integer> {
	
	List<Article> findByEnabledTrue();
	Article findByIdAndAuthor_Id(Integer articleId, Integer profileId);
}
