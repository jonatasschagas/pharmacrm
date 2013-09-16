<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="orders" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<ul class="breadcrumb">
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
      	</ul>
		
		<div class="well">
        
        	<div class="row">
          		<div class="span12">
	              <div class="control-group">
		            <label class="control-label">Date: <fmt:formatDate value="${order.date}" pattern="yyyy-MM-dd"/></label>
		          </div>
		         </div>
		  	</div>
          <div class="row">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Client: ${order.client.name}</label>
		            </div>
	          	</div>
	          	<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Country: ${order.client.country}</label>
		            </div>
	          	</div>
	      </div>
	      
	      <div class="row">
	      		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Type: ${order.client.clientType}</label>
		            </div>
	          	</div>
	          	<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Industry: ${order.client.industryType}</label>
		            </div>
	          	</div>
	      </div>
          
    	<legend>Orders</legend>
    	
    	<c:set var="total" value="0.0"/>
    	
		<div class="row">
          		<div class="span8">
          			<table class="table table-striped ">
			               <tbody id="order_products_table">
			               
			               <c:forEach items="${order.orderProducts}" var="op">
			               		<tr>
			               			<td>${op.amount} mg ${op.product.name}</td>
			               			<td>${op.price} EUR</td>
			               		</tr>
			               		
			               		<c:set var="total" value="${total + op.price}"/>
			               		
			               </c:forEach>
			               <tr>
			               		<td><b>Total</b></td>
			               		<td><b>${total} EUR</b></td>
			               </tr>
			             </tbody>
			   		</table>
          		</div>
          </div>
         
          	<div class="row">
          		<div class="span12">
	          		<div class="control-group">
			            <label class="control-label">
			              Description:
			            </label>
			            <div class="controls">
			            	${order.description}
			            </div>
			        </div>
	          	</div>
	    	 </div>
    		
    		<hr/>
    		
       		<div class="control-group">
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