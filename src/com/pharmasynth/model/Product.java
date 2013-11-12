package com.pharmasynth.model;

import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Class that represents the client
 * @author jonataschagas
 *
 */
@Entity
@Table(name = TableConstants.TABLE_PRODUCTS)
public class Product 
{
	
	private Long id;
	private String name;
	private String productIdPH;
	private String productType;
	private String inStock;
	private String price;
	private String productionYear;
	private String cas;
	private String description;
	private String structurePath;
	private Set<CaseStudy> caseStudies;
	private Set<Application> applications;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	@Basic
	@Column(nullable = false)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Basic
	@Column(nullable = true,name = "product_idph")
	public String getProductIdPH() {
		return productIdPH;
	}
	public void setProductIdPH(String productIdPH) {
		this.productIdPH = productIdPH;
	}
	@Basic
	@Column(nullable = false,name = "product_type")
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	
	@Basic
	@Column(nullable = true,name = "in_stock")
	public String getInStock() {
		return inStock;
	}
	public void setInStock(String inStock) {
		this.inStock = inStock;
	}
	
	@Basic
	@Column(nullable = true)
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	@Basic
	@Column(nullable = true,name="production_year")
	public String getProductionYear() {
		return productionYear;
	}
	public void setProductionYear(String productionYear) {
		this.productionYear = productionYear;
	}
	
	@Basic
	@Column(nullable = true,name="cas")
	public String getCas() {
		return cas;
	}
	public void setCas(String cas) {
		this.cas = cas;
	}
	
	@Basic
	@Column(nullable = true)
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL, mappedBy="product")
	public Set<CaseStudy> getCaseStudies() {
		return caseStudies;
	}
	public void setCaseStudies(Set<CaseStudy> caseStudies) {
		this.caseStudies = caseStudies;
	}
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL, mappedBy="product")
	public Set<Application> getApplications() {
		return applications;
	}
	public void setApplications(Set<Application> applications) {
		this.applications = applications;
	}
	
	@Basic
	@Column(nullable = true,name = "structure_path")
	public String getStructurePath() {
		return structurePath;
	}
	public void setStructurePath(String structurePath) {
		this.structurePath = structurePath;
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", productId="
				+ productIdPH + ", productType=" + productType + ", inStock="
				+ inStock + ", price=" + price + ", productionYear="
				+ productionYear + ", cas=" + cas + ", description="
				+ description + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cas == null) ? 0 : cas.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((inStock == null) ? 0 : inStock.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((price == null) ? 0 : price.hashCode());
		result = prime * result
				+ ((productIdPH == null) ? 0 : productIdPH.hashCode());
		result = prime * result
				+ ((productType == null) ? 0 : productType.hashCode());
		result = prime * result
				+ ((productionYear == null) ? 0 : productionYear.hashCode());
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
		Product other = (Product) obj;
		if (cas == null) {
			if (other.cas != null)
				return false;
		} else if (!cas.equals(other.cas))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (inStock == null) {
			if (other.inStock != null)
				return false;
		} else if (!inStock.equals(other.inStock))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (price == null) {
			if (other.price != null)
				return false;
		} else if (!price.equals(other.price))
			return false;
		if (productIdPH == null) {
			if (other.productIdPH != null)
				return false;
		} else if (!productIdPH.equals(other.productIdPH))
			return false;
		if (productType == null) {
			if (other.productType != null)
				return false;
		} else if (!productType.equals(other.productType))
			return false;
		if (productionYear == null) {
			if (other.productionYear != null)
				return false;
		} else if (!productionYear.equals(other.productionYear))
			return false;
		return true;
	}

}
