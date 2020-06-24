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

class PlayerMatchStatTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private PlayerMatchStat pms;

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
		pms = em.find(PlayerMatchStat.class, 3);
	}

	@AfterEach
	void tearDown() throws Exception {
		pms = null;
		em.close();
	}

	@Test
	void test() {
		assertNotNull(pms);
		assertEquals(4, pms.getValue());
		assertEquals("Jo", pms.getPlayer().getFirstName());
		assertEquals("Match 1", pms.getMatch().getTitle());
	}

}
