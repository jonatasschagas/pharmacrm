<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
   	
   	<jsp:include page="../validation_messages.jsp" />
   	
   	<div id="order_products_area" class="form-horizontal"> 
   		
    	 <legend>Products</legend>
   		
   		<c:if test='${not empty error || not empty param.error}'>
			<div class="row">
	          <div class="col-lg-12">
	            <div class="alert alert-dismissable alert-danger">
	              <button type="button" class="close" data-dismiss="alert">×</button>
	              <strong>Error</strong>
	              <br/>
	              	<c:if test='${not empty error}'>
		  				${error}
		  			</c:if>
		  			<c:if test='${not empty param.error}'>
		  				${param.error}
		  			</c:if>
	            </div>
	          </div>
	        </div>
        </c:if>  
   	 	 
   	 	 <input type="hidden"  name="order_id" id="order_id" value="${order.id}"/>
   	 	 <input type="hidden"  name="order_product_id" id="order_product_id" value="${orderProduct.id}"/>
   	 	 
   	 	 <div class="row-fluid">
        	<div class="span12">
            	<div class="control-group">
	            	<label class="control-label">Product:</label>
	            	<div class="controls">
	            		<select name="product" id="product" class="input-xxlarge">
              				<option value=""></option>
                			<c:forEach var="p" items="${products}" varStatus="status">
                				<option <c:if test="${orderProduct != null && orderProduct.product.id == p.id}">selected</c:if> value="${p.id}">${p.name}</option>
                			</c:forEach>
              			</select>
	            	</div>
	          	</div>
			</div>
	  	</div>
	  	
	  	 <div class="row-fluid">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Amount mg:</label>
		            	<div class="controls">
		              		<input type="text" name="amount" id="amount" class="input-small" value="${orderProduct.amount}"/>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span2">
	          		<div class="control-group">
	            		<label class="control-label">Price EUR:</label>
	            		<div class="controls">
	              			<input type="text" name="price" id="price" class="input-small" value="${orderProduct.price}"/>
	            		</div>
	          		</div>
	          	</div>
	          	<div class="span3">
	          		<a href="#" class="btn btn-info pull-right" id="order_products_add_btn"><i class="icon-white icon-plus"></i> Add/Save</a>
	          	</div>
          </div>
          
         <hr/>
         
          <div class="row">
          	<div class="span8">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Product</th>
			                 <th>Amount</th>
			                 <th>Price</th>
			                 <th>Edit</th>
			                 <th>Delete</th>
			               </tr>
			             </thead>
			               <tbody id="order_products_table">
			               
			               <c:forEach items="${order.orderProducts}" var="op">
			               		<tr>
			               			<td>${op.product.name}</td>
			               			<td>${op.amount}</td>
			               			<td><fmt:formatNumber type="currency" value="${op.price}" currencySymbol="&euro;"/></td>
			               			<th>
			               				<a href="javascript:editOrderProducts('${op.id}');" class="order_products_edit">
		                  					<img src="${path}/img/edit-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               			<th>
			               				<a href="javascript:deleteOrderProducts('${op.id}');" class="order_products_delete">
		                  					<img src="${path}/img/delete-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               		</tr>
			               </c:forEach>
			             </tbody>
			   </table>
          	</div>
          </div>
         
         <script type="text/javascript">
         
         	$(document).ready(function(){
         		
         		$("#order_products_add_btn").click(function(){
         			
         			var product = $("#product").val();
         			var amount = $("#amount").val();
         			var price = $("#price").val();
         			var orderProductId = $("#order_product_id").val();
         			var orderId = $("#order_id").val();
         			
         			$.get("${path}/orders/save_order_products.do",{
         				product : product,
         				amount : amount,
         				price : price,
         				orderProductId : orderProductId,
         				orderId : orderId
         			}, function(data) {
          				// reloads the contacts
     					$('#order_products_area').html(data);
          			});
         			
         		});
         		
         		
         	});
         
         	
         	function editOrderProducts(orderProductId)
         	{
         		var orderId = $("#order_id").val();
         		
         		$.get("${path}/orders/edit_order_products.do",{
     				id : orderProductId,
     				order_id : orderId
     			}, function(data) {
      				// reloads the order products
 					$('#order_products_area').html(data);
      			});
         	}
         	
         	function deleteOrderProducts(orderProductId)
         	{	
         		$("#orderProductSelected").val(orderProductId);
         		$("#deleteOrderProductModal").modal('show');
         	}
         	
         	function confirmDeleteOrderProduct()
         	{
         		var orderProductId = $("#orderProductSelected").val();
				var orderId = $("#order_id").val();
         		
         		$.get("${path}/orders/delete_order_products.do",{
     				id : orderProductId,
     				order_id : orderId
     			}, function(data) {
      				// reloads the order products
      				$("#deleteOrderProductModal").modal('hide');
 					$('#order_products_area').html(data);
      			});
         	}
         	
         	function cleanDeleteOrderProduct()
         	{
         		$("#orderProductSelected").val("");
         		$("#deleteOrderProducttModal").modal('hide');
         	}
         	
         </script>
     
     </div>
		<input type="hidden" name="orderProductSelected" id="orderProductSelected" />
		
		<!-- Modal -->
		<div id="deleteOrderProductModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Are you sure?</h3>
		  </div>
		  <div class="modal-body">
		    <p>Are you sure you want to delete this Order?</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		    <a class="btn btn-danger" href="javascript:confirmDeleteOrderProduct();" >Delete</a>
		  </div>
		</div>

<jsp:include page="../footer.jsp" />