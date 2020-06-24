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

class SeriesMatchTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private SeriesMatch series;

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
		series = em.find(SeriesMatch.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		series = null;
	}

	@Test
	void test() {
		assertNotNull(series);
		assertEquals("Match 1", series.getTitle());
	}


}
