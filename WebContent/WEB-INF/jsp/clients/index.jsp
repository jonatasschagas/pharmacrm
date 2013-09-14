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
        	<li class="active">
          		Clients
        	</li>
      	</ul>
		
		<div class="row">
        	<table border="0" style="width:100%;">
            	<tr>
              		<td style="width:20%;">
                		<table border="0" style="width:100%;">
                  			<tr>
                    			<td align="center">
                    				<img src="${path}/img/clients.png" width="80">
                    			</td>
                    			<td>
                    				<h3>Clients</h3>
                    			</td>
                  			</tr>
                		</table>
              		</td>
              		<td style="width:80%;">
                		<a class="btn btn-primary pull-right" href="${path}/clients/new_clients.do">New client</a>
              		</td>
            	</tr>
          	</table>
      	</div>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span8" style="margin:0 auto;float:none;">
            	<form class="form-horizontal" name="searchForm" method="GET" action="${path}/clients/index.do">
              		<div class="control-group">
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="name" value="name" <c:if test="${typeSearch == 'name'}">checked</c:if>>
                  			Name
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="contactPerson" value="contactPerson" <c:if test="${typeSearch == 'contactPerson'}">checked</c:if>>
                  			Contact person
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="all" value="all" <c:if test="${typeSearch == 'all'}">checked</c:if>>
                  			All
                		</label>
              		</div>
              		<div class="control-group">
                		<input type="text" name="searchQuery" class="input-xxlarge" value="${searchQuery}">
                		<a href="#" onclick="document.forms['searchForm'].submit(); return false;"  class="btn btn-info"><i class="icon-white icon-search"></i> Search</a>
              			<a href="${path}/clients/index.do" class="btn btn-primary"> Show All</a>
              		</div>
            	</form>
        	</div>
		</div>	
		
		<div class="container ">
			
			<c:if test="${clients.size() > 0}">
				<table class="table table-striped ">
	            	<thead>
	                	<tr>
	                  		<th><a href="${path}/clients/index.do?orderBy=name&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Name</a></th>
	                  		<th><a href="${path}/clients/index.do?orderBy=country&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Country</a></th>
	                  		<th><a href="${path}/clients/index.do?orderBy=city&typeSearch=${typeSearch}&searchQuery=${searchQuery}">City</a></th>
	                  		<th><a href="${path}/clients/index.do?orderBy=clientType&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Type</a></th>
	                  		<th><a href="${path}/clients/index.do?orderBy=industryType&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Industry</a></th>
	                  		<th>Edit</th>
	                	</tr>
	              	</thead>
	              	<tbody>
	                   	  <c:forEach items="${clients}" var="c">
		                  		<tr>
				                	<td>
				                  		<a href="${path}/clients/view_clients.do?id=${c.id}">
				                  			${c.name}
				                  		</a>
				                  	</td>
				                  	<td>${c.country}</td>
				                  	<td>${c.city}</td>
				                  	<td>${c.clientType}</td>
				                  	<td>${c.industryType}</td>
				                  	<td>
				                  		<a href="${path}/clients/new_clients.do?id=${c.id}">
				                  			<img src="${path}/img/edit-icon.png" width="20"/>
				                  		</a>
				                  	</td>
			                	</tr>
		                  </c:forEach>  
	    		    </tbody>
	    		</table>
	    		
	    		<c:if test="${numberOfPages > 0}">
	    			<jsp:include page="../pagination.jsp">
    					<jsp:param name="link" value="${path}/clients/index.do" />
    					<jsp:param name="parameters" value="typeSearch=${typeSearch}&searchQuery=${searchQuery}&orderBy=${orderBy}" />
    				</jsp:include>
    			</c:if>
	    		
			</c:if>
			<c:if test="${(clients == null || clients.size() == 0) && typeSearch != null && searchQuery != null}">
	            No records could be found by your search.   	
	        </c:if>
        
  		</div>
		
<jsp:include page="../footer.jsp" />