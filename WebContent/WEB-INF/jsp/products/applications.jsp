<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
   	
   	<jsp:include page="../validation_messages.jsp" />
   	
   	<div id="applications_area" class="form-horizontal"> 
   		
   		<legend>Applications</legend>
   		
   		<c:if test='${not empty error || not empty param.error}'>
			<div class="row">
	        	<div class="col-lg-12">
	            	<div class="alert alert-dismissable alert-danger">
	              		<button type="button" class="close" data-dismiss="alert">�</button>
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
   	 	 
   	 	<input type="hidden"  name="product_id" id="product_id" value="${product.id}"/>
   	 	<input type="hidden"  name="application_id" id="application_id" value="${application.id}"/>
   	 	 
   	 	<div class="row">
        	<div class="span3">
            	<div class="control-group">
	            	<label class="control-label">Application:</label>
	            	<div class="controls">
	              		<input type="text" class="input-medium" name="application_name" id="application_name" value="${application.name}"/>
	            	</div>
	          	</div>
	        </div>
	        <div class="span6">
	        	<div class="control-group">
	            	<label class="control-label">Category:</label>
		            <div class="controls">
		              	<select name="application_category" id="application_category">
		              		<option value=""></option>
		              		<option value="Neuroscience" <c:if test="${application.category == 'Neuroscience'}">selected</c:if>>Neuroscience</option>
		            	</select>
		            	<a href="#" class="btn btn-info pull-right" id="application_add_btn"><i class="icon-white icon-plus"></i> Add/Save</a>
		        	</div>
	          	</div>
	      	</div>
	  	</div>
	    
        <c:if test="${product.applications != null && product.applications.size() > 0}">
	        <div class="row">
	        	<div class="span10">
	          		<table class="table table-striped ">
				    	<thead>
				        	<tr>
				            	<th>Application</th>
				                <th>Category</th>
				                <th>Edit</th>
				                <th>Delete</th>
				           	</tr>
				     	</thead>
				        <tbody id="application_table">
				        	<c:forEach items="${product.applications}" var="a">
				            	<tr>
				               		<td>${a.name}</td>
				               		<td>${a.category}</td>
				               		<td>
				               			<a href="javascript:editApplication('${a.id}');" class="application_edit">
			                  				<img src="${path}/img/edit-icon.png" width="20"/>
			                  			</a>
				               		</td>
				               		<td>
				               			<a href="javascript:deleteApplication('${a.id}');" class="application_delete">
			                  				<img src="${path}/img/delete-icon.png" width="20"/>
			                  			</a>
				               		</td>
				               	</tr>
				           	</c:forEach>
				        </tbody>
					</table>
	          	</div>
			</div>
		</c:if>
         
        <script type="text/javascript">
         
        	$(document).ready(function(){
         		
         		$("#application_add_btn").click(function(){
         			
         			var applicationName = $("#application_name").val();
         			var applicationCategory = $("#application_category").val();
         			var applicationId = $("#application_id").val();
         			var productId = $("#product_id").val();
         			
         			$.get("${path}/products/save_application.do",{
         				name : applicationName,
         				category : applicationCategory,
         				id : applicationId,
         				product_id : productId
         			}, function(data) {
          				// reloads the applications
     					$('#applications_area').html(data);
          			});
         			
         		});
         		
         		
         	});
         
         	
         	function editApplication(applicationId)
         	{
         		var productId = $("#product_id").val();
         		
         		$.get("${path}/products/edit_application.do",{
     				id : applicationId,
     				product_id : productId
     			}, function(data) {
      				// reloads the applications
 					$('#applications_area').html(data);
      			});
         	}
         	
         	function deleteApplication(applicationId)
         	{	
         		$("#applicationSelected").val(applicationId);
         		$("#deleteApplicationModal").modal('show');
         	}
         	
         	function confirmDeleteApplication()
         	{
         		var applicationId = $("#applicationSelected").val();
				var productId = $("#product_id").val();
         		
         		$.get("${path}/products/delete_application.do",{
     				id : applicationId,
     				product_id : productId
     			}, function(data) {
     				
      				// reloads the applications
      				$("#deleteApplicationModal").modal('hide');
 					$('#applications_area').html(data);
      			});
         	}
         	
         	function cleanDeleteApplication()
         	{
         		$("#applicationSelected").val("");
         		$("#deleteApplicationModal").modal('hide');
         	}
         	
         </script>
		
		<input type="hidden" name="applicationSelected" id="applicationSelected" />
		
		<!-- Modal -->
		<div id="deleteApplicationModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">�</button>
				<h3 id="myModalLabel">Are you sure?</h3>
			</div>
			<div class="modal-body">
				<p>Are you sure you want to delete this application?</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
			    <a class="btn btn-danger" href="javascript:confirmDeleteApplication();" >Delete</a>
			</div>
		</div>
		     
	</div>

