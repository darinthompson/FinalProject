package com.skilldistillery.esn.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.esn.entities.Article;
import com.skilldistillery.esn.entities.Comment;
import com.skilldistillery.esn.entities.Profile;
import com.skilldistillery.esn.entities.User;
import com.skilldistillery.esn.enums.Role;
import com.skilldistillery.esn.repositories.ArticleRepo;
import com.skilldistillery.esn.repositories.CommentRepo;
import com.skilldistillery.esn.repositories.ProfileRepo;
import com.skilldistillery.esn.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepo commentRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ProfileRepo profileRepo;
	
	@Autowired
	private ArticleRepo articleRepo;
	
	@Override
	public List<Comment> index() {
		return commentRepo.findAll();
	}

	@Override
	public Comment show(Integer cid) {
		Optional<Comment> opt = commentRepo.findById(cid);
		if (opt.isPresent()) {
			return opt.get();
		} else {
			return null;			
		}
	}

	@Override
	public List<Comment> getAllProfileComments(String username) {
		Profile profile = profileRepo.findByUser_Username(username);
		return commentRepo.findByProfile_Id(profile.getId());
	}

	@Override
	public List<Comment> getAllArticleComments(Integer aid) {
		return commentRepo.findByArticle_Id(aid);
	}

	@Override
	public Comment create(Integer aid, Comment newComment, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		Profile userProfile = profileRepo.findByUser_Username(username);
		Optional<Article> artOpt = articleRepo.findById(aid);
		
		if (userProfile.getUser().equals(loggedInUser)) {
			if (artOpt.isPresent()) {
				Article article = artOpt.get();
				newComment.setEnabled(true);
				newComment.setProfile(userProfile);
				newComment.setArticle(article);
				commentRepo.saveAndFlush(newComment);
			}
		} else {
			newComment = null;
		}
		return newComment;
	}

	@Override
	public boolean enable(Integer cid, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		boolean enabled = false;
		
		Optional<Comment> optComment = commentRepo.findById(cid);
		if (optComment.isPresent()) {
			Comment toEnable = optComment.get();
			if (loggedInUser.getRole().equals(Role.Admin)) {
				toEnable.setEnabled(true);
				commentRepo.saveAndFlush(toEnable);
				enabled = true;
			}
		}
		
		return enabled;
	}

	@Override
	public boolean disable(Integer cid, String username) {
		User loggedInUser = userRepo.findByUsername(username);
		boolean disabled = false;
		
		Optional<Comment> optComment = commentRepo.findById(cid);
		if (optComment.isPresent()) {
			Comment toDisable = optComment.get();
			if (toDisable.getProfile().getUser().equals(loggedInUser) ||
					loggedInUser.getRole().equals(Role.Admin)) {
				toDisable.setEnabled(false);
				commentRepo.saveAndFlush(toDisable);
				disabled = true;
			}
		}
		
		return disabled;
	}

}