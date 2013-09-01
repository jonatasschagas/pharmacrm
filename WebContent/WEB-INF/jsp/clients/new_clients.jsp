<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="clients" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<ul class="breadcrumb">
        	<li>
          		<a href="#">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		Clients
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		New Clients
        	</li>
      	</ul>
		
		<div class="well">
        <form class="form-horizontal" method="POST" action="save_clients.do">
          <input type="hidden" name="id" id="id" value="${client.id}">
        
          <div class="control-group">
            <label class="control-label">Name:</label>
            <div class="controls">
              <input type="text" name="name" id="name" value="${client.name}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Country:
            </label>
            <div class="controls">
              <select name="country" id="country">
                <c:forEach var="c" items="${countries}" varStatus="status">
                	<option <c:if test="${client.country == c.name}">selected</c:if>value="${c.name}">${c.name}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              City:
            </label>
            <div class="controls">
              <input type="text" name="city" id="city" value="${client.city}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Address:
            </label>
            <div class="controls">
              <input type="text" name="address" id="address" value="${client.address}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Billing Address:
            </label>
            <div class="controls">
              <input type="text" name="billingAddress" id="billingAddress" value="${client.billingAddress}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Telephone:
            </label>
            <div class="controls">
              <input type="text" name="telephone" id="telephone" value="${client.telephone}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              E-mail:
            </label>
            <div class="controls">	
              <input type="text" name="email" id="email" value="${client.email}">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Acquisition:
            </label>
            <div class="controls">
              <select name="acquisition" id="acquistion">
                <option value=""></option>
                <option value="Referral" <c:if test="${client.acquisitionType == 'Referral'}">selected</c:if>>Referral</option>
                <option value="Direct Contact" <c:if test="${client.acquisitionType == 'Direct Contact'}">selected</c:if>>Direct Contact</option>
                <option value="Direct Sale" <c:if test="${client.acquisitionType == 'Direct Sale'}">selected</c:if>>Direct Sale</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Type:
            </label>
            <div class="controls">
              <select id="type" name="type">
                <option value=""></option>
                <option value="Distributor" <c:if test="${client.clientType == 'Distributor'}">selected</c:if>>Distributor</option>
                <option value="User" <c:if test="${client.clientType == 'User'}">selected</c:if>>User</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Industry:
            </label>
            <div class="controls">
              <select id="industry" name="industry">
                <option value=""></option>
                <option value="PET Center" <c:if test="${client.industryType == 'PET Center'}">selected</c:if> >PET Center</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">
              Description:
            </label>
            <div class="controls">
              <textarea id="description" name="description">${client.description}</textarea>
            </div>
          </div>
          <div class="control-group">
            <div class="controls">
              <button type="submit" class="btn btn-primary">Save</button>
            </div>
          </div>
        </form>
      </div>

<jsp:include page="../footer.jsp" />