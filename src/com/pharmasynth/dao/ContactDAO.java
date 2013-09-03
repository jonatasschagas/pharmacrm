package com.pharmasynth.dao;

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
}
