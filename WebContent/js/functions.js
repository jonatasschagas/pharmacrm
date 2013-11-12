function createChart(containerId,data)
{
	var jsonData = jQuery.parseJSON(data);
	
    if(jsonData == null || jsonData.error)
	{
    	   var message = "No data available";
    	   
    	   if(jsonData.error != null)
		   {
    		   message = jsonData.error;
		   }
    	
    	   $("#" + containerId).html(message);
           
    	   return;
	}

    var chartElementId = jsonData.chart.renderTo;
	
    if(jsonData.series[0] == null || jsonData.series[0]["data"] == null)
   	{
    	var message = "No data available";
    	   
    	   if(jsonData.error != null)
		   {
    		   message = jsonData.error;
		   }
    	
    	   $("#" + containerId).html(message);
        
    	return;
   	}
    
    var chartObj = new Highcharts.Chart(jsonData);
    
   
    
}