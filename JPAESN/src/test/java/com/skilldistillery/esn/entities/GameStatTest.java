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

class GameStatTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private GameStat gameStat;
	
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
		gameStat = em.find(GameStat.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		gameStat = null;
	}

	@Test
	void GameMappingTest() {
		assertNotNull(gameStat);
		assertEquals("League of Legends", gameStat.getGame().getTitle());
	}
}
