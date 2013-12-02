package com.pharmasynth.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.OrderProduct;
import com.pharmasynth.util.Utils;

@SuppressWarnings("unchecked")
@Component
public class OrderProductDAO extends BaseDAO<OrderProduct> {

	@Autowired
	public OrderProductDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	public enum TypeQuery
	{
		ALL,
		CLIENT_NAME,
		PRODUCT_NAME,
		COUNTRY
	}
	
	/**
	 * Retrieves the Order Products by the typeQuery
	 * @param name
	 * @return
	 */
	public List<OrderProduct> find(String name,TypeQuery type, String orderBy,Date startDate, Date endDate)
	{
		List<OrderProduct> l = null;
		
		List<Object> paramsList = new ArrayList<Object>();
		String query = "from OrderProduct ";
		StringBuffer where = new StringBuffer();
		
		if(name != null && type != null)
		{
			switch(type)
			{	case ALL:
					where.append(" order.client.name like ? or order.client.country like ?"
					+ " or product.name like ? ");
					paramsList.add("%" + name + "%");
					paramsList.add("%" + name + "%");
					paramsList.add("%" + name + "%");
					break;
				case CLIENT_NAME:
					where.append(" order.client.name like ? ");
					paramsList.add("%" + name + "%");
					break;
				case PRODUCT_NAME:
					where.append(" product.name like ? ");
					paramsList.add("%" + name + "%");
					break;
				case COUNTRY:
					where.append(" order.client.country like ? ");
					paramsList.add("%" + name + "%");
					break;
			}
		}
		
		if(startDate != null)
		{
			if(where.length() > 0)
			{
				where.append(" and ");
			}
			where.append(" order.date > ? ");
			paramsList.add(startDate);
		}
		
		if(endDate != null)
		{
			if(where.length() > 0)
			{
				where.append(" and ");
			}
			where.append(" order.date < ? ");
			paramsList.add(endDate);
		}
		
		if(where.length() > 0)
		{
			query += " where " + where.toString() + " order by "+orderBy + "";
		}
		else
		{
			query += " order by "+orderBy + "";
		}
		
		
		l = getHibernateTemplate().find(query,paramsList.toArray());
		
		return l;
	}
	
	/**
	 * Retrieves the OrderProduct ordering by parameter
	 * @param name
	 * @return
	 */
	public List<OrderProduct> list(String orderBy)
	{
		List<OrderProduct> l = getHibernateTemplate().find("from OrderProduct order by "+orderBy+" ");
		
		return l;
	}
	
	
}
