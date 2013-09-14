package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.Product;

@Component
public class ProductDAO extends BaseDAO<Product> {

	@Autowired
	public ProductDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	/**
	 * Retrieves the Products ordering by parameter
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> list(String orderBy)
	{
		List<Product> l = getHibernateTemplate().find("from Product order by "+orderBy+" ");
		
		return l;
	}
	
	
	/**
	 * Retrieves the Products by name
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByName(String name, String orderBy)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<Product> l = getHibernateTemplate().find("from Product where name like ? order by "+orderBy+" ",params);
		
		return l;
	}
	
	/**
	 * Retrieves the Products by cas
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByCAS(String name, String orderBy)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<Product> l = getHibernateTemplate().find("from Product where cas like ? order by "+orderBy+" ",params);
		
		return l;
	}
	
	/**
	 * Retrieves the Products by all the parameters
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByAll(String search, String orderBy)
	{
		Object[] params = new Object[]{"%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%"
				,"%"+search+"%","%"+search+"%"};
		
		List<Product> l = getHibernateTemplate().find("from Product where name like ? or product_idph like ?"
				+ " or product_type like ? or in_stock like ? or price like ? or production_year like ? or cas like ? order by "+orderBy+"",params);
		
		return l;
	}
	
}
