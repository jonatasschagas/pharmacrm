package com.pharmasynth.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.pharmasynth.dao.ClientDAO;
import com.pharmasynth.dao.ContactDAO;
import com.pharmasynth.model.Client;
import com.pharmasynth.model.Contact;
import com.pharmasynth.util.Country;
import com.pharmasynth.util.Utils;

@Controller
public class ClientController extends MultiActionController
{
	private static Logger log = Logger.getLogger(ClientController.class);
	
	@Autowired
	private ClientDAO clientDAO;
	
	@Autowired
	private ContactDAO contactDAO;
	
	
	/**
	 * Forwards to index view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "clients/index.do",method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String typeSearch = Utils.cleanString(request.getParameter("typeSearch"));
		String searchQuery = Utils.cleanString(request.getParameter("searchQuery"));
		
		List<Client> list = null;
		if(typeSearch != null && searchQuery != null)
		{
			if(typeSearch.equalsIgnoreCase("name"))
			{
				list = clientDAO.findByName(searchQuery);
			} 
			else if(typeSearch.equalsIgnoreCase("contactPerson"))
			{
				
			}
			else if(typeSearch.equalsIgnoreCase("all"))
			{
				list = clientDAO.findByAll(searchQuery);
			}
			
			params.put("typeSearch",typeSearch);
			params.put("searchQuery",searchQuery);
			
		}
		else
		{
			list = clientDAO.list();
		}
		
		params.put("clients",Utils.paginate(request, list));
		params.put("numberOfPages",Utils.getNumberOfPages(list));
		params.put("currentPage",Utils.getCurrentPage(request));
		
		return new ModelAndView("clients/index",params);
	}
	
	/**
	 * Forwards to new clients view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "clients/new_clients.do",method = RequestMethod.GET)
	public ModelAndView newClients(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		
		if(id != null)
		{
			try
			{
				Client cl = clientDAO.get(Long.parseLong(id));
				params.put("client",cl);
			}
			catch (Exception ex)
			{
				log.error("newClients: unable to retrieve user with the id " + id,ex);
			}
		}
		
		params.put("countries",Country.listCountries());
		return new ModelAndView("clients/new_clients",params);
	}
	
	/**
	 * Forwards to view clients view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "clients/view_clients.do",method = RequestMethod.GET)
	public ModelAndView viewClients(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		if(id != null)
		{
			try
			{
				Client cl = clientDAO.get(Long.parseLong(id));
				params.put("client",cl);
			}
			catch (Exception ex)
			{
				log.error("newClients: unable to retrieve user with the id " + id,ex);
				params.put("error","Internal Error, please try again.");
				return new ModelAndView("clients/index",params);
			}
		}
		else
		{
			params.put("error","Internal Error, please try again.");
			return new ModelAndView("clients/index",params);
		}
		
		return new ModelAndView("clients/view_clients",params);
	}
	
	/**
	 * Deletes a contact from the client
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "clients/delete_contact.do",method = RequestMethod.GET)
	public ModelAndView deleteContact(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String clientId = Utils.cleanString(request.getParameter("client_id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		
		if(id != null && clientId != null)
		{
			Contact c = contactDAO.get(Utils.getInteger(id).longValue());
			if(c != null)
			{
				contactDAO.delete(c);
				Client cl = clientDAO.get(Utils.getInteger(clientId).longValue());
				if(cl != null && cl.getContacts() != null)
				{
					params.put("client", cl);
				}
			}
		}
		
		return new ModelAndView("clients/contacts",params);
	}
	
	@RequestMapping(value = "clients/delete_client.do",method = RequestMethod.GET)
	public ModelAndView deleteClient(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		String name = null;
		if(id != null)
		{
			Client cl = clientDAO.get(Utils.getInteger(id).longValue());
			name = cl.getName();
			clientDAO.delete(cl);
		}
		
		params.put("success","Client " + name  + " deleted sucessfully.");
		params.put("clients",clientDAO.list());
		
		return new ModelAndView("clients/index",params);
	}
	
	
	/**
	 * Saves the client
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "clients/save_clients.do",method = RequestMethod.POST)
	public ModelAndView saveClient(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String name = Utils.cleanString(request.getParameter("name"));
		String country = Utils.cleanString(request.getParameter("country"));
		String city = Utils.cleanString(request.getParameter("city"));
		String address = Utils.cleanString(request.getParameter("address"));
		String billingAddress = Utils.cleanString(request.getParameter("billingAddress"));
		String telephone = Utils.cleanString(request.getParameter("telephone"));
		String email = Utils.cleanString(request.getParameter("email"));
		String acquisition = Utils.cleanString(request.getParameter("acquisition"));
		String type =  Utils.cleanString(request.getParameter("type"));
		String industry =  Utils.cleanString(request.getParameter("industry"));
		String description =  Utils.cleanString(request.getParameter("description"));
		
		Map<String,Object> params = new HashMap<String, Object>();
			
		if(name == null)
		{
			params.put("error","Name field is mandatory. Please, provide a name.");
			return new ModelAndView("clients/new_clients",params); 
		}
		
		try
		{
			
			Client client = null;
			
			if(id != null)
			{
				client = clientDAO.get(Utils.getInteger(id).longValue());
			}
			else
			{
				client = new Client();
				client.setCreatedDate(new Date());
			}
			
			client.setAcquisitionType(acquisition);
			client.setAddress(address);
			client.setBillingAddress(billingAddress);
			client.setCity(city);
			client.setClientType(type);
			client.setCountry(country);
			client.setDescription(description);
			client.setEmail(email);
			client.setIndustryType(industry);
			client.setName(name);
			client.setTelephone(telephone);
			
			client = clientDAO.save(client);
			
			if(client != null && client.getId() != null)
			{
				params.put("success","Client " + client.getName() + " registered successfully in the database.");
				params.put("clients",clientDAO.list());
				return new ModelAndView("clients/index",params);
			}
			else
			{
				params.put("error","Error saving the Client, please try again or contact the administrator.");
				return new ModelAndView("clients/new_clients",params);
			}
			
		}
		catch (Exception ex)
		{
			log.error("saveClient: error saving the Client.",ex);
			params.put("error","Error saving the Client, please try again or contact the administrator.");
			return new ModelAndView("clients/new_clients",params); 
		}
	}
	
	@RequestMapping(value = "clients/edit_contact.do",method = RequestMethod.GET)
	public ModelAndView editContact(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			String id = Utils.cleanString(request.getParameter("id"));
			String clientId = Utils.cleanString(request.getParameter("client_id"));
			Client cl = clientDAO.get(Long.parseLong(clientId));
				
			if(cl == null)
			{
				params.put("error","Error editing the contact, please try again or contact the administrator.");
				return new ModelAndView("clients/contacts",params);
			}
			
			Contact c = contactDAO.get(Long.parseLong(id));
			
			if(c == null)
			{
				params.put("error","Error editing the contact, please try again or contact the administrator.");
				return new ModelAndView("clients/contacts",params);
			}
		
			params.put("client",cl);
			params.put("contact",c);
		}
		catch (Exception ex)
		{
			log.error("editContact: error editing the contact.",ex);
			params.put("error","Error saving the Contact, please try again or contact the administrator.");
		}
			
		return new ModelAndView("clients/contacts",params);
	}
	
	@RequestMapping(value = "clients/save_contact.do",method = RequestMethod.GET)
	public ModelAndView saveContact(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		String clientId = Utils.cleanString(request.getParameter("client_id"));
		String name = Utils.cleanString(request.getParameter("name"));
		String email = Utils.cleanString(request.getParameter("email"));
		String position = Utils.cleanString(request.getParameter("position"));
		String address = Utils.cleanString(request.getParameter("address"));
		String telephone = Utils.cleanString(request.getParameter("telephone"));
		
		try
		{
			Client cl = clientDAO.get(Long.parseLong(clientId));
			
			if(cl == null)
			{
				params.put("error","Error saving the Client, please try again or contact the administrator.");
				return new ModelAndView("clients/contacts",params);
			}
			
			Contact c = null;
			
			if(id != null)
			{
				long longId= Long.parseLong(id);
				
				for(Contact con : cl.getContacts())
				{
					if(con.getId() == longId)
					{
						c = con;
						break;
					}
				}
				
			}
			
			if(c == null)
			{
				c = new Contact();
			}
			
			c.setAddress(address);
			c.setClient(cl);
			c.setEmail(email);
			c.setName(name);
			c.setPosition(position);
			c.setTelephone(telephone);
			
			if(id == null)
			{
				contactDAO.save(c);
			}
			else
			{
				cl = clientDAO.save(cl);
			}
			
			cl = clientDAO.get(cl.getId());
			
			params.put("client",cl);
		}
		catch (Exception ex)
		{
			log.error("saveContact: error saving the contact.",ex);
			params.put("error","Error saving the Contact, please try again or contact the administrator.");
		}
		return new ModelAndView("clients/contacts",params);
	}
	
	
}
