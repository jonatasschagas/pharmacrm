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
          		View Order
        	</li>
      	</ul> -->
		
		<div class="well">
			<legend>Order: ${order.client.name} - <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy"/></legend>
        	<div class="row-fluid">
          		<div class="span2">
	            	<span class="label-view">Country:</span>
	            	<span class="value-view">${order.client.country}</span>  
				</div>
			</div>
			<div class="row-fluid">
		  		<div class="span2">
	            	<span class="label-view">Type:</span>
	            	<span class="value-view">${order.client.clientType}</span>  
				</div>
			</div>
			<div class="row-fluid">
				<div class="span2">
	            	<span class="label-view">Industry:</span>
	            	<span class="value-view">${order.client.industryType}</span>  
				</div>
			</div>
	      	<div class="row-fluid">
          		<div class="span12">
	          		<div class="control-group">
			            <span class="label-view">
			              	Description:
			            </span>
			            <span class="value-view">
			            	${order.description}
			            </span>
			        </div>
	          	</div>
	    	 </div>
          
    	<c:set var="total" value="0.0"/>
    	
			<div class="row">
          		<div class="span8">
          			<span class="label-view">
			        	Order Details:
			        </span>
          				<table>
			               <tbody id="order_products_table">
			               <c:forEach items="${order.orderProducts}" var="op">
			               		<tr>
			               			<td class="span4">${op.amount} mg ${op.product.name}</td>
			               			<td><fmt:formatNumber type="currency" value="${op.price}" currencySymbol="&euro;"/></td>
			               		</tr>
			               		
			               		<c:set var="total" value="${total + op.price}"/>
			               		
			               </c:forEach>
			               <tr>
			               		<td></td>
			               		<td><hr noshade size="3" /></td>
			               </tr>
			               <tr>
			               		<td><b>Total</b></td>
			               		<td><b><fmt:formatNumber type="currency" value="${total}" currencySymbol="&euro;"/></b></td>
			               </tr>
			             </tbody>
			   		</table>
          		</div>
          </div>
        </div>
         
      	<div class="control-group noPrint">
            <div class="controls">
              <a href="javascript:window.print();" class="btn btn-info"><i class="icon-white icon-print"></i> Print</a>
              <a href="${path}/orders/new_order.do?id=${order.id}" class="btn btn-primary"><i class="icon-white icon-pencil"></i> Edit</a>
              <button  onClick="$('#deleteOrderModal').modal()" role="button" data-toggle="modal" class="btn btn-danger"><i class="icon-white icon-remove-sign"></i> Delete</button>
            </div>
          </div>
       	
        	
      </div>

		<!-- Modal -->
		<div id="deleteOrderModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Are you sure?</h3>
		  </div>
		  <div class="modal-body">
		    <p>Are you sure you want to delete this order?</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		    <a class="btn btn-danger" href="delete_order.do?id=${order.id}" >Delete</a>
		  </div>
		</div>


<jsp:include page="../footer.jsp" />