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
                				<option value="University Hospital" <c:if test="${client.industryType == 'University Hospital'}">selected</c:if> >University Hospital</option>
                				<option value="Hospital" <c:if test="${client.industryType == 'Hospital'}">selected</c:if> >Hospital</option>
                				<option value="Research Center" <c:if test="${client.industryType == 'Research Center'}">selected</c:if> >Research Center</option>
              					<option value="University" <c:if test="${client.industryType == 'University'}">selected</c:if> >University</option>
              					<option value="Pharma" <c:if test="${client.industryType == 'Pharma'}">selected</c:if> >Pharma</option>
              					<option value="Trading" <c:if test="${client.industryType == 'Trading'}">selected</c:if> >Trading</option>
              					<option value="Others" <c:if test="${client.industryType == 'Others'}">selected</c:if> >Others</option>
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
        
        <c:if test="${client != null && client.id != null}">
        	
        	<jsp:include page="contacts.jsp"></jsp:include>
        	
        </c:if>
        
      </div>

<jsp:include page="../footer.jsp" />