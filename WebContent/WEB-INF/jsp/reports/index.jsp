<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="reports" />
    <jsp:param name="sub" value="../" />
</jsp:include>
		
		<!-- <ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Reports
        	</li>
      	</ul> -->
		
		<div class="well">
			<div class="row-fluid">
				<div class="span12">
					<table border="0" style="width:100%;">
		            	<tr>
		              		<td style="width:20%;">
		                		<table border="0" style="width:100%;">
		                  			<tr>
		                    			<td align="center">
		                    				<img src="${path}/img/reports.png" width="80">
		                    			</td>
		                    			<td>
		                    				<h3>Reports</h3>
		                    			</td>
		                    			<td style="width:80%;">
		                    			</td>
		                  			</tr>
		                		</table>
		              		</td>
		            	</tr>
	          		</table>
				</div>
			</div>
			<hr/>
			<div class="row-fluid">
	         	<div class="span4">
	            	<ul class="nav nav-tabs nav-stacked">
	            	 	<li><a href="${path}/reports/clientSalesView.do" id="clientSalesView" data-trigger="hover" data-toggle="popover" data-placement="right" 
	            	  	data-content="Shows the percentage of orders per Client" data-title="Client Sales" >Client Sales</a></li>
		              	<li><a href="${path}/reports/clientProductsView.do" id="clientProductsView" data-toggle="popover" data-placement="right"
		              	data-content="Shows the Products ordered by a Client" data-title="Client x Products">Client x Products</a></li>
	            		<li><a href="${path}/reports/productSalesView.do" id="productSalesView" data-toggle="popover" data-placement="right"
	            		data-content="Shows the percentage of orders per Product" data-title="Product Sales">Product Sales</a></li>
	            		<li><a href="${path}/reports/productClientsView.do" id="productClientsView" data-toggle="popover" data-placement="right"
	            		data-content="Shows the Clients who have purchased a particular Product" data-title="Product x Clients">Product x Clients</a></li>
	            		<li><a href="${path}/reports/revenueView.do" id="revenueView" data-toggle="popover" data-placement="right"
	            		data-content="Shows the Revenue over time" data-title="Revenue">Revenue</a></li>
		            </ul>
	        	</div>
			</div>	
      	</div>
		
		
		
		<script>
			$("#clientSalesView").popover({ trigger: "hover" });
			$("#clientProductsView").popover({ trigger: "hover" });
			$("#productSalesView").popover({ trigger: "hover" });
			$("#productClientsView").popover({ trigger: "hover" });
			$("#revenueView").popover({ trigger: "hover" });
		</script>
		
<jsp:include page="../footer.jsp" />