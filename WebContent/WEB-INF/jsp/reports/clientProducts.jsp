<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<script type="text/javascript">

	$(function () {
	    $('#client_products_charts').highcharts({
	        chart: {
	            type: 'column',
	            margin: [ 50, 50, 250, 80]
	        },
	        title: {
	            text: 'Products that have been ordered by ${client.name}'
	        },
	        xAxis: {
	            categories: [
					<c:forEach var="item" items="${list}" varStatus="status">
					<c:if test="${status.count > 1}">
						,
					</c:if>
					'${item.label}'
					</c:forEach>
	            ],
	            labels: {
	                rotation: -45,
	                align: 'right',
	                style: {
	                    fontSize: '13px',
	                    fontFamily: 'Verdana, sans-serif'
	                }
	            }
	        },
	        yAxis: {
	            title: {
	                text: 'Product Sales (Euros)'
	            },
	            <c:set var="lastValue" value="0" />
	            <c:forEach var="item" items="${list}" varStatus="status">
	              	<c:if test="${item.value < lastValue || lastValue == 0}">
	                  	<c:set var="lastValue" value="${item.value}" />
	              	</c:if>
	          	</c:forEach>
	            min :<fmt:formatNumber type="number" pattern="###" value="${lastValue}" />
	        },
	        legend: {
	            enabled: false
	        },
	        tooltip: {
	            pointFormat: 'Product Sales: <b>{point.y} Euros</b>',
	        },
	        series: [{
	            name: 'Sales',
	            data: [
	                   
	                   <c:forEach var="item" items="${list}" varStatus="status">
			               	<c:if test="${status.count > 1}">
			                   	,
			               	</c:if>
			               	<fmt:formatNumber type="number" pattern="###" value="${item.value}" />
			           </c:forEach>
	                   
	                   ],
	            dataLabels: {
	                enabled: true,
	                rotation: -90,
	                color: '#FFFFFF',
	                align: 'right',
	                x: 4,
	                y: 10,
	                style: {
	                    fontSize: '13px',
	                    fontFamily: 'Verdana, sans-serif',
	                    textShadow: '0 0 3px black'
	                }
	            }
	        }]
	    });
	});

</script>