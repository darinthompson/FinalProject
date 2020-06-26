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
	public List<Article> getAllAuthorEnabledArticles(String username) {
		Profile profile = profileRepo.findByUser_Username(username);
		return articleRepo.findByAuthor_IdAndEnabledTrue(profile.getId());
	}

	@Override
	public Article show(Integer id) {
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
	public Article create(Article article, String username) {
		Profile profile = profileRepo.findByUser_Username(username);

		if (profile != null) {
			article.setAuthor(profile);
			articleRepo.saveAndFlush(article);
			return article;
		} else {
			article = null;
		}

		return article;
	}

	@Override
	public Article update(Article article, Integer aid, String username) {
		Profile profile = profileRepo.findByUser_Username(username);
		Article updated = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (updated != null) {
			updated.setTitle(article.getTitle());
			updated.setContent(article.getContent());
			updated.setImage(article.getImage());
			articleRepo.saveAndFlush(updated);
		}

		return updated;
	}

	@Override
	public boolean enable(Integer aid, String username) {
		Profile profile = profileRepo.findByUser_Username(username);
		Article toEnable = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (toEnable != null) {
			toEnable.setEnabled(true);
			articleRepo.saveAndFlush(toEnable);
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean disable(Integer aid, String username) {
		Profile profile = profileRepo.findByUser_Username(username);
		Article toDisable = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (toDisable != null) {
			toDisable.setEnabled(false);
			articleRepo.saveAndFlush(toDisable);
			return true;
		} else {
			return false;
		}
	}

}
