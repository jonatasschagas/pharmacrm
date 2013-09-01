package com.pharmasynth.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Currency;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public class Country {

	private String iso;
	private String code;
	private String name;
	private String currencyCode;
	
	private static Set<Country> countries;
	
	private static String [] europeUnionCountryCodes = {"FR","BE","LU","NL","DE","IT","GB","IE","DK","GR","PT","ES","SE","FI","AT","MT","HU","EE","CZ","LV","PL","CY","LT","SI","SK","BG","RO"};
	
	private Country(String iso, String code, String name,String currencyCode) {
		this.iso = iso;
		this.code = code;
		this.name = name;
		this.currencyCode = currencyCode;
	}
	
	public String getCurrencyCode(){
		return this.currencyCode;
	}
	
	public String getIso() {
		return iso;
	}
	public String getCode() {
		return code;
	}
	public String getName() {
		return name;
	}

	public String toString() {
		return name;
	}
	
	public static Set<Country> listCountries()
	{
		if(countries == null)
		{
			
			countries = new LinkedHashSet<Country>();
			List<Country> lc = new ArrayList<Country>();
			
			Locale[] locales = Locale.getAvailableLocales();
		    for (Locale locale : locales) {
		      String iso = locale.getISO3Country();
		      String code = locale.getCountry();
		      String name = locale.getDisplayCountry();
		      
		      if(!code.equals("") && !iso.equals(""))
		      {
		    	  Currency cur = Currency.getInstance(locale);
			      String currencyCode = cur.getCurrencyCode();
			      
			      if (!"".equals(iso) && !"".equals(code) && !"".equals(name) && !"".equals(currencyCode)) {
			    	  lc.add(new Country(iso, code, name,currencyCode));
			      }
		      }
		      
		    }
		    
		    Collections.sort(lc, new Comparator<Country>() {
		    	public int compare(Country o1, Country o2) {
		    		return o2.getName().compareTo(o1.getName());
		    	}
	      	});
		    
		    for(int i = lc.size()-1; i >= 0 ; i--)
		    {
		    	countries.add(lc.get(i));
		    }
		    
		}
		return countries;
	}
	
	public static Country getCountryByName(String countryName)
	{
		
		if(countryName == null)
		{
			return null;
		}
		
		if(countryName.contains("."))
		{
			countryName = countryName.replaceAll("\\.","");
		}
		for(Country c : listCountries())
		{
			if(c.getName().equals(countryName) || c.getName().contains(countryName) 
					|| c.getCode().equals(countryName) || c.getIso().contains(countryName))
			{
				return c;
			}
		}
		return null;
	}
	
	public static Country getCountryByCode(String countryCode)
	{
		for(Country c : listCountries())
		{
			if(c.getCode().equals(countryCode))
			{
				return c;
			}
		}
		return null;
	}
	
	public static Country getCountryByCurrencyCode(String countryCurrencyCode)
	{
		for(Country c : listCountries())
		{
			if(c.getCurrencyCode().equals(countryCurrencyCode))
			{
				return c;
			}
		}
		return null;
	}
	
	public static boolean isEUCountry(Country country)
	{
		for(String cc : europeUnionCountryCodes)
		{
			if(country.getCode().equals(cc))
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * returns the whole world except the countries in the list
	 * @param countries
	 * @return
	 */
	public static List<Country> excludeTheseCountries(List<Country> lExcludeCountries)
	{
		Set<Country> response = null;
		Map<String,Country> mapExcludeCountries = new HashMap<String, Country>();
		
		for(Country c : lExcludeCountries)
		{
			mapExcludeCountries.put(c.getCode(),c);
		}
		
		for(Country c : listCountries())
		{
			Country cEx = mapExcludeCountries.get(c.getCode());
			if(cEx == null)
			{
				// this means that this country shouldn't be removed
				if(response == null)
				{
					response = new HashSet<Country>();
				}
				response.add(c);
			}
		}
		
		List<Country> l = null;
		
		if(response != null)
		{
			for(Country c : response)
			{
				if(l == null)
				{
					l = new ArrayList<Country>();
				}
				
				l.add(c);
				
			}
		}
		
		return l;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((iso == null) ? 0 : iso.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Country other = (Country) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (iso == null) {
			if (other.iso != null)
				return false;
		} else if (!iso.equals(other.iso))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	
	
	
}
