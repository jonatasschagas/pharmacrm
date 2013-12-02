<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="clients" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<!-- <ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		<a href="${path}/clients/index.do">Clients</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		View Client
        	</li>
      	</ul> -->
		
		<div class="well yesPrint">
			<legend>${client.name}</legend>
			<form class="form-horizontal">
				<input type="hidden" name="id" id="id" value="${client.id}">
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">Country:</span>
						<span class="value-view">${client.country}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">City:</span>
						<span class="value-view">${client.city}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span16">
						<span class="label-view">Address:</span>
						<span class="value-view">${client.address}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span16">
						<span class="label-view">Billing Address:</span>
						<span class="value-view">${client.billingAddress}</span>
					</div>
				</div>
		        <div class="row-fluid">
					<div class="span4">
						<span class="label-view">Telephone:</span>
						<span class="value-view">${client.telephone}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">E-mail:</span>
						<span class="value-view">${client.email}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">Acquisition:</span>
						<span class="value-view">${client.acquisitionType}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">Type:</span>
						<span class="value-view">${client.clientType}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span4">
						<span class="label-view">Industry:</span>
						<span class="value-view">${client.industryType}</span>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span8">
						<span class="label-view">Description:</span>
						<span class="value-view">${client.description}</span>
					</div>
				</div>  
		          
		        <legend>Contacts</legend>
		          
		        <div class="row-fluid">
		        	<div class="span12">
		          		<table class="table table-striped ">
					             <thead>
					               <tr>
					                 <th class="span2">Name</th>
					                 <th class="span2">Address</th>
					                 <th class="span2">Telephone</th>
					                 <th class="span2">E-mail</th>
					                 <th class="span2">Position</th>
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
					               		</tr>
					               </c:forEach>
					             </tbody>
					   </table>
					</div>
          		</div>
          </div>
		          
          <div class="control-group noPrint">
            <div class="controls">
              <a href="javascript:window.print();" class="btn btn-info"><i class="icon-white icon-print"></i> Print</a>
              <a href="${path}/clients/new_clients.do?id=${client.id}" class="btn btn-primary"><i class="icon-white icon-pencil"></i> Edit</a>
              <button  onClick="$('#deleteClientModal').modal()" role="button" data-toggle="modal" class="btn btn-danger"><i class="icon-white icon-remove-sign"></i> Delete</button>
            </div>
          </div>
				
			</form>
		</div>

		<!-- Modal -->
		<div id="deleteClientModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Are you sure?</h3>
		  </div>
		  <div class="modal-body">
		    <p>Are you sure you want to delete this client?</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		    <a class="btn btn-danger" href="delete_client.do?id=${client.id}" >Delete</a>
		  </div>
		</div>

<jsp:include page="../footer.jsp" />