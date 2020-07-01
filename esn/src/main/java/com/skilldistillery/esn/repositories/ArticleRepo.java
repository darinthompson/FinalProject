package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Article;

public interface ArticleRepo extends JpaRepository<Article, Integer> {
	
	List<Article> findByEnabledTrue();
	List<Article> findByAuthor_IdAndEnabledTrue(Integer profileId);
	List<Article> findByGameId(Integer gameid);
	Article findByIdAndAuthor_Id(Integer articleId, Integer profileId);
	
}
