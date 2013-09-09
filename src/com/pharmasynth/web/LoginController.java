package com.pharmasynth.web;

import java.util.HashMap;
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

import com.pharmasynth.dao.UserDAO;
import com.pharmasynth.model.User;
import com.pharmasynth.util.Utils;

@Controller
public class LoginController extends MultiActionController
{
	private static Logger log = Logger.getLogger(LoginController.class);
	
	@Autowired
	private UserDAO userDAO;
	
	/**
	 * Redirects to the login page \
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "login.do",method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String, Object> model = new HashMap<String, Object>();
		
		 try
		 {
			 if(isLoggedIn(request))
		     {
				 return new ModelAndView("index");
		     }
		     else
		     {
	            String email = Utils.cleanString(request.getParameter("email"));
	            String password = Utils.cleanString(request.getParameter("password"));
	       
	            if(email != null && password != null)
	            {
		
	            	User user = userDAO.findByEmail(email, password);
	            	
	            	if(user != null)
	            	{
	            		request.getSession().setAttribute("logged_in","true");
	            		request.getSession().setAttribute("user",user);
	            		
	            		model.put("success","Welcome " + user.getName() + "!");
	            		return new ModelAndView("index",model);
	            	}
	            }
		     }
	   	}
		catch (Exception ex)
		{
		    log.error("error logging in",ex);
		}
	    
		model.put("error","Invalid e-mail or password");
		return new ModelAndView("login",model);
	}
	
	/**
	 * Forwards to login view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "login.do",method = RequestMethod.GET)
	public ModelAndView loginGet(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("login");
	}
	
	/**
	 * Invalidates the session and sends to the login page
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception 	
	{
		request.getSession().invalidate();
		return new ModelAndView("login");
	}
	
	/**
	 * Checks whether the user is logged in or not
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private boolean isLoggedIn(HttpServletRequest request) throws Exception
    {
        String loggedIn = (String)request.getSession().getAttribute("logged_in");
        
        log.info("user logged in : " + loggedIn);
        
        return loggedIn != null && loggedIn.equals("true");
    }
	
}
