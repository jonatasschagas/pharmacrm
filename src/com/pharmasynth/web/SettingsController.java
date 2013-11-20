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
public class SettingsController extends MultiActionController
{
	private static Logger log = Logger.getLogger(SettingsController.class);
	
	@Autowired
	private UserDAO userDAO;
	
	/**
	 * Forwards to index view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "settings/index.do",method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("settings/index");
	}
	
	@RequestMapping(value = "settings/changePassword.do",method = RequestMethod.GET)
	public ModelAndView changePasswordView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("settings/changePassword");
	}
	
	@RequestMapping(value = "settings/changePassword.do",method = RequestMethod.POST)
	public ModelAndView changePasswordPost(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			String currentPassword = Utils.cleanString(request.getParameter("currentPassword"));
			String newPassword = Utils.cleanString(request.getParameter("newPassword"));
			String confirmPassword = Utils.cleanString(request.getParameter("confirmPassword"));
			
			if(currentPassword == null)
			{
				params.put("error","Please, provide the current password.");
				return new ModelAndView("settings/changePassword",params);
			}
			
			if(newPassword == null)
			{
				params.put("error","Please, provide the new password.");
				return new ModelAndView("settings/changePassword",params);
			}
			
			if(confirmPassword == null)
			{
				params.put("error","Please, confirm the new password.");
				return new ModelAndView("settings/changePassword",params);
			}
			
			if(confirmPassword.equals(newPassword) == false)
			{
				params.put("error","The new password and the field 'confirm password' must match.");
				return new ModelAndView("settings/changePassword",params);
			}
			
			User user = (User)request.getSession().getAttribute("user");
			
			if(currentPassword.equals(user.getPassword()) == false)
			{
				params.put("error","The current password is incorrect. Please, provide the current password.");
				return new ModelAndView("settings/changePassword",params);
			}
			
			user.setPassword(newPassword);
			user = userDAO.save(user);
			request.getSession().setAttribute("user",user);
			
			params.put("success","Password has been changed successfully.");
			return new ModelAndView("settings/index",params);
		}
		catch (Exception ex)
		{
			log.error("changePasswordPost",ex);
			params.put("error","Server internal error.");
		}
		return new ModelAndView("settings/index",params);
	}
}
