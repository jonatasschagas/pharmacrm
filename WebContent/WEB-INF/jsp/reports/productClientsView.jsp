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
          		Product x Clients
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
    						Product:
    						<select name="product" id="product" class="input-medium">
    							<option value=""></option>
    							<c:forEach items="${products}" var="p"> 
    								<option value="${p.id}">${p.name}</option>
    							</c:forEach>
    						</select>
    					</label>
    					<label class="radio inline" for="generateReportBtn">
    						<a href="#" id="generateReportBtn" class="btn btn-info"><i class="icon-white icon-search"></i> Generate Report</a>
            			</label>
            		</div>
              </div>
		</div>	
		
		<div id="products_clients_charts" style="height:800px;"></div>
		<div id="products_clients_charts_script"></div>
		
		<script type="text/javascript">
		
			$(document).ready(function(){
				
				$("#generateReportBtn").click(function(){
					
					var startDate = $("#startDate").val();
					var endDate   = $("#endDate").val();
					var allTimes   = $("#allTimes").is(':checked')? "true" : "false";
					var product   = $("#product").val();
					
					if(product != "")
					{
						$.get("${path}reports/productClients.do", { startDate: startDate, endDate : endDate, allTimes: allTimes, product : product },
						        function(data){
									$("#products_clients_charts_script").append(data);
								}
						);	
					}
					else
					{
						alert("Please select a Product.");	
					}
				});
				
			});
		</script>
<jsp:include page="../footer.jsp" />