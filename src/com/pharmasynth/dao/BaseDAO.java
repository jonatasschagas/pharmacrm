package com.pharmasynth.dao;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public abstract class BaseDAO<T> extends HibernateDaoSupport
{
	private static Logger log = Logger.getLogger(BaseDAO.class);
	
	@SuppressWarnings({ "unchecked" })
	private final Class<T> typeClass = (Class<T>)(((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]);

	@Autowired
	public BaseDAO(SessionFactory sessionFactory)
	{
		this.setSessionFactory(sessionFactory);
	}
	
	/**
	 * Creates a or updates an object in storage.
	 * 
	 * @param task Task to save.
	*/
	public T save(T obj) {
		
		getHibernateTemplate().saveOrUpdate(obj);
		
		getHibernateTemplate().flush();
		if(log.isDebugEnabled())
		{
			log.debug("save: object "+obj.getClass().getSimpleName()+" saved. " + obj);
		}
		return obj;
	}
	
	/**
	 * Returns an object based on the id
	 * @param id
	 * @return
	 */
	public T get(Long id)
	{
		
		T obj = (T) getHibernateTemplate().get(typeClass, id);
		if(log.isDebugEnabled())
		{
			if(obj != null)
			{
				log.debug("get: object "+obj.getClass().getSimpleName()+" retrieved. " + obj);
			}
			else
			{
				log.debug("get: object "+typeClass.getSimpleName()+" could not be retrieved. Id: " + id);
			}
				
		}
		return obj;
	}
	
	/**
	 * Lists all the objects from the database
	 *  @return
	 */
	@SuppressWarnings("unchecked")
	public List<T> list()
	{
		String simpleName = typeClass.getSimpleName();
		List<T> lp = getHibernateTemplate().find("from "+simpleName+"");
		if(log.isDebugEnabled())
		{
			log.debug("list: list of "+typeClass.getSimpleName()+" has been retrieved. " + lp);
		}
		return lp;
	}
	
	/**
	 * Delete the object from the Database
	 *  @return
	 */
	public void delete(Object obj)
	{
		getHibernateTemplate().delete(obj);
		if(log.isDebugEnabled())
		{
			log.debug("delete: object "+typeClass.getSimpleName()+" has been deleted successfully. " + obj);
		}
	}
}
