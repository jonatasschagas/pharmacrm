<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
   	
   	<div id="contact_area" class="form-horizontal"> 
   		
    	 <legend>Contacts</legend>
   		
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
   	 	 
   	 	 <input type="hidden"  name="client_id" id="client_id" value="${client.id}"/>
   	 	 <input type="hidden"  name="contact_id" id="contact_id" value="${contact.id}"/>
   	 	 
   	 	 <div class="row">
         		<div class="span12">
              <div class="control-group">
	            <label class="control-label">Name:</label>
	            <div class="controls">
	              <input type="text" class="input-xxlarge" name="contact_name" id="contact_name" value="${contact.name}"/>
	            </div>
	          </div>
	         </div>
	  	</div>
	  	
	  	 <div class="row">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Position:</label>
		            	<div class="controls">
		              		<input type="text" name="contact_position" id="contact_position" value="${contact.position}"/>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<div class="control-group">
	            		<label class="control-label">E-mail:</label>
	            		<div class="controls">
	              			<input type="text" name="contact_email" id="contact_email" value="${contact.email}"/>
	            		</div>
	          		</div>
	          	</div>
          </div>
         
	  	
	  	<div class="row">
         		<div class="span12">
              <div class="control-group">
	            <label class="control-label">Address:</label>
	            <div class="controls">
	              <input type="text" class="input-xxlarge" name="contact_address" id="contact_address" value="${contact.address}"/>
	            </div>
	          </div>
	         </div>
	  	</div>
          
          <div class="row">
          		<div class="span6">
	          		<div class="control-group">
	            		<label class="control-label">Telephone:</label>
		            	<div class="controls">
		              		<input type="text" name="contact_telephone" id="contact_telephone" value="${contact.telephone}"/>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<a href="#" class="btn btn-info" id="contact_add_btn"><i class="icon-white icon-plus"></i> Add/Save</a>
	          	</div>
          </div>
         
          <div class="row">
          	<div class="span8">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Name</th>
			                 <th>Address</th>
			                 <th>Telephone</th>
			                 <th>E-mail</th>
			                 <th>Position</th>
			                 <th>Edit</th>
			                 <th>Delete</th>
			               </tr>
			             </thead>
			               <tbody id="contact_table">
			               
			               <c:forEach items="${client.contacts}" var="c">
			               		<tr>
			               			<td>${c.name}</td>
			               			<td>${c.address}</td>
			               			<td>${c.telephone}</td>
			               			<td>${c.email}</td>
			               			<td>${c.position}</td>
			               			<th>
			               				<a href="javascript:editContact('${c.id}');" class="contact_edit">
		                  					<img src="${path}/img/edit-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               			<th>
			               				<a href="javascript:deleteContact('${c.id}');" class="contact_delete">
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
         		
         		$("#contact_add_btn").click(function(){
         			
         			var contactName = $("#contact_name").val();
         			var contactPosition = $("#contact_position").val();
         			var contactEmail = $("#contact_email").val();
         			var contactTelephone = $("#contact_telephone").val();
         			var contactAddress = $("#contact_address").val();
         			var contactId = $("#contact_id").val();
         			var clientId = $("#client_id").val();
         			
         			$.get("${path}/clients/save_contact.do",{
         				name : contactName,
         				position : contactPosition,
         				email : contactEmail,
         				telephone : contactTelephone,
         				address : contactAddress,
         				id : contactId,
         				client_id : clientId
         			}, function(data) {
          				// reloads the contacts
     					$('#contact_area').html(data);
          			});
         			
         		});
         		
         		
         	});
         
         	
         	function editContact(contactId)
         	{
         		var clientId = $("#client_id").val();
         		
         		$.get("${path}/clients/edit_contact.do",{
     				id : contactId,
     				client_id : clientId
     			}, function(data) {
      				// reloads the contacts
 					$('#contact_area').html(data);
      			});
         	}
         	
         	function deleteContact(contactId)
         	{	
         		$("#contactSelected").val(contactId);
         		$("#deleteContactModal").modal('show');
         	}
         	
         	function confirmDeleteContact()
         	{
         		var contactId = $("#contactSelected").val();
				var clientId = $("#client_id").val();
         		
         		$.get("${path}/clients/delete_contact.do",{
     				id : contactId,
     				client_id : clientId
     			}, function(data) {
      				// reloads the contacts
      				$("#deleteContactModal").modal('hide');
 					$('#contact_area').html(data);
      			});
         	}
         	
         	function cleanDeleteContact()
         	{
         		$("#contactSelected").val("");
         		$("#deleteContactModal").modal('hide');
         	}
         	
         </script>
     
     </div>
		<input type="hidden" name="contactSelected" id="contactSelected" />
		
		<!-- Modal -->
		<div id="deleteContactModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Are you sure?</h3>
		  </div>
		  <div class="modal-body">
		    <p>Are you sure you want to delete this contact?</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		    <a class="btn btn-danger" href="javascript:confirmDeleteContact();" >Delete</a>
		  </div>
		</div>

<jsp:include page="../footer.jsp" />