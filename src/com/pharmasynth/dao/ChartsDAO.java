package com.pharmasynth.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.pharmasynth.model.ChartDTO;
import com.pharmasynth.model.Client;
import com.pharmasynth.model.Product;
import com.pharmasynth.util.Utils;

public class ChartsDAO {
	// 30 minutes
		public static final Integer DEFAULT_CACHE_SECONDS = 60 * 30 ;
		
		public static final Integer DEFAULT_CACHE_PARAMETERS_SECONDS = 60 * 60 * 1;
		public static final String PARAMETER_HOST = "host";
		public static final String PARAMETER_PORT = "port";
		public static final String PARAMETER_DBNAME = "dbname";
		public static final String PARAMETER_USER = "user";
		public static final String PARAMETER_PASSWORD = "password";
		
		private static Connection con;
		
		public ChartsDAO(){}

		private Logger log = Logger.getLogger(ChartsDAO.class);
		
		
		private Connection getConnection() throws Exception
		{
			if(con == null || con.isClosed())
			{
				Properties config = Utils.readProperties("pharma.properties");
				
				if(config == null)
				{
					throw new RuntimeException("Unable to load the configuration for the CRM database.");
				}
				
				String host = config.getProperty(PARAMETER_HOST);
				String port = config.getProperty(PARAMETER_PORT);
				String dbname = config.getProperty(PARAMETER_DBNAME);
				String user = config.getProperty(PARAMETER_USER);
				String password = config.getProperty(PARAMETER_PASSWORD);
				
				Class.forName("com.mysql.jdbc.Driver");
				con = null;
				con = DriverManager.getConnection("jdbc:mysql://"+host+":"+port+"/"+dbname,user, password); 
			}
			return con;
		}
		
		public List<ChartDTO> productsSales(Boolean allTimes, Date startDate, Date endDate,Client cl) throws Exception
		{
			List<ChartDTO> l = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				con = getConnection();
				
				String query = "select sum(op.price) as total, p.name as product_name from orders o, orders_products op, products p "
						+ " where o.id = op.order_id and op.product_id = p.id ";
				
				if(allTimes == false && startDate != null && endDate != null)
				{
					query += " and o.date between '"+Utils.formatDate(startDate)+"' and '"+Utils.formatDate(endDate)+"' ";
				}
				
				if(cl != null)
				{
					query += " and o.client_id = " + cl.getId() + " ";
				}
				
				query += " group by 2 order by 1 desc";
				
				rs = con.prepareStatement(query).executeQuery();
				
				while(rs.next())
				{
					if(l == null)
					{
						l = new ArrayList<ChartDTO>();					
					}
					

					ChartDTO c = new ChartDTO();
					c.setLabel(rs.getString("product_name"));
					c.setValue(rs.getDouble("total"));
					
					l.add(c);
				}			
				
			}
			catch (Exception ex)
			{
				log.error("productsSales: error listing product sales. Start Date " + startDate + ", End Date " + endDate + "" ,ex);
			}
			finally {
	            try
	            {
	                if(rs != null && !rs.isClosed())
	                {
	                    try {rs.close(); } catch(Exception e){}
	                }

	                if(pstmt != null && !pstmt.isClosed())
	                {
	                    try {pstmt.close(); } catch(Exception e){}
	                }

	            } catch(Exception ex) {}
		    }
			return l;
		}
		
		public List<ChartDTO> revenueTime(Boolean allTimes, Date startDate, Date endDate) throws Exception
		{
			List<ChartDTO> l = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				con = getConnection();
				
				String query = "select sum(op.price) as sales, CONCAT(MONTHNAME(o.date),'-',YEAR(o.date)) as date from orders_products op, orders o "
						+ " where op.order_id = o.id ";
				
				if(allTimes == false && startDate != null && endDate != null)
				{
					query += " and o.date between '"+Utils.formatDate(startDate)+"' and '"+Utils.formatDate(endDate)+"' ";
				}
				
				query += " group by 2 order by o.date asc";
				
				rs = con.prepareStatement(query).executeQuery();
				
				while(rs.next())
				{
					if(l == null)
					{
						l = new ArrayList<ChartDTO>();					
					}
					

					ChartDTO c = new ChartDTO();
					c.setxDimension(rs.getString("date"));
					c.setValue(rs.getDouble("sales"));
					
					l.add(c);
				}			
				
			}
			catch (Exception ex)
			{
				log.error("revenueTime: error listing revenue. Start Date " + startDate + ", End Date " + endDate + "" ,ex);
			}
			finally {
	            try
	            {
	                if(rs != null && !rs.isClosed())
	                {
	                    try {rs.close(); } catch(Exception e){}
	                }

	                if(pstmt != null && !pstmt.isClosed())
	                {
	                    try {pstmt.close(); } catch(Exception e){}
	                }

	            } catch(Exception ex) {}
		    }
			return l;
		}
		
		public List<ChartDTO> clientSales(Boolean allTimes, Date startDate, Date endDate, Product p) throws Exception
		{
			List<ChartDTO> l = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				con = getConnection();
				
				String query = "select sum(op.price) as sales, c.name client_name from orders_products op, orders o, clients c"
						+ " where op.order_id = o.id and o.client_id = c.id ";
				
				if(allTimes == false && startDate != null && endDate != null)
				{
					query += " and o.date between '"+Utils.formatDate(startDate)+"' and '"+Utils.formatDate(endDate)+"' ";
				}
				
				if(p != null)
				{
					query += " and op.product_id = " + p.getId() + " ";
				}
				
				query += " group by 2 order by 1 desc";
				
				rs = con.prepareStatement(query).executeQuery();
				
				while(rs.next())
				{
					if(l == null)
					{
						l = new ArrayList<ChartDTO>();					
					}
					

					ChartDTO c = new ChartDTO();
					c.setLabel(rs.getString("client_name"));
					c.setValue(rs.getDouble("sales"));
					
					l.add(c);
				}			
				
			}
			catch (Exception ex)
			{
				log.error("clientSales: error listing client sales. Start Date " + startDate + ", End Date " + endDate + "" ,ex);
			}
			finally {
	            try
	            {
	                if(rs != null && !rs.isClosed())
	                {
	                    try {rs.close(); } catch(Exception e){}
	                }

	                if(pstmt != null && !pstmt.isClosed())
	                {
	                    try {pstmt.close(); } catch(Exception e){}
	                }

	            } catch(Exception ex) {}
		    }
			return l;
		}
		
		public List<ChartDTO> clientRevenueTime(Boolean allTimes, Date startDate, Date endDate, Client cl) throws Exception
		{
			List<ChartDTO> l = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				con = getConnection();
				
				String query = "select sum(op.price) as sales, o.date as date, c.name as client_name "
						+ "from orders_products op, orders o, clients c "
						+ "where op.order_id = o.id and o.client_id = c.id ";
				
				if(allTimes == false && startDate != null && endDate != null)
				{
					query += " and o.date between '"+Utils.formatDate(startDate)+"' and '"+Utils.formatDate(endDate)+"' ";
				}
				
				if(cl != null)
				{
					query += " and o.client_id = " + cl.getId() + " ";
				}
				
				query += "group by 2,3 order by 2 asc";
				
				rs = con.prepareStatement(query).executeQuery();
				
				while(rs.next())
				{
					if(l == null)
					{
						l = new ArrayList<ChartDTO>();					
					}
					

					ChartDTO c = new ChartDTO();
					c.setLabel(rs.getString("client_name"));
					c.setValue(rs.getDouble("sales"));
					c.setDate(rs.getDate("date"));
					
					l.add(c);
				}			
				
			}
			catch (Exception ex)
			{
				log.error("clientRevenueTime: error listing client revenue . Start Date " + startDate + ", End Date " + endDate + "" ,ex);
			}
			finally {
	            try
	            {
	                if(rs != null && !rs.isClosed())
	                {
	                    try {rs.close(); } catch(Exception e){}
	                }

	                if(pstmt != null && !pstmt.isClosed())
	                {
	                    try {pstmt.close(); } catch(Exception e){}
	                }

	            } catch(Exception ex) {}
		    }
			return l;
		}
		
		public List<ChartDTO> productRevenueTime(Boolean allTimes, Date startDate, Date endDate, Product p) throws Exception
		{
			List<ChartDTO> l = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try
			{
				con = getConnection();
				
				String query = "select sum(op.price) as sales, o.date as date, p.name as product_name "
						+ "from orders_products op, orders o, products p "
						+ "where op.order_id = o.id and op.product_id = p.id ";
				
				if(allTimes == false && startDate != null && endDate != null)
				{
					query += " and o.date between '"+Utils.formatDate(startDate)+"' and '"+Utils.formatDate(endDate)+"' ";
				}
				
				if(p != null)
				{
					query += " and o.product_id = " + p.getId() + " ";
				}
				
				query += "group by 2,3 order by 2 asc";
				
				rs = con.prepareStatement(query).executeQuery();
				
				while(rs.next())
				{
					if(l == null)
					{
						l = new ArrayList<ChartDTO>();					
					}
					

					ChartDTO c = new ChartDTO();
					c.setLabel(rs.getString("product_name"));
					c.setValue(rs.getDouble("sales"));
					c.setDate(rs.getDate("date"));
					
					l.add(c);
				}			
				
			}
			catch (Exception ex)
			{
				log.error("productRevenueTime: error listing product revenue . Start Date " + startDate + ", End Date " + endDate + "" ,ex);
			}
			finally {
	            try
	            {
	                if(rs != null && !rs.isClosed())
	                {
	                    try {rs.close(); } catch(Exception e){}
	                }

	                if(pstmt != null && !pstmt.isClosed())
	                {
	                    try {pstmt.close(); } catch(Exception e){}
	                }

	            } catch(Exception ex) {}
		    }
			return l;
		}
}
