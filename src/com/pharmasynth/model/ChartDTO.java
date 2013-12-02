package com.pharmasynth.model;

import java.util.Date;

public class ChartDTO {

	private String label;
	private Double value;
	private Date date;
	private String xDimension;
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public Double getValue() {
		return value;
	}
	public void setValue(Double value) {
		this.value = value;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getxDimension() {
		return xDimension;
	}
	public void setxDimension(String xDimension) {
		this.xDimension = xDimension;
	}
	
	@Override
	public String toString() {
		return "ChartDTO [label=" + label + ", value=" + value + ", date="
				+ date + ", xDimension=" + xDimension + "]";
	}
}
