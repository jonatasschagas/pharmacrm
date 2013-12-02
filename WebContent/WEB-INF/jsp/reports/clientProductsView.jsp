<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="reports" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		<a href="${path}/reports/index.do">Reports</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Client x Products
        	</li>
      	</ul>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span16" style="margin:0 auto;float:none;">
            		<div class="control-group">
              			<label class="checkbox inline">
      						<input id="allTimes" name="allTimes" value="true" type="checkbox"> All Times
						</label>
              			<label class="radio inline" for="startDate">
                			From Date:
                			<input type="text" name="startDate" id="startDate" class="datepicker input-small" />	
                		</label>
    					<label class="radio inline" for="endDate">
    						To Date:
    						<input type="text" name="endDate" id="endDate" class="datepicker input-small" />
    					</label>
    					<label class="radio inline" for="product">
    						Client:
    						<select name="client" id="client" class="input-medium">
    							<option value=""></option>
    							<c:forEach items="${clients}" var="c"> 
    								<option value="${c.id}">${c.name}</option>
    							</c:forEach>
    						</select>
    					</label>
    					<label class="radio inline" for="generateReportBtn">
    						<a href="#" id="generateReportBtn" class="btn btn-info"><i class="icon-white icon-search"></i> Generate Report</a>
            			</label>
            		</div>
              </div>
		</div>	
		
		<div id="client_products_charts" style="height:800px;"></div>
		<div id="client_products_charts_script"></div>
		
		<script type="text/javascript">
		
			$(document).ready(function(){
				
				$("#generateReportBtn").click(function(){
					
					var startDate = $("#startDate").val();
					var endDate   = $("#endDate").val();
					var allTimes   = $("#allTimes").is(':checked')? "true" : "false";
					var client   = $("#client").val();
					
					if(client != "")
					{
						$.get("${path}reports/clientProducts.do", { startDate: startDate, endDate : endDate, allTimes: allTimes, client : client },
						        function(data){
									$("#client_products_charts_script").append(data);
								}
						);	
					}
					else
					{
						alert("Please select a Client.");	
					}
				});
				
			});
		</script>
<jsp:include page="../footer.jsp" />