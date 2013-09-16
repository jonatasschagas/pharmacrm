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
        	<li>
          		<a href="${path}/products/index.do">Products</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		View Product
        	</li>
      	</ul>
		
		<div class="well">
       	 	
       	 	<div class="row">
          		<div class="span4">
	              	<div class="control-group">
		          		<label class="control-label">Name: ${product.name}</label>
		       		</div>
		       		<div class="control-group">
	            		<label class="control-label">Type: ${product.productType}</label>
		      		</div>
		      		<div class="control-group">
	            		<label class="control-label">In Stock: ${product.inStock}</label>
	          		</div>
	          		<div class="control-group">
	            		<label class="control-label">Price/20mg: ${product.price}</label>
	          		</div>
	          		<div class="control-group">
		          		<label class="control-label">Production Year: ${product.productionYear}</label>
		       		</div>
		       		<div class="control-group">
	            		<label class="control-label">CAS: ${product.cas}</label>
		      		</div>
		      		<div class="control-group">
	            		<label class="control-label">Product Id: ${product.productIdPH}</label>
	          		</div>
		   		</div>
		   		<div class="span4">
	          		<div class="control-group">
			            <label class="control-label">
			              	Structure:
			            </label>
			            <c:if test="${product != null && product.structurePath != null}">
		            		<img src="${path}/products/files.do?file=${product.structurePath}&folder=products" width="150" />
		            	</c:if>
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
			        	${product.description}
			        </div>
			    </div>
	     	</div>
	     </div>
    	
    	<div class="row">
          	<div class="span8">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Name</th>
			                 <th>Link/File</th>
			               </tr>
			             </thead>
			               <tbody id="contact_table">
			               
			               <c:forEach items="${product.caseStudies}" var="c">
			               		<tr>
			               			<td>${c.name}</td>
			               			<td>
			               				<c:if test="${c.link != null}">
			               					<a href="${c.link}">${c.name}</a>
			               				</c:if>
			               				
			               				<c:if test="${c.filePath != null}">
			               					<a href="${path}/products/files.do?file=${c.filePath}&folder=case_studies">${c.name}</a>
			               				</c:if>
			               				
			               			</td>
			               		</tr>
			               </c:forEach>
			             </tbody>
			   </table>
          	</div>
          </div>
    	
    	  <div class="row">
          	<div class="span8">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Application</th>
			                 <th>Category</th>
			               </tr>
			             </thead>
			               <tbody id="application_table">
			               
			               <c:forEach items="${product.applications}" var="a">
			               		<tr>
			               			<td>${a.name}</td>
			               			<td>${a.category}</td>
			               		</tr>
			               </c:forEach>
			             </tbody>
			   </table>
          	</div>
          </div>
        
   	         <div class="control-group">
	            <div class="controls">
	              <a href="javascript:window.print();" class="btn btn-info"><i class="icon-white icon-print"></i> Print</a>
	              <a href="${path}/products/new_product.do?id=${product.id}" class="btn btn-primary"><i class="icon-white icon-pencil"></i> Edit</a>
	              <button  onClick="$('#deleteProductModal').modal()" role="button" data-toggle="modal" class="btn btn-danger"><i class="icon-white icon-remove-sign"></i> Delete</button>
	            </div>
	          </div>
		</div>

		<!-- Modal -->
		<div id="deleteProductModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Are you sure?</h3>
		  </div>
		  <div class="modal-body">
		    <p>Are you sure you want to delete this product?</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		    <a class="btn btn-danger" href="${path}/products/delete_product.do?id=${product.id}" >Delete</a>
		  </div>
		</div>

      </div>

<jsp:include page="../footer.jsp" />