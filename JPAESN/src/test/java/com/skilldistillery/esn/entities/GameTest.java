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

class GameTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Game game;
	
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
		game = em.find(Game.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		game = null;
	}

	@Test
	void GameMappingTest() {
		assertNotNull(game);
		assertEquals("League of Legends", game.getTitle());
		assertEquals("MOBA", game.getGenre());
	}
	

	

}
