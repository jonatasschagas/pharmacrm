package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.CaseStudy;

@Component
public class CaseStudyDAO extends BaseDAO<CaseStudy> {

	@Autowired
	public CaseStudyDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
	
	/**
	 * finds case studies by name
	 * @param name
	 * @return
	 */
	public List<CaseStudy> findByName(String name)
	{
		Object[] params = new Object[]{"%"+name+"%"};
		
		List<CaseStudy> l = getHibernateTemplate().find("from CaseStudy where name like ? ",params);
		
		return l;
	}
	
}
