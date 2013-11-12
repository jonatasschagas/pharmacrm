<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="reports" />
    <jsp:param name="sub" value="../" />
</jsp:include>
		
		<ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Reports
        	</li>
      	</ul>
		
		<div class="row">
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
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span8" style="margin:0 auto;float:none;">
            	<ul class="unstyled">
            		<li><a href="${path}/reports/clientSalesView.do">Client Sales</a> - Shows the percentage of orders per Client</li>
      				<li><a href="${path}/reports/clientProductsView.do">Client x Products</a> - Shows the Products ordered by a Client</li>
            		<li><a href="${path}/reports/productSalesView.do">Product Sales</a> - Shows the percentage of orders per Product</li>
            		<li><a href="${path}/reports/productClientsView.do">Product x Clients</a> - Shows the Clients who have purchased a particular Product</li>
            		<li><a href="${path}/reports/revenueView.do">Revenue</a> - Shows the Revenue over time</li>
            	</ul>
        	</div>
		</div>	
		
<jsp:include page="../footer.jsp" />