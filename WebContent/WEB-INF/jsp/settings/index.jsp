<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="settings" />
    <jsp:param name="sub" value="../" />
</jsp:include>
		
		<!-- <ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Settings
        	</li>
      	</ul>  -->
		
		<div class="row">
        	<table border="0" style="width:100%;">
            	<tr>
              		<td style="width:20%;">
                		<table border="0" style="width:100%;">
                  			<tr>
                    			<td align="center">
                    				<img src="${path}/img/settings.png" width="80">
                    			</td>
                    			<td>
                    				<h3>Settings</h3>
                    			</td>
                    			<td style="width:80%;">
                				</td>
                  			</tr>
                		</table>
              		</td>
            	</tr>
          	</table>
      	</div>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span8" style="margin:0 auto;float:none;">
            	<ul class="unstyled">
            		<li><a href="${path}/settings/changePassword.do">Change Password</a></li>
      				<li><a href="${path}/settings/seeActivities.do">See Activities</a> - Shows the your latest activities in the system</li>
            	</ul>
        	</div>
		</div>	
		
<jsp:include page="../footer.jsp" />