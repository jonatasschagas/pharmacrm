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
         	<div class="span7" style="margin:0 auto;float:none;">
            	<form class="form-horizontal">
              		<div class="control-group">
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox1" value="option1">
                  			Name
                		</label>
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox2" value="option2">
                  			Contact person
                		</label>
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox3" value="option3">
                  			All
                		</label>
              		</div>
              		<div class="control-group">
                		<input type="text" class="input-xxlarge">
                			<a href="#" class="btn btn-info"><i class="icon-white icon-search"></i> Search</a>
              		</div>
            	</form>
        	</div>
		</div>	
		
		<div class="container ">
			<table class="table table-striped ">
            	<thead>
                	<tr>
                  		<th>Name</th>
                  		<th>Country</th>
                  		<th>City</th>
                  		<th>Type</th>
                  		<th>Industry</th>
                  		<th>Edit</th>
                	</tr>
              	</thead>
              	<tbody>
	                <c:forEach items="${clients}" var="c" >
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
  		</div>
		
<jsp:include page="../footer.jsp" />