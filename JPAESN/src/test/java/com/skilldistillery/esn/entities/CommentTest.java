package com.skilldistillery.esn.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import net.bytebuddy.implementation.bind.annotation.DefaultMethod;

class CommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("EsportsPU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		comment = null;
	}

	@Test
	void test() {
		assertNotNull(comment);
		assertEquals("awesome", comment.getContent());
	}
	
	@Test
	@DisplayName("Testing the relationships between comment and profile and article")
	void RelationshipMappingsTest() {
		assertNotNull(comment.getProfile());
		assertNotNull(comment.getArticle());
		assertEquals("test", comment.getArticle().getTitle());
		assertEquals("bobdobbs@esports.com", comment.getProfile().getEmail());
	}

}
