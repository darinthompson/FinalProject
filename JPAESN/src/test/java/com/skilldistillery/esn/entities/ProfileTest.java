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

class ProfileTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Profile profile;

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
		profile = em.find(Profile.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		profile = null;
	}

	@Test
	void test() {
		assertNotNull(profile);
		assertEquals("bobby", profile.getFirstName());
		assertEquals("dobbs", profile.getLastName());
		assertEquals("bobdobbs@esports.com", profile.getEmail());
		assertEquals("https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png", profile.getAvatar());
		
	}

}
