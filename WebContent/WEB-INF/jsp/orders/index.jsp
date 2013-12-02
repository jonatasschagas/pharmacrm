<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="orders" />
    <jsp:param name="sub" value="../" />
</jsp:include>
		
		<!-- <ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Orders
        	</li>
      	</ul> -->
		
		<div class="row">
        	<table border="0" style="width:100%;">
            	<tr>
              		<td style="width:20%;">
                		<table border="0" style="width:100%;">
                  			<tr>
                    			<td align="center">
                    				<img src="${path}/img/orders.png" width="80">
                    			</td>
                    			<td>
                    				<h3>Orders</h3>
                    			</td>
                  			</tr>
                		</table>
              		</td>
              		<td style="width:80%;">
                		<a class="btn btn-primary pull-right" href="${path}/orders/new_order.do">New Order</a>
              		</td>
            	</tr>
          	</table>
      	</div>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span8" style="margin:0 auto;float:none;">
            	<form class="form-horizontal" name="searchForm" method="GET" action="${path}/orders/index.do">
              		<input type="hidden" name="queryAction" id="queryAction" value="new_search" />
              		<div class="control-group">
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="clientName" value="clientName" <c:if test="${typeSearch == 'clientName'}">checked</c:if>>
                  			Client Name
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="country" value="country" <c:if test="${typeSearch == 'country'}">checked</c:if>>
                  			Country
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="product" value="product" <c:if test="${typeSearch == 'product'}">checked</c:if>>
                  			Product
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="all" value="all" <c:if test="${typeSearch == 'all' || typeSearch == null}">checked</c:if>>
                  			All
                		</label>
                		<label class="radio inline" for="fromDate">
                			From Date:
                			<input type="text" name="fromDate" id="fromDate" class="datepicker input-small" value="${fromDate}" />	
                		</label>
    					<label class="radio inline" for="toDate">
    						To Date:
    						<input type="text" name="toDate" id="toDate" class="datepicker input-small" value="${toDate}" />
    					</label>
              		</div>
              		<div class="control-group">
                		<input type="text" name="searchQuery" class="input-xxlarge" value="${searchQuery}">
                		<a href="#" onclick="document.forms['searchForm'].submit(); return false;"  class="btn btn-info"><i class="icon-white icon-search"></i> Search</a>
              			<a href="${path}/orders/index.do" class="btn btn-primary"> Show All</a>
              		</div>
            	</form>
        	</div>
		</div>	
		
		<div class="container ">
			
			<c:if test="${orderProducts.size() > 0}">
				<table class="table table-striped ">
	            	<thead>
	                	<tr>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=order.id&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'order.id'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'order.id'}">
	                  					&uarr;
	                  				</c:if>
	                  				ID
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=order.client.name&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'order.client.name'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'order.client.name'}">
	                  					&uarr;
	                  				</c:if>
	                  				Client
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=order.client.country&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'order.client.country'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'order.client.country'}">
	                  					&uarr;
	                  				</c:if>
	                  				Country
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=product.name&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'product.name'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'product.name'}">
	                  					&uarr;
	                  				</c:if>
	                  				Product
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=amount&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'amount'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'amount'}">
	                  					&uarr;
	                  				</c:if>
	                  				Amount
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=price&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'price'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'price'}">
	                  					&uarr;
	                  				</c:if>
	                  				Price
	                  			</a>
	                  		</th>
	                  		<th>
	                  			<a href="${path}/orders/index.do?orderBy=order.date&typeSearch=${typeSearch}&searchQuery=${searchQuery}&fromDate=${fromDate}&toDate=${toDate}">
	                  				<c:if test="${orderBy == 'order.date'}">
	                  					&darr;
	                  				</c:if>
	                  				<c:if test="${orderBy != 'order.date'}">
	                  					&uarr;
	                  				</c:if>
	                  				Date
	                  			</a>
	                  		</th>
	                  		<th>Edit</th>
	                	</tr>
	              	</thead>
	              	<tbody>
	                   	  <c:forEach items="${orderProducts}" var="op">
		                  		<tr>
				                	<td>
				                  		<a href="${path}/orders/view_orders.do?id=${op.order.id}">
				                  			${op.order.id}
				                  		</a>
				                  	</td>
				                  	<td>${op.order.client.name}</td>
				                  	<td>${op.order.client.country}</td>
				                  	<td>${op.product.name}</td>
				                  	<td>${op.amount}</td>
				                  	<td><fmt:formatNumber type="currency" value="${op.price}" currencySymbol="&euro;"/></td>
				                  	<td><fmt:formatDate value="${op.order.date}" pattern="dd/MM/yyyy" /></td>
				                  	<td>
				                  		<a href="${path}/orders/new_order.do?id=${op.order.id}">
				                  			<img src="${path}/img/edit-icon.png" width="20"/>
				                  		</a>
				                  	</td>
			                	</tr>
		                  </c:forEach>  
	    		    </tbody>
	    		</table>
	    		
	    		<c:if test="${numberOfPages > 0}">
	    			<jsp:include page="../pagination.jsp">
    					<jsp:param name="link" value="${path}/orders/index.do" />
    					<jsp:param name="parameters" value="typeSearch=${typeSearch}&searchQuery=${searchQuery}&orderBy=${orderBy}&fromDate=${fromDate}&toDate=${toDate}" />
    				</jsp:include>
    			</c:if>
	    		
			</c:if>
			<c:if test="${(orderProducts == null || orderProducts.size() == 0) && typeSearch != null && searchQuery != null}">
	            No records could be found by your search.   	
	        </c:if>
        
  		</div>
		
<jsp:include page="../footer.jsp" />