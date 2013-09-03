<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="clients" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		<a href="${path}/clients/index.do">Clients</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		New Client
        	</li>
      	</ul>
		
		<div class="well">
        <form class="form-horizontal" method="POST" action="save_clients.do">
          <input type="hidden" name="id" id="id" value="${client.id}">
			
			<div class="row">
          		<div class="span12">
	              <div class="control-group">
		            <label class="control-label">Name:</label>
		            <div class="controls">
		              <input type="text" class="input-xxlarge" name="name" id="name" value="${client.name}">
		            </div>
		          </div>
		         </div>
		  	</div>
          <div class="row">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Country:</label>
		            	<div class="controls">
		              		<select name="country" id="country">
		              			<option value=""></option>
		                		<c:forEach var="c" items="${countries}" varStatus="status">
		                			<option <c:if test="${client != null && client.country.equals(c.name)}">selected</c:if> value="${c.name}">${c.name}</option>
		                		</c:forEach>
		              		</select>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<div class="control-group">
	            		<label class="control-label">City:</label>
	            		<div class="controls">
	              			<input type="text" name="city" id="city" value="${client.city}">
	            		</div>
	          		</div>
	          	</div>
          </div>
          
          <div class="row">
          		<div class="span12">
	          		<div class="control-group">
	            		<label class="control-label">
	              			Address:
	            		</label>
	            		<div class="controls">
	              			<input type="text" name="address" class="input-xxlarge" id="address" value="${client.address}">
	            		</div>
	         	 	</div>
	         	 </div>
          </div>
          
          <div class="row">
          		<div class="span12">
	          		<div class="control-group">
	            		<label class="control-label">
	              			Billing Address:
	            		</label>
	            		<div class="controls">
	              			<input type="text" name="billingAddress" class="input-xxlarge" id="billingAddress" value="${client.billingAddress}">
	            		</div>
	         	 	</div>
	         	 </div>
          </div>
          
          <div class="row">
          		<div class="span3">
	          		<div class="control-group">
			            <label class="control-label">
			              Telephone:
			            </label>
			            <div class="controls">
			              <input type="text" name="telephone" id="telephone" value="${client.telephone}">
			            </div>
			        </div>
	          	</div>
	          	<div class="span4">
	          		<div class="control-group">
			            <label class="control-label">
			              E-mail:
			            </label>
			            <div class="controls">	
			              <input type="text" name="email" id="email" value="${client.email}">
			            </div>
			    	</div>
	          	</div>
          </div>
          
          <div class="row">
          		<div class="span3">
	          		<div class="control-group">
			            <label class="control-label">
			              Acquisition:
			            </label>
			            <div class="controls">
			              <select name="acquisition" class="input-medium" id="acquistion">
			                <option value=""></option>
			                <option value="Referral" <c:if test="${client.acquisitionType == 'Referral'}">selected</c:if>>Referral</option>
			                <option value="Direct Contact" <c:if test="${client.acquisitionType == 'Direct Contact'}">selected</c:if>>Direct Contact</option>
			                <option value="Direct Sale" <c:if test="${client.acquisitionType == 'Direct Sale'}">selected</c:if>>Direct Sale</option>
			              </select>
			            </div>
			        </div>
	          	</div>
	          	<div class="span3">
	          		<div class="control-group">
			            <label class="control-label">
			              Type:
			            </label>
			            <div class="controls">	
			              	<select id="type" class="input-medium" name="type">
                				<option value=""></option>
                				<option value="Distributor" <c:if test="${client.clientType == 'Distributor'}">selected</c:if>>Distributor</option>
               	 				<option value="User" <c:if test="${client.clientType == 'User'}">selected</c:if>>User</option>
              				</select>
			            </div>
			    	</div>
	          	</div>
	          	<div class="span3">
	          		<div class="control-group">
			            <label class="control-label">
			              Industry:
			            </label>
			            <div class="controls">	
			              	<select id="industry" class="input-medium" name="industry">
                				<option value=""></option>
                				<option value="PET Center" <c:if test="${client.industryType == 'PET Center'}">selected</c:if> >PET Center</option>
              				</select>
			            </div>
			    	</div>
	          	</div>
          </div>
          
          <div class="row">
          		<div class="span12">
	          		<div class="control-group">
			            <label class="control-label">
			              Description:
			            </label>
			            <div class="controls">
			              <textarea id="description" class="input-xxlarge" name="description">${client.description}</textarea>
			            </div>
			        </div>
	          	</div>
	     </div>
    	
    	 <legend>Contacts</legend>
   	 	 
   	 	 <input type="hidden" id="contact_json" name="contact_json"/>
   	 	 <input type="hidden" id="contact_selected_id" name="contact_selected_id"/>
   	 	 
   	 	 <div class="row">
         		<div class="span12">
              <div class="control-group">
	            <label class="control-label">Name:</label>
	            <div class="controls">
	              <input type="text" class="input-xxlarge" name="contact_name" id="contact_name"/>
	            </div>
	          </div>
	         </div>
	  	</div>
            
          <div class="row">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Position:</label>
		            	<div class="controls">
		              		<input type="text" name="contact_position" id="contact_position"/>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<div class="control-group">
	            		<label class="control-label">E-mail:</label>
	            		<div class="controls">
	              			<input type="text" name="contact_email" id="contact_email"/>
	            		</div>
	          		</div>
	          	</div>
          </div>
          
          <div class="row">
          		<div class="span6">
	          		<div class="control-group">
	            		<label class="control-label">Telephone:</label>
		            	<div class="controls">
		              		<input type="text" name="contact_telephone" id="contact_telephone"/>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<a href="#" class="btn btn-info" id="contact_add_btn"><i class="icon-white icon-plus"></i> Add Contact</a>
	          	</div>
          </div>
         
          <div class="container">
          	<div class="span2">
          	</div>
          	<div class="span6">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Name</th>
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
			               			<td>${c.telephone}</td>
			               			<td>${c.email}</td>
			               			<td>${c.position}</td>
			               			<th>
			               				<a href="javascript:editContact('e_${c.name.replaceAll(" ","_")}${c.id}');" class="contact_edit" n_id="${c.id}" name="${c.name}" id="e_${c.name}${c.id}">
		                  					<img src="${path}/img/edit-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               			<th>
			               				<a href="javascript:deleteContact('d_${c.name.replaceAll(" ","_")}${c.id}');" class="contact_delete" name="${c.name.replaceAll(" ","_")}" id="d_${c.name}${c.id}" n_id="${c.id}" name="${c.name}">
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
         		
         		//loadContactTable();
         		
         		$("#contact_add_btn").click(function(){
         			
         			var contactName = $("#contact_name").val();
         			var contactPosition = $("#contact_position").val();
         			var contactEmail = $("#contact_email").val();
         			var contactTelephone = $("#contact_telephone").val();
         			var contactId = $("#contact_selected_id").val();
         			var contactJsonString = $("#contact_json").val();
         			
         			var contact = null;
         			var contactJson = null;
         			
         			try
         			{
         				contactJson = JSON.parse(contactJsonString);
         			} catch(err){}
         			
         			if(contactId != "" && contactId != null && contactJson != null)
         			{
         				for(var i = 0; i < contactJson.length; i ++)
         				{
         					var currentContact = contactJson[i];
         					
         					if((currentContact != null && currentContact.id != null 
         							&& currentContact.id == contactId) || 
         							(currentContact != null && currentContact.name != null 
                 							&& currentContact.name == contactId))
         					{
         						/// updating the contact
         						currentContact.name = contactName;
         						currentContact.position = contactPosition;
         						currentContact.email = contactEmail;
         						currentContact.telephone = contactTelephone;
         					}
         					
         					contactJson[i] = currentContact;
         				}
         			}
         			else if(contactJson != null)// new contact to add to existing contacts
         			{
         				contact = {id : "", name : contactName, position : contactPosition, email : contactEmail, telephone : contactTelephone };
         				contactJson.push(contact);
         			}
         			else // first contact
       				{
         				contactJson = [{id : "" ,name : contactName, position : contactPosition, email : contactEmail, telephone : contactTelephone }];
       				}
         			
         			$("#contact_json").val(JSON.stringify(contactJson));
         			
         			$("#contact_name").val("");
         			$("#contact_position").val("");
         			$("#contact_email").val("");
         			$("#contact_telephone").val("");
         			$("#contact_selected_id").val("");
         		
         			
         			loadContactTable();
         			
         		});
         		
         		
         	});
         
         	function loadContactTable()
         	{
         		var contactJson = null;
         		
         		try
         		{
         			contactJson = JSON.parse($("#contact_json").val());
         		} catch (err) {}
     			
         		if(contactJson != null)
         		{
         			$("#contact_table").html("");
         			
         			for(var i = 0; i < contactJson.length; i ++)
     				{
     					var currentContact = contactJson[i];
     					
     					var name = replaceSpaces(currentContact.name);
     					var id = replaceSpaces(currentContact.id);
     					
     					var html = "<tr>";
     					html += "<td>"+currentContact.name+"</td>";
     					html += "<td>"+currentContact.telephone+"</td>";
     					html += "<td>"+currentContact.email+"</td>";
     					html += "<td>"+currentContact.position+"</td>";
     					html += "<td><a href='javascript:editContact(\"e_"+name+id+"\");' class='contact_edit' name='"+currentContact.name+"' n_id='"+id+"' id='e_"+name+id+"'><img src='${path}/img/edit-icon.png' width='20'/></a></td>";
     					html += "<td><a href='javascript:deleteContact(\"d_"+name+id+"\");' class='contact_delete' name='"+currentContact.name+"' n_id='"+id+"' id='d_"+currentContact.name+currentContact.id+"'><img src='${path}/img/delete-icon.png' width='20'/></a></td>";
     					html += "</tr>";
     						
     					$("#contact_table").append(html);
     					
     				}
         		}
         	}
         	
         	function editContact(item)
         	{
         		var name = $("#" + item).attr("name");
     			var id = $("#" + item).attr("n_id");
     			var contactJson = JSON.parse($("#contact_json").val());
				
     			if(id != null && id != "")
     			{
     				$("#contact_selected_id").val(id);
     			}
     			else if(name != null && name != "")
     			{
     				$("#contact_selected_id").val(name);
     			}
     			
     			for(var i = 0; i < contactJson.length; i ++)
 				{
 					var currentContact = contactJson[i];
 					
 					if(id != null && id != "" && currentContact.id == id 
 							|| name != null && name != "" && currentContact.name == name)
 					{
 						$("#contact_name").val(currentContact.name);
     					$("#contact_telephone").val(currentContact.telephone);
     					$("#contact_email").val(currentContact.email);
     					$("#contact_position").val(currentContact.position);	
 					}
 				}
         	}
         	
         	function deleteContact(item)
         	{	
         		var name = $("#" + item).attr("name");
     			var id = $("#" + item).attr("n_id");
     			var contactJson = JSON.parse($("#contact_json").val());
				
     			if(id != null && id != "")
     			{
     				// deletes from the database first
     				$.get('${path}/clients/delete_contact.do?id=' + id, function(data) {
          				// reloads the contacts
     					$('#contact_json').html(data);
          			});
     			}
     			else if(name != null && name != "")
     			{
     				var newJson = [];
     				
     				// we add all the items to new json except the one
     				// we want to delete
     				for(var i = 0; i < contactJson.length; i ++)
     				{
     					var currentContact = contactJson[i];
     					if(currentContact.name != name)
     					{
     						newJson.push({id : currentContact.id, name : currentContact.name, email : currentContact.email, telephone: currentContact.telephone, position : currentContact.position});
     					}
     				}
     				
     				$("#contact_json").val(JSON.stringify(newJson));
     				
     			}
     			
     			loadContactTable();
     			
         	}
         	
         	function replaceSpaces(word)
         	{
         		word=word.replace(/ /g,"_");
         		return word;
         	}
         	
         </script>
         
         <hr/>
          <div class="row">
          		<div class="span8">
	          		<div class="control-group">
			            <div class="controls">	
			              <button type="submit" class="btn btn-primary">Save</button>
			            </div>
			    	</div>
	          	</div>
          </div>
          
        </form>
      </div>

<jsp:include page="../footer.jsp" />