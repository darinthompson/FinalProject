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

class SeriesTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Series series;

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
		series = em.find(Series.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		series = null;
	}

	@Test
	void test() {
		assertNotNull(series);
		assertEquals("LCS Sumer Split", series.getName());
		assertEquals("North America League of Legends pro circuit", series.getDescription());
		assertEquals("https://gamepedia.cursecdn.com/lolesports_gamepedia_en/c/c8/LCS_2020_Logo.png", series.getImgURL());
		assertEquals(1, series.getSeriesMatch().get(0).getId());
	}

}
