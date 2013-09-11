<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="products" />
    <jsp:param name="sub" value="../" />
</jsp:include>
		
		<ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Products
        	</li>
      	</ul>
		
		<div class="row">
        	<table border="0" style="width:100%;">
            	<tr>
              		<td style="width:20%;">
                		<table border="0" style="width:100%;">
                  			<tr>
                    			<td align="center">
                    				<img src="${path}/img/products.png" width="80">
                    			</td>
                    			<td>
                    				<h3>Products</h3>
                    			</td>
                  			</tr>
                		</table>
              		</td>
              		<td style="width:80%;">
                		<a class="btn btn-primary pull-right" href="${path}/products/new_product.do">New Product</a>
              		</td>
            	</tr>
          	</table>
      	</div>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span8" style="margin:0 auto;float:none;">
            	<form class="form-horizontal" name="searchForm" method="GET" action="${path}/products/index.do">
              		<div class="control-group">
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="name" value="name" <c:if test="${typeSearch == 'name'}">checked</c:if>>
                  			Name
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="application" value="application" <c:if test="${typeSearch == 'application'}">checked</c:if>>
                  			Application
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="cas" value="cas" <c:if test="${typeSearch == 'cas'}">checked</c:if>>
                  			CAS
                		</label>
                		<label class="radio inline">
                  			<input type="radio" name="typeSearch" id="all" value="all" <c:if test="${typeSearch == 'all'}">checked</c:if>>
                  			All
                		</label>
              		</div>
              		<div class="control-group">
                		<input type="text" name="searchQuery" class="input-xxlarge" value="${searchQuery}">
                		<a href="#" onclick="document.forms['searchForm'].submit(); return false;"  class="btn btn-info"><i class="icon-white icon-search"></i> Search</a>
              			<a href="${path}/products/index.do" class="btn btn-primary"> Show All</a>
              		</div>
            	</form>
        	</div>
		</div>	
		
		<div class="container ">
			
			<c:if test="${products.size() > 0}">
				<table class="table table-striped ">
	            	<thead>
	                	<tr>
	                  		<th><a href="${path}/products/index.do?orderBy=name&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Name</a></th>
	                  		<th><a href="${path}/products/index.do?orderBy=productType&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Type</a></th>
	                  		<th><a href="${path}/products/index.do?orderBy=inStock&typeSearch=${typeSearch}&searchQuery=${searchQuery}">In Stock</a></th>
	                  		<th><a href="${path}/products/index.do?orderBy=productionYear&typeSearch=${typeSearch}&searchQuery=${searchQuery}">Year</a></th>
	                  		<th>Edit</th>
	                	</tr>
	              	</thead>
	              	<tbody>
	                   	  <c:forEach items="${products}" var="p">
		                  		<tr>
				                	<td>
				                  		<a href="${path}/products/view_product.do?id=${p.id}">
				                  			> ${p.name}
				                  		</a>
				                  	</td>
				                  	<td>${p.productType}</td>
				                  	<td>${p.inStock}</td>
				                  	<td>${p.productionYear}</td>
				                  	<td>
				                  		<a href="${path}/products/new_product.do?id=${p.id}">
				                  			<img src="${path}/img/edit-icon.png" width="20"/>
				                  		</a>
				                  	</td>
			                	</tr>
		                  </c:forEach>  
	    		    </tbody>
	    		</table>
	    		
	    		<c:if test="${numberOfPages > 0}">
	    			<jsp:include page="../pagination.jsp">
    					<jsp:param name="link" value="${path}/products/index.do" />
    					<jsp:param name="parameters" value="typeSearch=${typeSearch}&searchQuery=${searchQuery}&orderBy=${orderBy}" />
    				</jsp:include>
    			</c:if>
	    		
			</c:if>
			<c:if test="${(products == null || products.size() == 0) && typeSearch != null && searchQuery != null}">
	            No records could be found by your search.   	
	        </c:if>
        
  		</div>
		
<jsp:include page="../footer.jsp" />