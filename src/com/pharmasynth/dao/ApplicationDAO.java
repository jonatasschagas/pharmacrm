package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.Application;

@Component
public class ApplicationDAO extends BaseDAO<Application> {

	@Autowired
	public ApplicationDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	/**
	 * finds applications by name
	 * @param name
	 * @return
	 */
	public List<Application> findByName(String name)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<Application> l = getHibernateTemplate().find("from Application where name like ? ",params);
		
		return l;
	}
	
}
