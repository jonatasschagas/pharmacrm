package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.Client;

@Component
public class ClientDAO extends BaseDAO<Client> {

	@Autowired
	public ClientDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

	/**
	 * Retrieves the Clients by name
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Client> findByName(String name)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<Client> l = getHibernateTemplate().find("from Client where name like ? ",params);
		
		return l;
	}
	
	/**
	 * Retrieves the Clients by all the parameters
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Client> findByAll(String search)
	{
		Object[] params = new Object[]{"%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%"
				,"%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%","%"+search+"%"};
		
		List<Client> l = getHibernateTemplate().find("from Client where name like ? or country like ?"
				+ " or city like ? or address like ? or billingAddress like ? or telephone like ? or email like ? or "
				+ " acquisitionType like ? or clientType like ? or industryType like ? or description like ?",params);
		
		return l;
	}
	
}
