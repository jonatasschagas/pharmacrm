<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>


<script type="text/javascript">

$(function () {
    $('#client_sales_chart').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Client Sales'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.y} Euros</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '{point.name}: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Sales per Client',
            data: [
                <c:forEach var="item" items="${list}" varStatus="status2">
           			<c:if test="${status2.count > 1}">
               		,
           			</c:if>
					['${item.label}',${item.value}]
       			</c:forEach>
            ]
        }]
    });
});

</script>