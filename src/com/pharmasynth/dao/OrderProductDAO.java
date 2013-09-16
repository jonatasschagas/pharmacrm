package com.pharmasynth.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.OrderProduct;
import com.pharmasynth.util.Utils;

@Component
public class OrderProductDAO extends BaseDAO<OrderProduct> {

	@Autowired
	public OrderProductDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	/**
	 * Retrieves the Order Products by client name
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OrderProduct> findByClientName(String name, String orderBy)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<OrderProduct> l = getHibernateTemplate().find("from OrderProduct where order.client.name like ? order by "+orderBy+" ",params);
		
		return l;
	}
	
	public List<OrderProduct> findByProduct(String name, String orderBy)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<OrderProduct> l = getHibernateTemplate().find("from OrderProduct where product.name like ? order by "+orderBy+" ",params);
		
		return l;
	}
	
	public List<OrderProduct> findByCountry(String name, String orderBy)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<OrderProduct> l = getHibernateTemplate().find("from OrderProduct where order.client.country like ? order by "+orderBy+" ",params);
		
		return l;
	}
	
	/**
	 * Retrieves all the Order Products by all the parameters
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OrderProduct> findByAll(String search, String orderBy,Date startDate, Date endDate)
	{
		Object[] params = null;
		List<OrderProduct> l = null;
		
		Long amount = Utils.getInteger(search).longValue();
		Double price = Utils.getDouble(search);
		
		if(startDate != null && endDate != null)
		{
			params = new Object[]{"%"+search+"%","%"+search+"%","%"+search+"%",amount,price
					,startDate,endDate};
			
			l = getHibernateTemplate().find("from OrderProduct where order.client.name like ? or order.client.country like ?"
					+ " or product.name like ? or amount = ? or price = ? or order.date between ? and ? order by "+orderBy+"",params);
		}
		else
		{
			params = new Object[]{"%"+search+"%","%"+search+"%","%"+search+"%",amount,price};
			
			l = getHibernateTemplate().find("from OrderProduct where order.client.name like ? or order.client.country like ?"
					+ " or product.name like ? or amount = ? or price = ?  order by "+orderBy+"",params);
		}
		
		return l;
	}
	
	/**
	 * Retrieves the OrderProduct ordering by parameter
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OrderProduct> list(String orderBy)
	{
		List<OrderProduct> l = getHibernateTemplate().find("from OrderProduct order by "+orderBy+" ");
		
		return l;
	}
	
	
}
