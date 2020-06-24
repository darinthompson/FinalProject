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

	@Test
	@DisplayName("testing relational mapping to User")
	void test2() {
		assertNotNull(profile.getUser());
		assertEquals("dobby", profile.getUser().getUserName());
		assertEquals("password", profile.getUser().getPassword());
	}
	
	@Test
	@DisplayName("testing relational mapping to Article")
	void test3() {
		assertNotNull(profile.getArticles());
		assertTrue(profile.getArticles().size() > 0);
		assertEquals("test", profile.getArticles().get(0).getTitle());
		assertEquals("test article", profile.getArticles().get(0).getContent());
	}
	
	@Test
	@DisplayName("testing relational mapping to Comment")
	void test4() {
		assertNotNull(profile.getComments());
		assertTrue(profile.getComments().size() > 0);
		assertEquals("awesome", profile.getComments().get(0).getContent());
	}
	
	@Test
	@DisplayName("testing relational mapping to Organization")
	void test5() {
		assertNotNull(profile.getFavoriteOrganizations());
		assertTrue(profile.getFavoriteOrganizations().size() > 0);
		assertEquals("Cloud 9", profile.getFavoriteOrganizations().get(0).getName());
		assertEquals("Multi game E-sports team", profile.getFavoriteOrganizations().get(0).getDescription());
	}
	
	@Test
	@DisplayName("testing relational mapping to Team")
	void test6() {
		assertNotNull(profile.getFavoriteTeams());
		assertTrue(profile.getFavoriteTeams().size() > 0);
		assertEquals(
				"https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png",
				profile.getFavoriteTeams().get(0).getImage());
	}
	
	@Test
	@DisplayName("testing relational mapping to Player")
	void test7() {
		assertNotNull(profile.getFavoritePlayers());
		assertTrue(profile.getFavoritePlayers().size() > 0);
		assertEquals("Blaber", profile.getFavoritePlayers().get(0).getHandle());
	}
	
	@Test
	@DisplayName("testing relational mapping to Game")
	void test8() {
		assertNotNull(profile.getFavoriteGames());
		assertTrue(profile.getFavoriteGames().size() > 0);
		assertEquals("League of Legends", profile.getFavoriteGames().get(0).getTitle());
		assertEquals("MOBA", profile.getFavoriteGames().get(0).getGenre());
	}
}
