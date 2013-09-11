	package com.pharmasynth.web;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.pharmasynth.dao.ApplicationDAO;
import com.pharmasynth.dao.CaseStudyDAO;
import com.pharmasynth.dao.ProductDAO;
import com.pharmasynth.model.Application;
import com.pharmasynth.model.CaseStudy;
import com.pharmasynth.model.Product;
import com.pharmasynth.util.Utils;

@Controller
public class ProductController extends MultiActionController
{
	private static Logger log = Logger.getLogger(ProductController.class);
	
	//public static final String FOLDER_PRODUCTS = "/products/";
	public static final String FOLDER_PRODUCTS = "C:/products/";
	//public static final String FOLDER_PRODUCTS = "/case_studies/";
	public static final String FOLDER_CASE_STUDIES = "C:/case_studies/";
	
	
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private CaseStudyDAO caseStudyDAO;
	@Autowired
	private ApplicationDAO applicationDAO;
	
	/**
	 * Forwards to index view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/index.do",method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String typeSearch = Utils.cleanString(request.getParameter("typeSearch"));
		String searchQuery = Utils.cleanString(request.getParameter("searchQuery"));
		String orderBy = Utils.cleanString(request.getParameter("orderBy"));
		
		if(orderBy == null)
		{
			orderBy = "id";
		}
		
		List<Product> list = null;
		if(typeSearch != null && searchQuery != null)
		{
			if(typeSearch.equalsIgnoreCase("name"))
			{
				list = productDAO.findByName(searchQuery,orderBy);
			} 
			else if(typeSearch.equalsIgnoreCase("Application"))
			{
				Set<Product> setProducts = new HashSet<Product>();
				List<Application> lApplications = applicationDAO.findByName(searchQuery);
				
				if(lApplications != null && lApplications.size() > 0)
				{
					for(Application a : lApplications)
					{
						setProducts.add(a.getProduct());
					}
				}
				
				if(setProducts.size() > 0)
				{
					list = new ArrayList<Product>();
					
					for(Product pr : setProducts)
					{
						list.add(pr);
					}
				}
				
			}
			else if(typeSearch.equalsIgnoreCase("all"))
			{
				list = productDAO.findByAll(searchQuery,orderBy);
			}
			
			params.put("typeSearch",typeSearch);
			params.put("searchQuery",searchQuery);
			
		}
		else
		{
			list = productDAO.list(orderBy);
		}
		
		params.put("orderBy",orderBy);
		params.put("products",Utils.paginate(request, list));
		params.put("numberOfPages",Utils.getNumberOfPages(list));
		params.put("currentPage",Utils.getCurrentPage(request));
		
		return new ModelAndView("products/index",params);
	}
	
	/**
	 * Forwards to new product view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/new_product.do",method = RequestMethod.GET)
	public ModelAndView newProduct(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		
		if(id != null)
		{
			try
			{
				Product p = productDAO.get(Long.parseLong(id));
				params.put("product",p);
			}
			catch (Exception ex)
			{
				log.error("newProduct: unable to retrieve user with the id " + id,ex);
			}
		}
		
		return new ModelAndView("products/new_product",params);
	}
	
	/**
	 * Forwards to view products view
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/view_product.do",method = RequestMethod.GET)
	public ModelAndView viewProduct(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		if(id != null)
		{
			try
			{
				Product p = productDAO.get(Long.parseLong(id));
				params.put("product",p);
			}
			catch (Exception ex)
			{
				log.error("viewProduct: unable to retrieve user with the id " + id,ex);
				params.put("error","Internal Error, please try again.");
				return new ModelAndView("products/index",params);
			}
		}
		else
		{
			params.put("error","Internal Error, please try again.");
			return new ModelAndView("products/index",params);
		}
		
		return new ModelAndView("products/view_product",params);
	}
	
	/**
	 * Deletes a case study from the product
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/delete_case_study.do",method = RequestMethod.GET)
	public ModelAndView deleteCaseStudy(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String productId = Utils.cleanString(request.getParameter("product_id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		
		if(id != null && productId != null)
		{
			CaseStudy c = caseStudyDAO.get(Utils.getInteger(id).longValue());
			if(c != null)
			{
				caseStudyDAO.delete(c);
				Product p = productDAO.get(Utils.getInteger(productId).longValue());
				if(p != null && p.getCaseStudies() != null)
				{
					params.put("product", p);
				}
			}
		}
		
		return new ModelAndView("products/case_studies",params);
	}
	
	/**
	 * Deletes an application from the product
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/delete_application.do",method = RequestMethod.GET)
	public ModelAndView deleteApplication(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		String productId = Utils.cleanString(request.getParameter("product_id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		
		if(id != null && productId != null)
		{
			Application a = applicationDAO.get(Utils.getInteger(id).longValue());
			if(a != null)
			{
				applicationDAO.delete(a);
				Product p = productDAO.get(Utils.getInteger(productId).longValue());
				if(p != null && p.getCaseStudies() != null)
				{
					params.put("product", p);
				}
			}
		}
		
		return new ModelAndView("products/applications",params);
	}
	
	@RequestMapping(value = "products/delete_product.do",method = RequestMethod.GET)
	public ModelAndView deleteProduct(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		String id = Utils.cleanString(request.getParameter("id"));
		
		Map<String,Object> params = new HashMap<String, Object>();
		String name = null;
		if(id != null)
		{
			Product p = productDAO.get(Utils.getInteger(id).longValue());
			name = p.getName();
			productDAO.delete(p);
		}
		
		params.put("success","Product " + name  + " deleted sucessfully.");
		
		return index(request, response);
	}
	
	
	/**
	 * Saves the product
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "products/save_product.do",method = RequestMethod.POST)
	public ModelAndView saveClient(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		Map<String,String> parameters = new HashMap<String,String>();
		
		FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        byte[] fileByteData = null; 
        
        try {
            
            List<FileItem> fields = upload.parseRequest(request);
            
            for(FileItem fi : fields)
            {
                boolean isFormField = fi.isFormField();

                if (isFormField)
                {
                    parameters.put(fi.getFieldName(),fi.getString());
                }
                else
                {
                	fileByteData = fi.get();
                }
            }
            
            String id = Utils.cleanString(parameters.get("id"));
    		String name = Utils.cleanString(parameters.get("name"));
    		String type = Utils.cleanString(parameters.get("type"));
    		String inStock = Utils.cleanString(parameters.get("inStock"));
    		String price = Utils.cleanString(parameters.get("price"));
    		String productId = Utils.cleanString(parameters.get("productIdPH"));
    		String productionYear = Utils.cleanString(parameters.get("productionYear"));
    		String cas = Utils.cleanString(parameters.get("cas"));
    		String description = Utils.cleanString(parameters.get("description"));
    		String structurePath = null;
    		
    		if(fileByteData != null)
            {
    			File file = new File(FOLDER_PRODUCTS + name);
        		
    			if(file.exists())
                {
                    file.delete();
                }

                // write file to temp directory
                FileOutputStream fos = new FileOutputStream(file);
                fos.write(fileByteData);
                fos.close();
                
                structurePath = file.getPath();
            }
            
    	    Product p = null;
			
			if(id != null)
			{
				p = productDAO.get(Utils.getInteger(id).longValue());
			}
			else
			{
				p = new Product();
			}
			
			p.setCas(cas);
			p.setDescription(description);
			p.setInStock(inStock);
			p.setName(name);
			p.setPrice(price);
			p.setProductIdPH(productId);
			p.setProductionYear(productionYear);
			p.setProductType(type);
			
			if(structurePath != null)
			{
				p.setStructurePath(structurePath);
			}
			
			p = productDAO.save(p);
			
			if(p != null && p.getId() != null)
			{
				params.put("success","Product " + p.getName() + " registered successfully in the database.");
				return index(request, response);
			}
			else
			{
				params.put("error","Error saving the product, please try again or contact the administrator.");
				return new ModelAndView("products/new_product",params);
			}
    	    
        }
        catch (Exception ex)
        {
        	log.error("saveProduct: error saving the product",ex);
        	params.put("error","Unable to save the product. Please, try again.");
			return new ModelAndView("products/new_product",params);
        }
	}
	
	@RequestMapping(value = "products/edit_case_study.do",method = RequestMethod.GET)
	public ModelAndView editCaseStudy(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			String id = Utils.cleanString(request.getParameter("id"));
			String productId = Utils.cleanString(request.getParameter("product_id"));
			Product p = productDAO.get(Long.parseLong(productId));
				
			if(p == null)
			{
				params.put("error","Error editing the case study, please try again or contact the administrator.");
				return new ModelAndView("products/case_studies",params);
			}
			
			CaseStudy c = caseStudyDAO.get(Long.parseLong(id));
			
			if(c == null)
			{
				params.put("error","Error editing the case study, please try again or contact the administrator.");
				return new ModelAndView("products/case_studies",params);
			}
		
			params.put("product",p);
			params.put("caseStudy",c);
		}
		catch (Exception ex)
		{
			log.error("editCaseStudy: error editing the case study.",ex);
			params.put("error","Error saving the Case Study, please try again or contact the administrator.");
		}
			
		return new ModelAndView("products/case_studies",params);
	}
	
	@RequestMapping(value = "products/edit_application.do",method = RequestMethod.GET)
	public ModelAndView editApplication(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		Map<String,Object> params = new HashMap<String, Object>();
		try
		{
			String id = Utils.cleanString(request.getParameter("id"));
			String productId = Utils.cleanString(request.getParameter("product_id"));
			Product p = productDAO.get(Long.parseLong(productId));
				
			if(p == null)
			{
				params.put("error","Error editing the application, please try again or contact the administrator.");
				return new ModelAndView("products/applications",params);
			}
			
			Application a = applicationDAO.get(Long.parseLong(id));
			
			if(a == null)
			{
				params.put("error","Error editing the application, please try again or contact the administrator.");
				return new ModelAndView("products/applications",params);
			}
		
			params.put("product",p);
			params.put("application",a);
		}
		catch (Exception ex)
		{
			log.error("editApplication: error editing the application.",ex);
			params.put("error","Error saving the Application, please try again or contact the administrator.");
		}
			
		return new ModelAndView("products/applications",params);
	}
	
	@RequestMapping(value = "products/save_case_study.do",method = RequestMethod.POST)
	public ModelAndView saveCaseStudy(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		Map<String,String> parameters = new HashMap<String,String>();
		
		FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        byte[] fileByteData = null; 
        
        try {
            
            List<FileItem> fields = upload.parseRequest(request);
            
            for(FileItem fi : fields)
            {
                boolean isFormField = fi.isFormField();

                if (isFormField)
                {
                    parameters.put(fi.getFieldName(),fi.getString());
                }
                else
                {
                	fileByteData = fi.get();
                }
            }
            
            String id = Utils.cleanString(parameters.get("caseStudyId"));
            String productId = Utils.cleanString(parameters.get("productId"));
            String name = Utils.cleanString(parameters.get("caseStudy_name"));
    		String link = Utils.cleanString(parameters.get("caseStudy_link"));
    		String filePath = null;
    		
    		if(fileByteData != null)
            {
    			File file = new File(FOLDER_CASE_STUDIES + name);
        		
    			if(file.exists())
                {
                    file.delete();
                }

                // write file to temp directory
                FileOutputStream fos = new FileOutputStream(file);
                fos.write(fileByteData);
                fos.close();
                
                filePath = file.getPath();
            }
            
    	    CaseStudy c = null;
    	    Product p = productDAO.get(Long.parseLong(productId));
			
			if(id != null)
			{
				c = caseStudyDAO.get(Utils.getInteger(id).longValue());
			}
			else
			{
				c = new CaseStudy();
			}
			
			c.setLink(link);
			c.setName(name);
			c.setProduct(p);
			
			if(filePath != null)
			{
				c.setFilePath(filePath);
			}
			
			c = caseStudyDAO.save(c);
			
			if(c != null && c.getId() != null)
			{
				params.put("success","Case Study " + p.getName() + " registered successfully in the database.");
				return index(request, response);
			}
			else
			{
				params.put("error","Error saving the case study, please try again or contact the administrator.");
				return new ModelAndView("products/new_product",params);
			}
    	    
        }
        catch (Exception ex)
        {
        	log.error("saveCaseStudy: error saving the case study",ex);
        	params.put("error","Unable to save the case study. Please, try again.");
			return new ModelAndView("products/new_product",params);
        }
	}
	
	@RequestMapping(value = "products/save_application.do",method = RequestMethod.GET)
	public ModelAndView saveApplication(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		Map<String,Object> params = new HashMap<String, Object>();
		
		String id = Utils.cleanString(request.getParameter("id"));
		String productId = Utils.cleanString(request.getParameter("product_id"));
		String name = Utils.cleanString(request.getParameter("name"));
		String category = Utils.cleanString(request.getParameter("category"));
		
		try
		{
			Product p = productDAO.get(Long.parseLong(productId));
			
			if(p == null)
			{
				params.put("error","Error saving the Product, please try again or contact the administrator.");
				return new ModelAndView("products/applications",params);
			}
			
			Application a = null;
			
			if(id != null)
			{
				long longId= Long.parseLong(id);
				
				for(Application app : p.getApplications())
				{
					if(app.getId() == longId)
					{
						a = app;
						break;
					}
				}
				
			}
			
			if(a == null)
			{
				a = new Application();
			}
			
			a.setCategory(category);
			a.setName(name);
			a.setProduct(p);
			
			if(id == null)
			{
				applicationDAO.save(a);
			}
			else
			{
				p = productDAO.save(p);
			}
			
			p = productDAO.get(p.getId());
			
			params.put("product",p);
		}
		catch (Exception ex)
		{
			log.error("saveApplication: error saving the application.",ex);
			params.put("error","Error saving the Application, please try again or contact the administrator.");
		}
		return new ModelAndView("products/applications",params);
	}
	
}
