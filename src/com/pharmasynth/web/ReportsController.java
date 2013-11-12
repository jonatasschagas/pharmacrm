package com.pharmasynth.web;

import java.util.ArrayList;
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

import com.pharmasynth.dao.ChartsDAO;
import com.pharmasynth.dao.ClientDAO;
import com.pharmasynth.dao.ProductDAO;
import com.pharmasynth.model.ChartDTO;
import com.pharmasynth.model.Client;
import com.pharmasynth.model.Product;
import com.pharmasynth.util.Utils;

@Controller
public class ReportsController extends MultiActionController
{
	private static Logger log = Logger.getLogger(ReportsController.class);
	
	private ChartsDAO chartsDAO = new ChartsDAO();
	
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ClientDAO clientDAO;
	
	/**
	 * Forwards to index view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "reports/index.do",method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("reports/index");
	}
	
	@RequestMapping(value = "reports/productClientsView.do",method = RequestMethod.GET)
	public ModelAndView productClientsView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("products",productDAO.list("name"));
		return new ModelAndView("reports/productClientsView",params);
	}
	
	/**
	 * Returns a list of clients who have purchased a certain product
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "reports/productClients.do",method = RequestMethod.GET)
	public ModelAndView productClients(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			String productIdStr = Utils.cleanString(request.getParameter("product"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			
			Product p = null;
			if(productIdStr != null)
			{
				try
				{
					p = productDAO.get(Long.parseLong(productIdStr));
				}
				catch (Exception ex){}
			}
			
			params.put("product",p);
			
			List<ChartDTO> l = chartsDAO.clientSales(allTimes, startDate, endDate,p);
			
			params.put("list",l);
			
		}
		catch (Exception ex)
		{
			log.error("productClients: error generating chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/productClients",params);
	}
	
	@RequestMapping(value = "reports/clientProductsView.do",method = RequestMethod.GET)
	public ModelAndView clientProductsView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("clients",clientDAO.list("name"));
		return new ModelAndView("reports/clientProductsView",params);
	}
	

	/**
	 * Returns a list of products that have been purchased by a certain client
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "reports/clientProducts.do",method = RequestMethod.GET)
	public ModelAndView clientProducts(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			String clientIdStr = Utils.cleanString(request.getParameter("client"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			
			Client cl = null;
			if(clientIdStr != null)
			{
				try
				{
					cl = clientDAO.get(Long.parseLong(clientIdStr));
				}
				catch (Exception ex){}
			}
			
			params.put("client",cl);
			
			List<ChartDTO> l = chartsDAO.productsSales(allTimes, startDate, endDate,cl);
			
			params.put("list",l);
			
		}
		catch (Exception ex)
		{
			log.error("clientProducts: error generating chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/clientProducts",params);
	}
	
	@RequestMapping(value = "reports/productSalesView.do",method = RequestMethod.GET)
	public ModelAndView productSalesView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("reports/productSalesView");
	}
	
	@RequestMapping(value = "reports/revenueView.do",method = RequestMethod.GET)
	public ModelAndView revenueView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("reports/revenueView");
	}
	
	
	/**
	 * Returns the Revenue from the company du
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "reports/revenue.do",method = RequestMethod.GET)
	public ModelAndView revenue(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			
			List<ChartDTO> l = chartsDAO.revenueTime(allTimes, startDate, endDate);
			
			params.put("list",l);
		
		}
		catch (Exception ex)
		{
			log.error("revenue: error generating  chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/revenue",params);
	}
	
	@RequestMapping(value = "reports/clientsTimeView.do",method = RequestMethod.GET)
	public ModelAndView clientsTimeView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("clients",clientDAO.list("name"));
		return new ModelAndView("reports/clientsTimeView",params);
	}
	
	@RequestMapping(value = "reports/clientsTime.do",method = RequestMethod.GET)
	public ModelAndView clientsTime(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			String clientIdStr = Utils.cleanString(request.getParameter("client"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			

			Client cl = null;
			if(clientIdStr != null)
			{
				try
				{
					cl = clientDAO.get(Long.parseLong(clientIdStr));
				}
				catch (Exception ex){}
			}
			
			List<ChartDTO> l = chartsDAO.clientRevenueTime(allTimes, startDate, endDate, cl);
			
			if(l != null && l.size() > 0)
			{
				Map<String,List<ChartDTO>> mp = new  HashMap<String, List<ChartDTO>>();
				
				for(ChartDTO ch : l)
				{
					List<ChartDTO> lc = mp.get(ch.getLabel());
					
					if(lc == null)
					{
						lc = new ArrayList<ChartDTO>();
					}
					
					lc.add(ch);
					mp.put(ch.getLabel(),lc);
				}
				
				params.put("map", mp);
			}
		}
		catch (Exception ex)
		{
			log.error("clientsTime: error generating sales chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/clientsTime",params);
	}
	
	@RequestMapping(value = "reports/productSales.do",method = RequestMethod.GET)
	public ModelAndView productSales(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			
			List<ChartDTO> l = chartsDAO.productsSales(allTimes, startDate, endDate,null);
			
			params.put("list",l);
		
			
		}
		catch (Exception ex)
		{
			log.error("productSales: error generating product sales chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/productSales",params);
	}
	
	@RequestMapping(value = "reports/clientSalesView.do",method = RequestMethod.GET)
	public ModelAndView clientSalesView(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		return new ModelAndView("reports/clientSalesView");
	}
	
	
	@RequestMapping(value = "reports/clientSales.do",method = RequestMethod.GET)
	public ModelAndView clientSales(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			Boolean allTimes = true;
			Date startDate = null;
			Date endDate = null;
			
			String allTimesStr = Utils.cleanString(request.getParameter("allTimes"));
			String startDateStr = Utils.cleanString(request.getParameter("startDate"));
			String endDateStr = Utils.cleanString(request.getParameter("endDate"));
			
			if(allTimesStr != null && allTimesStr.equals("true"))
			{
				allTimes = true;
			}
			else if(allTimesStr != null)
			{
				allTimes = false;
			}
			
			if(startDateStr != null && endDateStr != null)
			{
				try
				{
					startDate = Utils.parseDate(startDateStr);
					endDate = Utils.parseDate(endDateStr);
				}
				catch (Exception ex)
				{}
				
			}
			
			List<ChartDTO> l = chartsDAO.clientSales(allTimes, startDate, endDate,null);
			
			params.put("list",l);
		
			
		}
		catch (Exception ex)
		{
			log.error("clientSales: error generating client sales chart.",ex);
			params.put("error","Unable to generate report.");
		}
		return new ModelAndView("reports/clientSales",params);
	}
}
