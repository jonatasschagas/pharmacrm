package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.Contact;

@Component
public class ContactDAO extends BaseDAO<Contact> {

	@Autowired
	public ContactDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	/**
	 * finds contacts by name
	 * @param name
	 * @return
	 */
	public List<Contact> findByName(String name)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<Contact> l = getHibernateTemplate().find("from Contact where name like ? ",params);
		
		return l;
	}
	
}
