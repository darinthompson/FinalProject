package com.skilldistillery.esn.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ArticleTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Article article;

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
		article = em.find(Article.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		article = null;
	}

	@Test
	void test() {
		assertNotNull(article);
		assertEquals("test", article.getTitle());
		assertEquals("test article", article.getContent());
		assertEquals("https://specials-images.forbesimg.com/imageserve/5e0f8f19db7a9600065d7cec/960x0.jpg?fit=scale", article.getImage());
	}

}
