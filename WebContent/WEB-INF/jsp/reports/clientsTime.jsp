<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<script type="text/javascript">

$(function () {
    $('#clients_time_chart').highcharts({
    	chart: {
            type: 'spline'
        },
        title: {
            text: 'Revenue',
            x: -20 //center
        },
        xAxis: {
            type : 'datetime',
            dateTimeLabelFormats: 
           	{ 
             	month: '%e. %b',
               	year: '%b'
       		}
        },
        yAxis: {
            title: {
                text: 'Revenue (Euros)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        exporting :
        {
        	enabled : true	
        },
        tooltip: {
            valueSuffix: '(Euros)'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [
                 
                 <c:forEach var="item" items="${mp}" varStatus="status">
     				<c:if test="${status.count > 1}">
         				,
     				</c:if>
 					[${item.date.getTime()},${item.value}]
 				</c:forEach>
        
                 
                 {
            name: 'Revenue',
            data: 
           	[
            <c:forEach var="item" items="${list}" varStatus="status">
    			<c:if test="${status.count > 1}">
        			,
    			</c:if>
				[${item.date.getTime()},${item.value}]
			</c:forEach>
        	]
        }]
    });
});

</script>