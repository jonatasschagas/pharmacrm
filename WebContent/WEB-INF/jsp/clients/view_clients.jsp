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
          		View Client
        	</li>
      	</ul>
		
		<div class="well">
			<form class="form-horizontal">
				  <input type="hidden" name="id" id="id" value="${client.id}">
        	
		          <div class="control-group">
		            <label class="control-label">Name:</label>
		            <div class="controls">
		              ${client.name}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Country:
		            </label>
		            <div class="controls">
		              ${client.country}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              City:
		            </label>
		            <div class="controls">
		              ${client.city}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Address:
		            </label>
		            <div class="controls">
		              ${client.address}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Billing Address:
		            </label>
		            <div class="controls">
		              ${client.billingAddress}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Telephone:
		            </label>
		            <div class="controls">
		              ${client.telephone}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              E-mail:
		            </label>
		            <div class="controls">	
		              ${client.email}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Acquisition:
		            </label>
		            <div class="controls">
		            	${client.acquisitionType}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Type:
		            </label>
		            <div class="controls">
		              ${client.clientType}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Industry:
		            </label>
		            <div class="controls">
		              	${client.industryType}
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label">
		              Description:	
		            </label>
		            <div class="controls">
		              ${client.description}
		            </div>
		          </div>
		          
		          <legend>Contacts</legend>
		          
		          <div class="control-group">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Name</th>
			                 <th>Address</th>
			                 <th>Telephone</th>
			                 <th>E-mail</th>
			                 <th>Position</th>
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
		          
		          <div class="control-group">
		            <div class="controls">
		              <a href="javascript:window.print();" class="btn btn-info"><i class="icon-white icon-print"></i> Print</a>
		            </div>
		          </div>
						
			</form>
		</div>

<jsp:include page="../footer.jsp" />