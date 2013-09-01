package com.pharmasynth.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Class responsible for handling the security 
 * @author jonataschagas
 *
 */
public class LoginFilter  implements Filter
{

    private Logger log = Logger.getLogger(LoginFilter.class);

    
    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {
        
        try
        {
           HttpServletRequest request = (HttpServletRequest) req;
           
           String path = "http://localhost:8081/pharmacrm/";
            
            // argh... got to find a fix for this...
           request.setAttribute("path",path);
            
           String url = request.getRequestURI();
            
           if(isLoggedIn(request) || url.contains(".css") 
        		   || url.contains(".js") || url.contains("img")
        		   || url.contains("images") || url.contains(".png")
        		   || url.contains("jpg")
        		   || url.contains("less"))
           {
        	   chain.doFilter(req, res);    
           }
            // argh nr 2: this is terrible, but is the only way to send the user
            // to a decent place if the types a wrong url.
            else if(!url.contains(".do"))
            {
            	((HttpServletResponse)res).sendRedirect(path + "index.do");
            }
            else
            {
                if(!url.contains("login"))
                {
                	req.setAttribute("url",getFullURL(request));
                	request.getRequestDispatcher("/login.do").forward(req,res);
                }
                else
                {
                    chain.doFilter(req,res);
                }
            }
            
        }
        catch(Exception ex)
        {
            log.error("error in login filter",ex);
        }
    }
    
    private String getFullURL(HttpServletRequest request) {
        StringBuffer requestURL = request.getRequestURL();
        String queryString = request.getQueryString();

        if (queryString == null) {
            return requestURL.toString();
        } else {
            return requestURL.append('?').append(queryString).toString();
        }
    }
    
    private boolean isLoggedIn(HttpServletRequest request) throws Exception
    {
        String loggedIn = (String)request.getSession().getAttribute("logged_in");
        return loggedIn != null && loggedIn.equals("true");
    }

    public void destroy() { }

}
