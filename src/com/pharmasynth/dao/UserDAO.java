package com.pharmasynth.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pharmasynth.model.User;

@Component
public class UserDAO extends BaseDAO<User> {

	@Autowired
	public UserDAO(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

	public User save(User user)
	{
		String encPassword = getPassword(user.getPassword());
		user.setPassword(encPassword);
		return super.save(user);
	}

	/**
	 * Retrieves the User by e-mail and password
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public User findByEmail(String email, String password)
	{
		Object[] params = new Object[]{email,getPassword(password)};
		
		List<User> l = getHibernateTemplate().find("from User where email like ? and password like ?",params);
		if(l != null && l.size() > 0)
		{
			return l.get(0);
		}
		return null;
	}
	
	private String getPassword(String password)
	{
		return password;
		//return DigestUtils.md5Hex(password);
	}
}
