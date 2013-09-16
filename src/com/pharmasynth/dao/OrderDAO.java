package com.pharmasynth.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.Order;

@Component
public class OrderDAO extends BaseDAO<Order> {

	@Autowired
	public OrderDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}
		
}
