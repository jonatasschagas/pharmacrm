<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
   	
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
   	 	 
   	 	 <form name="caseStudy_form" id="caseStudy_form" enctype="multipart/form-data" action="save.do" method="POST">
            
   	 	 <input type="hidden"  name="product_id" id="product_id" value="${product.id}"/>
   	 	 <input type="hidden"  name="caseStudyId" id="caseStudyId" value="${caseStudy.id}"/>
   	 	 
   	 	 <div class="row">
         		<div class="span12">
              <div class="control-group">
	            <label class="control-label">Name:</label>
	            <div class="controls">
	              <input type="text" class="input-xxlarge" name="caseStudy_name" id="caseStudy_name" value="${caseStudy.name}"/>
	            </div>
	          </div>
	         </div>
	  	</div>
	  	
	  	 <div class="row">
          		<div class="span3">
	          		<div class="control-group">
	            		<label class="control-label">File:</label>
		            	<div class="controls">
		              		 <input name="caseStudy_file" type="file" class="input-xlarge" id="caseStudy_file" />
			            	 <c:if test="${caseStudy != null && caseStudy.filePath != null}">
			            	 	<img src="${caseStudy.filePath}" width="150" />
			            	 </c:if>
		            	</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<div class="control-group">
	            		<label class="control-label">Link:</label>
	            		<div class="controls">
	              			<input type="text" name="caseStudy_link" id="caseStudy_link" value="${caseStudy.link}"/>
	            		</div>
	          		</div>
	          	</div>
	          	<div class="span4">
	          		<a href="#" class="btn btn-info" id="caseStudy_add_btn"><i class="icon-white icon-plus"></i> Add/Save</a>
	          	</div>
          </div>
          
          </form>
	  	 
          <div class="row">
          	<div class="span8">
          		<table class="table table-striped ">
			             <thead>
			               <tr>
			                 <th>Name</th>
			                 <th>Link/File</th>
			                 <th>Edit</th>
			                 <th>Delete</th>
			               </tr>
			             </thead>
			               <tbody id="contact_table">
			               
			               <c:forEach items="${product.caseStudies}" var="c">
			               		<tr>
			               			<td>${c.name}</td>
			               			<td>
			               				<c:if test="${c.link != null}">
			               					<a href="${c.link}">${c.link}</a>
			               				</c:if>
			               				
			               				<c:if test="${c.filePath != null}">
			               					<a href="${c.filePath}">${c.filePath}</a>
			               				</c:if>
			               				
			               			</td>
			               			<th>
			               				<a href="javascript:editCaseStudies('${c.id}');" class="caseStudies_edit">
		                  					<img src="${path}/img/edit-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               			<th>
			               				<a href="javascript:deleteCaseStudies('${c.id}');" class="caseStudies_delete">
		                  					<img src="${path}/img/delete-icon.png" width="20"/>
		                  				</a>
			               			</th>
			               		</tr>
			               </c:forEach>
			             </tbody>
			   </table>
          	</div>
          </div>
         
         <script type="text/javascript">
         
         	$(document).ready(function(){
         		
         		$("#caseStudy_add_btn").click(function(){
            		
            		var formData = new FormData($("#caseStudy_form").get(0));
            		var fileName = $("#caseStudy_file").val();
            		formData.append(fileName, $("#caseStudy_file"));
            		
            		var action = $("#caseStudy_file").attr("action");
            		
            		var xhr = new XMLHttpRequest();
           			xhr.open("POST",  action , true);
           			xhr.send(formData);
           			startLoadingBar();
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
      				// reloads the contacts
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
     
     </div>
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

<jsp:include page="../footer.jsp" />