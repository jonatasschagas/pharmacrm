<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>


<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="products" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<!-- <ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		<a href="${path}/products/index.do">Products</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		New Product
        	</li>
      	</ul> -->
		
		<div class="well">
        	<form class="form-horizontal" method="POST" action="save_product.do" enctype="multipart/form-data">
          		<legend>New/Edit Product</legend>
          		<input type="hidden" name="id" id="id" value="${product.id}">
			
				<div class="row-fluid">
          			<div class="span12">
	              		<div class="control-group">
		            		<label class="control-label">Name:</label>
		            		<div class="controls">
		              			<input type="text" class="input-xxlarge" name="name" id="name" value="${product.name}">
		            		</div>
		          		</div>
		         	</div>
		  		</div>
          
          		<div class="row-fluid">
          			<div class="span3">
	          			<div class="control-group">
	            			<label class="control-label">Type:</label>
		            		<div class="controls">
		              			<select name="type" id="type" class="input-medium">
		              				<option value=""></option>
		                			<option <c:if test="${product != null && product.productType == 'Precursor'}">selected</c:if> value="Precursor">Precursor</option>
		                			<option <c:if test="${product != null && product.productType == 'Reference Standard'}">selected</c:if> value="Reference Standard">Reference Standard</option>
		              			</select>
		            		</div>
	          			</div>
	          		</div>
	          		<div class="span3">
	          			<div class="control-group">
	            			<label class="control-label">In Stock:</label>
		            			<div class="controls">
		              				<select name="inStock" id="inStock" class="input-small">
		              					<option value=""></option>
		                				<option <c:if test="${product != null && product.inStock == '++'}">selected</c:if> value="++">++</option>
		                				<option <c:if test="${product != null && product.inStock == '+'}">selected</c:if> value="+">+</option>
		                				<option <c:if test="${product != null && product.inStock == '-'}">selected</c:if> value="-">-</option>
		              				</select>
		            			</div>
	          			</div>
	          		</div>
          		</div>
          
          		<div class="row-fluid">
          			<div class="span3">
	          			<div class="control-group">
	            			<label class="control-label">
	              				Price &#8364;/ 20 mg:
	            			</label>
	            			<div class="controls">
	              				<input type="text" name="price" class="input-small" id="price" value="${product.price}">
	            			</div>
	         	 		</div>
	         	 	</div>
	         	 	<div class="span3">
	          			<div class="control-group">
			            	<label class="control-label">
			              		Production Year:
			            	</label>
			            	<div class="controls">
			              		<input type="text" name="productionYear"  class="input-small" id="productionYear" value="${product.productionYear}">
			            	</div>
			        	</div>
	          		</div>
          		</div>
          
          		<div class="row-fluid">
          			<div class="span3">
	          			<div class="control-group">
			            	<label class="control-label">
			              		CAS:
			            	</label>
			            	<div class="controls">	
			              		<input type="text" name="cas" id="cas" class="input-medium" value="${product.cas}">
			            	</div>
			    		</div>
	          		</div>
	          		<div class="span3">
	          			<div class="control-group">
			            	<label class="control-label">
			              		Product ID:
			            	</label>
			            	<div class="controls">	
			              		<input type="text" name="productIdPH" id="productIdPH" class="input-medium" value="${product.productIdPH}">
			            	</div>
			    		</div>
	          		</div>
          		</div>
          		
          		<div class="row-fluid">
          			<div class="span12">
	          			<div class="control-group">
			            	<label class="control-label">
			              		Description:
			            	</label>
			            	<div class="controls">
			             		<textarea id="description" class="input-xxlarge" name="description">${product.description}</textarea>
			            	</div>
			        	</div>
	          		</div>
	     		</div>
          		
          		<div class="row-fluid">
          			<div class="span9">
	          			<div class="control-group">
			            	<label class="control-label">
			              		Structure:
			            	</label>
			            	<div class="controls">	
			              		 <input type="hidden" name="MAX_FILE_SIZE" value="20971520" />
	                    	 	<input name="structurePath" type="file" class="input-xlarge" id="structurePath" />
			            	 	<c:if test="${product != null && product.structurePath != null}">
			            	 		<img src="${path}/products/files.do?file=${product.structurePath}&folder=products" width="150" />
			            	 	</c:if>
			            	</div>
			    		</div>
	          		</div>
	      		</div>
          		<div class="row-fluid">
          			<div class="span8">
	          			<div class="control-group">
			            	<div class="controls">	
			              		<button type="submit" class="btn btn-primary pull-right">Save</button>
			            	</div>
			    		</div>
	          		</div>
          		</div>
        	</form>
        
        	<c:if test="${product != null && product.id != null}">
        	
        		<jsp:include page="case_studies.jsp"></jsp:include>
        	
        		<jsp:include page="applications.jsp"></jsp:include>
        	
        	</c:if>
      </div>

<jsp:include page="../footer.jsp" />