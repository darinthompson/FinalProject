package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Article;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.enums.Role;
import com.skilldistillery.esn.repositories.ArticleRepo;
import com.skilldistillery.esn.repositories.ProfileRepo;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleRepo articleRepo;

	@Autowired
	private ProfileRepo profileRepo;

	@Autowired
	private UserRepository userRepo;

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
		Article result = null;

		try {
			Optional<Article> opt = articleRepo.findById(id);
			if (opt.isPresent()) {
				result = opt.get();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Article create(Article article, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Profile profile = profileRepo.findByUser_Username(username);
		
		System.out.println("-------"+loggedInUser+"----------");
		System.out.println("-------"+profile+"----------");

		if (profile.getUser().equals(loggedInUser)) {
			article.setAuthor(profile);
			article.setEnabled(true);
			articleRepo.saveAndFlush(article);
			return article;
		} else {
			article = null;
		}
		
		return article;
	}

	@Override
	public Article update(Article article, Integer aid, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Profile profile = profileRepo.findByUser_Username(username);
		Article updated = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (profile.getUser().equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
			if (updated != null) {
				updated.setTitle(article.getTitle());
				updated.setContent(article.getContent());
				updated.setImage(article.getImage());
				articleRepo.saveAndFlush(updated);
			} else {
				updated = null;
			}
		}
		
		return updated;
	}

	@Override
	public boolean enable(Integer aid, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Profile profile = profileRepo.findByUser_Username(username);
		Article toEnable = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (profile.getUser().equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
			if (toEnable != null) {
				toEnable.setEnabled(true);
				articleRepo.saveAndFlush(toEnable);
			}
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean disable(Integer aid, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Profile profile = profileRepo.findByUser_Username(username);
		Article toDisable = articleRepo.findByIdAndAuthor_Id(aid, profile.getId());

		if (profile.getUser().equals(loggedInUser) || loggedInUser.getRole().equals(Role.Admin)) {
			if (toDisable != null) {
				toDisable.setEnabled(false);
				articleRepo.saveAndFlush(toDisable);
			}
			return true;
		} else {
			return false;
		}
	}

}
