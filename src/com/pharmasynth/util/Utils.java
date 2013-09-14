package com.pharmasynth.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class Utils {
	
	private static Logger logger = Logger.getLogger(Utils.class);
	private static SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat timestampFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	public static final int PAGE_SIZE = 8;
	
	private static String environment = null;
	
	public static Date parseDate(String date) throws Exception
	{
		return date != null ? dateFormatter.parse(date) : null;
	}
	
	public static String formatDate(Date date) throws Exception
	{
		return date != null ? dateFormatter.format(date) : null;
	}
	
	public static Date parseTimestamp(String date) throws Exception
	{
		return date != null ? timestampFormatter.parse(date) : null;
	}
			
	public static String cleanString(String string)
	{
		return string == null || string.equals("") || string.equals(" ") ? null : string;
	}
	
	public static Integer getInteger(String numberStr)
	{
		try
		{
			return Integer.parseInt(numberStr);
		}
		catch (Exception ex)
		{}
		return null;
	}
	
	public static Double getDouble(String numberStr)
	{
		try
		{
			return Double.parseDouble(numberStr);
		}
		catch (Exception ex)
		{}
		return null;
	}
	
	/**
	 * Reads the content of a text-file
	 * @param path
	 * @return
	 * @throws IOException
	 */
	public static String readFile(String path) throws IOException {
        FileInputStream stream = new FileInputStream(new File(path));
        try {
                FileChannel fc = stream.getChannel();
            MappedByteBuffer bb = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
            /* Instead of using default, pass in a decoder. */
            return Charset.defaultCharset().decode(bb).toString();
        }
        finally {
                stream.close();
        }
   }
	
	/**
	 * This method reads the properties file from the conf/ directory and
	 * returns the object containing the properties
	 * @return
	 */
	public static Properties readProperties(String fileName)
	{
		Properties connectionConfigProps = null;
		
        try
        {
            InputStream resourceAsStream = Utils.class.getClassLoader().getResourceAsStream(fileName);
            if (resourceAsStream == null)
            {
                throw new IllegalArgumentException("FATAL: Could not find file " + fileName);
            }
       
            connectionConfigProps = new Properties();
            connectionConfigProps.load(resourceAsStream);
            
            logger.debug("loadDBconfigFile : config file loaded successfully. File Name: " + fileName);
            
        }
        catch(Exception e)
        {
        	logger.error("loadDBconfigFile : Unable to load the db config file ",e);
        }
		return connectionConfigProps;
	}
	
	public static List<String> getExcelColumns()
    {
        List<String> cols = new ArrayList<String>();
        
        cols.add("A");
        cols.add("B");
        cols.add("C");
        cols.add("D");
        cols.add("E");
        cols.add("F");
        cols.add("G");
        cols.add("H");
        cols.add("I");
        cols.add("J");
        cols.add("K");
        cols.add("L");
        cols.add("M");
        cols.add("N");
        cols.add("O");
        cols.add("P");
        cols.add("Q");
        cols.add("R");
        cols.add("S");
        cols.add("T");
        cols.add("U");
        cols.add("V");
        cols.add("X");
        cols.add("Z");
        
        return cols;        
    }
    
	public static Boolean isDev()
	{
		try
		{
			if(environment == null)
			{
				environment = readFile("/supercell/environment.name");
			}
			
			if(environment != null && environment.contains("dev"))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		catch (Exception ex)
		{}
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public static <T extends Comparable> List<T> asSortedList(Collection<T> collection) {
	  T[] array = collection.toArray(
	    (T[])new Comparable[collection.size()]);
	  Arrays.sort(array);
	  return Arrays.asList(array);
	}
	
	public static List paginate(HttpServletRequest request, List list)
	{
		try
		{
			String selectedPage = cleanString(request.getParameter("page"));
			Integer selectedPageNumber = 0;
			
			if(selectedPage == null)
			{
				return list.subList(0,PAGE_SIZE);
			}
			else
			{
				selectedPageNumber = Integer.parseInt(selectedPage);
				
				Integer start = selectedPageNumber * PAGE_SIZE;
				Integer end = selectedPageNumber * PAGE_SIZE + PAGE_SIZE;
				
				if(end > list.size())
				{
					end = list.size();
				}
				
				return list.subList(start,end);
			}
		}
		catch (Exception ex) {}
		return list;
	}
	
	public static Integer getCurrentPage(HttpServletRequest request)
	{
		try
		{
			String selectedPage = cleanString(request.getParameter("page"));
			Integer selectedPageNumber = 0;
			
			if(selectedPage == null)
			{
				return 0;
			}
			else
			{
				return Integer.parseInt(selectedPage);
			}
		}
		catch (Exception ex) {}
		return 0;
	}
	
	public static Integer getNumberOfPages(List list)
	{
		return list != null ? list.size() / PAGE_SIZE : 0;
	}
	
	public static File getFile(String path) throws Exception
	{
		return new File(path);
	}
	
	public static String pathToURL(String path)
	{
		try
		{
			File f = new File(path);
			return f.toURI().toString();
		}
		catch (Exception ex){}
		return null;
	}
	
}
