package com.skilldistillery.esn.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

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

class RegionTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Region region;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("EsportsPU");	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		region = em.find(Region.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		region = null;
		em.close();
	}

	@Test
	@DisplayName("TESTING SIMPLE MAPPINGS")
	void test() {
		assertNotNull(region);
		assertEquals("North America", region.getName());
	}
	
	@Test
	@DisplayName("TESTING REGION LIST OF ORGANIZATIONS")
	void Organization_test() {
		assertNotNull(region.getOrganizations());
		assertTrue(region.getOrganizations().size() > 0);
	}

}
