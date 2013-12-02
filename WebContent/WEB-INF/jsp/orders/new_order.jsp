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
        	<li>
          		<a href="${path}/orders/index.do">Orders</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		New Order
        	</li>
      	</ul> -->
		
		<div class="well">
        <form class="form-horizontal" method="POST" action="save_orders.do">
        	<input type="hidden" name="id" id="id" value="${order.id}">
			<div class="row-fluid">
				<div class="span2">
	            	<div class="control-group">
		            	<label class="control-label">Date:</label>
		            	<div class="controls">
		            		<input type="text" name="date" id="date" class="datepicker input-small" value="<fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd"/>" />	
                		</div>
		          	</div>
		         </div>
			</div>
			<div class="row-fluid">
          		 <div class="span8">
	          		<div class="control-group">
	            		<label class="control-label">Client:</label>
		            	<div class="controls">
		              		<select name="client" id="client" class="input-xxlarge">
		              			<option value=""></option>
		                		<c:forEach var="c" items="${clients}" varStatus="status">
		                			<option <c:if test="${order != null && order.client.id == c.id}">selected</c:if> value="${c.id}">${c.name}</option>
		                		</c:forEach>
		              		</select>
		            	</div>
	          		</div>
	          	</div>
		  	</div>
          	<div class="row-fluid">
          		<div class="span12">
	          		<div class="control-group">
			            <label class="control-label">
			              Description:
			            </label>
			            <div class="controls">
			              <textarea id="description" class="input-xxlarge" name="description">${order.description}</textarea>
			            </div>
			        </div>
	          	</div>
	     	</div>
          	<div class="row-fluid">
          		<div class="span8">
	          		<div class="control-group">
			            <div class="controls">	
			              <button type="submit" class="btn btn-primary pull-right">Save</button>
			            </div>
			    	</div>
	          	</div>
          	</div>
        </form>
        
        <c:if test="${order != null && order.id != null}">
        	
        	<jsp:include page="order_products.jsp"></jsp:include>
        	
        </c:if>
        
      </div>

<jsp:include page="../footer.jsp" />