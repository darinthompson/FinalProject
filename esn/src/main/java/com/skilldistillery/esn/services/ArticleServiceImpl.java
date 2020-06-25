package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Article;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.repositories.ArticleRepo;
import com.skilldistillery.esn.repositories.ProfileRepo;

@Service
public class ArticleServiceImpl implements ArticleService {
	
	@Autowired
	private ArticleRepo articleRepo;
	
	@Autowired
	private ProfileRepo profileRepo;

	@Override
	public List<Article> getAllArticles() {
		return articleRepo.findAll();
	}
	
	@Override
	public List<Article> getAllEnabledArticles() {
		return articleRepo.findByEnabledTrue();
	}

	@Override
	public Article getArticleById(Integer id) {
		try {
			Optional<Article> opt = articleRepo.findById(id);
			if (opt.isPresent()) {
				Article result = opt.get();
				return result;
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Article create(Article article, Integer profileId) {
		Optional<Profile> opt = profileRepo.findById(profileId);
		if (opt.isPresent()) {
			Profile profile = opt.get();
			if (profile != null) {
				article.setAuthor(profile);
				try {
					articleRepo.saveAndFlush(article);
					return article;
				} catch (Exception e) {
					e.printStackTrace();
					return null;
				} 
			} else {
				return null;
			}
		}
		return null;
	}

	@Override
	public Article update(Article article, Integer articleId, Integer profileId) {
		Article updated = articleRepo.findByIdAndAuthor_Id(articleId, profileId);
		
		return null;
	}

	@Override
	public boolean enable(Integer articleId, Integer profileId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean disable(Integer articleId, Integer profileId) {
		// TODO Auto-generated method stub
		return false;
	}

}
