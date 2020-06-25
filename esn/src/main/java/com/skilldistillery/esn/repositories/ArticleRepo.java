package com.skilldistillery.esn.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.esn.entities.Article;

public interface ArticleRepo extends JpaRepository<Article, Integer> {
	
	List<Article> findAllWhereEnabledTrue();
	Article findByIdAndProfile_Id(Integer articleId, Integer profileId);
}
