<%@page import="com.pharmasynth.util.Utils"%>
<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
   	
   	<jsp:include page="../validation_messages.jsp" />
   	
	<div id="case_studies_area" class="form-horizontal"> 
   		
    	<legend>Case Studies</legend>
   		
   		<c:if test='${not empty error || not empty param.error}'>
			<div class="row">
	        	<div class="col-lg-12">
	            	<div class="alert alert-dismissable alert-danger">
	              		<button type="button" class="close" data-dismiss="alert">×</button>
	              		<strong>Error</strong>
	              		<br/>
	              		<c:if test='${not empty error}'>
		  					${error}
		  				</c:if>
		  				<c:if test='${not empty param.error}'>
		  					${param.error}
		  				</c:if>
	            	</div>
	          	</div>
			</div>
        </c:if>  
   	 	 
   	 	<form name="caseStudy_form" id="caseStudy_form" enctype="multipart/form-data" action="${path}/products/save_case_study.do" method="POST">
            
            <input type="hidden"  name="product_id" id="product_id" value="${product.id}"/>
   	 	 	<input type="hidden"  name="caseStudyId" id="caseStudyId" value="${caseStudy.id}"/>
   	 	 
   	 	 	<div class="row-fluid">
         		<div class="span3">
              		<div class="control-group">
	            		<label class="control-label">Name:</label>
	            		<div class="controls">
	              			<input type="text" class="input-large" name="caseStudy_name" id="caseStudy_name" value="${caseStudy.name}"/>
	            		</div>
	          		</div>
	         	</div>
	         	<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">Link:</label>
	            		<div class="controls">
	              			<input type="text" class="input-large" name="caseStudy_link" id="caseStudy_link" value="${caseStudy.link}"/>
	            		</div>
	          		</div>
	          	</div>
	        </div>
	        <div class="row-fluid">
	         	<div class="span6">
	          		<div class="control-group">
	            		<label class="control-label">File:</label>
		            	<div class="controls">
		              		 <input name="caseStudy_file" type="file" class="input-xlarge" id="caseStudy_file" />
			            	 <c:if test="${caseStudy != null && caseStudy.filePath != null}">
			            	 	<a href="${path}/products/files.do?file=${caseStudy.filePath}&folder=case_studies">Download Current File</a>
			            	 </c:if>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<a href="#" class="btn btn-info" id="caseStudy_add_btn"><i class="icon-white icon-plus"></i> Add/Save</a>
	          	</div>
	  		</div>
	  	</form>
	  	 
	  	<c:if test="${product.caseStudies != null && product.caseStudies.size() > 0}"> 
	        <div class="row">
	        	<div class="span10">
	          		<table class="table table-striped ">
				    	<thead>
				        	<tr>
				            	<th>Name</th>
				                <th>Edit</th>
				                <th>Delete</th>
				            </tr>
				        </thead>
				        <tbody id="contact_table">
				        	<c:forEach items="${product.caseStudies}" var="c">
				            	<tr>
				               		<td>
				               			<c:if test="${c.link != null && c.filePath == null}">
				               				<a href="${c.link}">${c.name}</a>
				               			</c:if>
				               			<c:if test="${c.filePath != null}">
				               				<a href="${path}/products/files.do?file=${c.filePath}&folder=case_studies">${c.name}</a>
				               			</c:if>
				               		</td>
				               		<td>
				               			<a href="javascript:editCaseStudies('${c.id}');" class="caseStudies_edit">
			                  				<img src="${path}/img/edit-icon.png" width="20"/>
			                  			</a>
				               		</td>
				               		<td>
				               			<a href="javascript:deleteCaseStudies('${c.id}');" class="caseStudies_delete">
			                  				<img src="${path}/img/delete-icon.png" width="20"/>
			                  			</a>
				               		</td>
				               	</tr>
				            </c:forEach>
				       	</tbody>
				   	</table>
	          	</div>
	 		</div>
	 	</c:if>
         
         <script type="text/javascript">
         
         	$(document).ready(function(){
         		
         		$("#caseStudy_add_btn").click(function(){
            		
            		var formData = new FormData($("#caseStudy_form").get(0));
            		var fileName = $("#caseStudy_file").val();
            		formData.append(fileName, $("#caseStudy_file"));
            		
            		var action = $("#caseStudy_form").attr("action");
            		
            		var xhr = new XMLHttpRequest();
           			xhr.open("POST",  action , true);
           			xhr.send(formData);
           			xhr.onreadystatechange=function(){
           		  		if (xhr.readyState==4 && xhr.status==200)
           		    	{
           		  			try
           		  			{	
           		  				$('#case_studies_area').html(xhr.responseText);
           		  			} catch (err) {}
           		  		}
           		  	}
           			
            	});
            
         		
         	});
         
         	
         	function editCaseStudies(caseStudyId)
         	{
         		var productId = $("#product_id").val();
         		
         		$.get("${path}/products/edit_case_study.do",{
     				id : caseStudyId,
     				product_id : productId
     			}, function(data) {
     				// reloads the case studies
 					$('#case_studies_area').html(data);
      			});
         	}
         	
         	function deleteCaseStudies(caseStudyId)
         	{	
         		$("#caseStudySelected").val(caseStudyId);
         		$("#deleteCaseStudyModal").modal('show');
         	}
         	
         	function confirmDeleteCaseStudy()
         	{
         		var caseStudyId = $("#caseStudySelected").val();
				var productId = $("#product_id").val();
         		
         		$.get("${path}/products/delete_case_study.do",{
     				id : caseStudyId,
     				product_id : productId
     			}, function(data) {
      				// reloads the products
      				$("#deleteCaseStudyModal").modal('hide');
 					$('#case_studies_area').html(data);
      			});
         	}
         	
         	function cleanDeleteCaseStudies()
         	{
         		$("#contactSelected").val("");
         		$("#deleteCaseStudytModal").modal('hide');
         	}
         	
         </script>
         
         
         
		<input type="hidden" name="caseStudySelected" id="caseStudySelected" />
		<!-- Modal -->
		<div id="deleteCaseStudyModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			    <h3 id="myModalLabel">Are you sure?</h3>
			</div>
			<div class="modal-body">
				<p>Are you sure you want to delete this case study?</p>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
			    <a class="btn btn-danger" href="javascript:confirmDeleteCaseStudy();" >Delete</a>
			</div>
		</div>
     
	</div>
	