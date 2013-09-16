package com.pharmasynth.web;

import java.text.SimpleDateFormat;
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
import com.pharmasynth.dao.OrderDAO;
import com.pharmasynth.dao.OrderProductDAO;
import com.pharmasynth.dao.ProductDAO;
import com.pharmasynth.model.Client;
import com.pharmasynth.model.Contact;
import com.pharmasynth.model.Order;
import com.pharmasynth.model.OrderProduct;
import com.pharmasynth.util.Country;
import com.pharmasynth.util.Utils;

@Controller
public class OrderController  extends MultiActionController
{
	
	@Autowired
	private ClientDAO clientDAO;
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private OrderProductDAO orderProductDAO;
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	private Logger log = Logger.getLogger(OrderController.class);
	
	/**
	 * Forwards to index view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orders/index.do",method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String typeSearch = Utils.cleanString(request.getParameter("typeSearch"));
		String searchQuery = Utils.cleanString(request.getParameter("searchQuery"));
		String orderBy = Utils.cleanString(request.getParameter("orderBy"));
		Date startDate = null;
		Date endDate = null;
		
		String startDateStr = Utils.cleanString(request.getParameter("fromDate"));
		String endDateStr = Utils.cleanString(request.getParameter("toDate"));
		
		if(orderBy == null)
		{
			orderBy = "id";
		}
		
		List<OrderProduct> list = null;
		if(typeSearch != null && searchQuery != null || startDateStr != null && endDateStr != null)
		{
			if(typeSearch != null && typeSearch.equalsIgnoreCase("clientName"))
			{
				list = orderProductDAO.findByClientName(searchQuery,orderBy);
			} 
			else if(typeSearch != null && typeSearch.equalsIgnoreCase("all") || startDateStr != null && endDateStr != null)
			{
				try
				{
					if(startDateStr != null && endDateStr != null)
					{
						startDate = sdf.parse(startDateStr);
						endDate = sdf.parse(endDateStr);
					}
				}
				catch(Exception ex)
				{
					logger.debug("index: error parsing dates.",ex);
				}
				
				list = orderProductDAO.findByAll(searchQuery,orderBy,startDate,endDate);
			}
			else if(typeSearch != null && typeSearch.equalsIgnoreCase("product"))
			{
				list = orderProductDAO.findByProduct(searchQuery,orderBy);
			}
			else if(typeSearch != null && typeSearch.equalsIgnoreCase("country"))
			{
				list = orderProductDAO.findByCountry(searchQuery,orderBy);
			}
			
			params.put("typeSearch",typeSearch);
			params.put("searchQuery",searchQuery);
			
		}
		else
		{
			list = orderProductDAO.list(orderBy);
		}
		
		params.put("orderBy",orderBy);
		params.put("orderProducts",Utils.paginate(request, list));
		params.put("fromDate",startDate);
		params.put("toDate",endDate);
		params.put("numberOfPages",Utils.getNumberOfPages(list));
		params.put("currentPage",Utils.getCurrentPage(request));
		
		return new ModelAndView("orders/index",params);
	}
	
	/**
	 * Forwards to new order view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orders/new_order.do",method = RequestMethod.GET)
	public ModelAndView newOrder(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		
		if(id != null)
		{
			try
			{
				Order o = orderDAO.get(Long.parseLong(id));
				params.put("order",o);
			}
			catch (Exception ex)
			{
				log.error("newOrder: unable to retrieve order with the id " + id,ex);
			}
		}
		
		params.put("clients",clientDAO.list("name"));
		params.put("products",productDAO.list("name"));
		return new ModelAndView("orders/new_order",params);
	}
	
	/**
	 * Saves the order
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orders/save_orders.do",method = RequestMethod.POST)
	public ModelAndView saveOrder(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String dateStr = Utils.cleanString(request.getParameter("date"));
		String clientId = Utils.cleanString(request.getParameter("client"));
		String description =  Utils.cleanString(request.getParameter("description"));
		
		Map<String,Object> params = new HashMap<String, Object>();
			
		if(dateStr == null || clientId == null)
		{
			params.put("error","The date field and the client field are mandatory. Please, provide a date and select a client.");
			return new ModelAndView("orders/new_order",params); 
		}
		
		try
		{
			
			Order order = null;
			
			if(id != null)
			{
				order = orderDAO.get(Utils.getInteger(id).longValue());
			}
			else
			{
				order = new Order();
			}
			
			Date date = Utils.parseDate(dateStr);
			Client client = clientDAO.get(Utils.getInteger(clientId).longValue());
			
			order.setClient(client);
			order.setDate(date);
			order.setDescription(description);
			
			order = orderDAO.save(order);
			
			if(order != null && order.getId() != null)
			{
				params.put("success","Order number " + order.getId() + " registered successfully in the database.");
				params.put("order",order);
				params.put("clients",clientDAO.list("name"));
				params.put("products",productDAO.list("name"));
				return new ModelAndView("orders/new_order",params);
			}
			else
			{
				params.put("error","Error saving the order, please try again or contact the administrator.");
				return new ModelAndView("orders/new_order",params);
			}
			
		}
		catch (Exception ex)
		{
			log.error("saveOrder: error saving the order.",ex);
			params.put("error","Error saving the prder, please try again or contact the administrator.");
			return new ModelAndView("orders/new_order",params); 
		}
	}
	
	@RequestMapping(value = "orders/save_order_products.do",method = RequestMethod.GET)
	public ModelAndView saveOrderProducts(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String orderId = Utils.cleanString(request.getParameter("orderId"));
		String orderProductId = Utils.cleanString(request.getParameter("orderProductId"));
		String amount = Utils.cleanString(request.getParameter("amount"));
		String price = Utils.cleanString(request.getParameter("price"));
		String product = Utils.cleanString(request.getParameter("product"));
	
		try
		{
			Order order = orderDAO.get(Long.parseLong(orderId));
			
			if(order == null)
			{
				params.put("error","Error saving the Order, please try again or contact the administrator.");
				return new ModelAndView("orders/order_products",params);
			}
			
			OrderProduct op = null;
			
			if(orderProductId != null)
			{
				long longId= Long.parseLong(orderProductId);
				
				for(OrderProduct opo : order.getOrderProducts())
				{
					if(opo.getId() == longId)
					{
						op = opo;
						break;
					}
				}
				
			}
			
			if(op == null)
			{
				op = new OrderProduct();
			}
			
			op.setAmount(Utils.getInteger(amount).longValue());
			op.setOrder(order);
			op.setPrice(Utils.getDouble(price));
			op.setProduct(productDAO.get(Utils.getInteger(product).longValue()));
			
			if(orderProductId == null)
			{
				orderProductDAO.save(op);
			}
			else
			{
				order = orderDAO.save(order);
			}
			
			order = orderDAO.get(order.getId());
			
			params.put("products",productDAO.list("name"));
			params.put("order",order);
		}
		catch (Exception ex)
		{
			log.error("saveOrderProducts: error saving the order product.",ex);
			params.put("error","Error saving the Order, please try again or contact the administrator.");
		}
		return new ModelAndView("orders/order_products",params);
	}
	
	@RequestMapping(value = "orders/edit_order_products.do",method = RequestMethod.GET)
	public ModelAndView editOrderProducts(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			String id = Utils.cleanString(request.getParameter("id"));
			String orderId = Utils.cleanString(request.getParameter("order_id"));
			Order order = orderDAO.get(Long.parseLong(orderId));
				
			if(order == null)
			{
				params.put("error","Error editing the order, please try again or contact the administrator.");
				return new ModelAndView("orders/order_products",params);
			}
			
			OrderProduct op = orderProductDAO.get(Long.parseLong(id));
			
			if(op == null)
			{
				params.put("error","Error editing the order product, please try again or contact the administrator.");
				return new ModelAndView("orders/order_products",params);
			}
		
			params.put("order",order);
			params.put("products",productDAO.list("name"));
			params.put("orderProduct",op);
		}
		catch (Exception ex)
		{
			log.error("editOrderProducts: error editing the order product.",ex);
			params.put("error","Error saving the Order, please try again or contact the administrator.");
		}
			
		return new ModelAndView("orders/order_products",params);
	}
	
	/**
	 * Deletes a product from the order
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orders/delete_order_products.do",method = RequestMethod.GET)
	public ModelAndView deleteOrderProducts(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String orderId = Utils.cleanString(request.getParameter("order_id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		
		if(id != null && orderId != null)
		{
			OrderProduct op = orderProductDAO.get(Utils.getInteger(id).longValue());
			if(op != null)
			{
				orderProductDAO.delete(op);
				Order order = orderDAO.get(Utils.getInteger(orderId).longValue());
				if(order != null && order.getOrderProducts() != null)
				{
					params.put("order", order);
				}
			}
		}
		
		return new ModelAndView("orders/order_products",params);
	}
	
	/**
	 * Forwards to view order products
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orders/view_orders.do",method = RequestMethod.GET)
	public ModelAndView viewOrders(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		if(id != null)
		{
			try
			{
				Order order = orderDAO.get(Long.parseLong(id));
				params.put("order",order);
			}
			catch (Exception ex)
			{
				log.error("viewOrders: unable to retrieve order with the id " + id,ex);
				params.put("error","Internal Error, please try again.");
				return new ModelAndView("orders/index",params);
			}
		}
		else
		{
			params.put("error","Internal Error, please try again.");
			return new ModelAndView("orders/index",params);
		}
		
		return new ModelAndView("orders/view_orders",params);
	}
	
	@RequestMapping(value = "orders/delete_order.do",method = RequestMethod.GET)
	public ModelAndView deleteOrder(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		
		if(id != null)
		{
			Order order = orderDAO.get(Utils.getInteger(id).longValue());
			orderDAO.delete(order);
		}
		
		request.setAttribute("success","Order " + id  + " deleted sucessfully.");
		
		return index(request,response);
	}
	
	
}
