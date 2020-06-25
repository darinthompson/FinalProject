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

class PlayerTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Player player;

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
		player = em.find(Player.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		player = null;
		em.close();
	}

	@Test
	void test() {
		assertNotNull(player);
		assertEquals("Robert", player.getFirstName());
		assertEquals("Huang", player.getLastName());
	}

	@Test
	void teamsTest() {
		assertNotNull(player.getTeams());
		assertTrue(player.getTeams().size() > 0);

	}

	@Test
	void statsTest() {
		assertNotNull(player.getStats());
		assertTrue(player.getStats().size() > 0);

	}

}
