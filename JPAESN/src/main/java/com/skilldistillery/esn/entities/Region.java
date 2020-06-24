package com.skilldistillery.esn.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Region {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;	
	private String name;
	
	@OneToMany(mappedBy = "region")
	private List<Organization> organizations;
	
	public List<Organization> getOrganizations() {
		return organizations;
	}
	public void setOrganizations(List<Organization> organizations) {
		this.organizations = organizations;
	}
	public Region() {}
	public Region(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Region [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", organizations=");
		builder.append(organizations);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((organizations == null) ? 0 : organizations.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Region other = (Region) obj;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (organizations == null) {
			if (other.organizations != null)
				return false;
		} else if (!organizations.equals(other.organizations))
			return false;
		return true;
	}
	
}
