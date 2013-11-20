<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" >
    <jsp:param name="pageName" value="settings" />
    <jsp:param name="sub" value="../" />
</jsp:include>
	
		<ul class="breadcrumb">
        	<li>
          		<a href="${path}/index.do">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li>
          		<a href="${path}/settings/index.do">Settings</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Change Password
        	</li>
      	</ul>
		
		<div class="well">
        <form class="form-horizontal" method="POST" action="changePassword.do">
          <div class="row">
          		<div class="span6">
	              <div class="control-group">
		            <label class="control-label">Current Password:</label>
		            <div class="controls">
		              <input type="password" class="input-xxlarge" name="currentPassword" id="currentPassword" value="">
		            </div>
		          </div>
		         </div>
		  </div>
		  <div class="row">
          		<div class="span6">
	              <div class="control-group">
		            <label class="control-label">New Password:</label>
		            <div class="controls">
		              <input type="password" class="input-xxlarge" name="newPassword" id="newPassword" value="">
		            </div>
		          </div>
		         </div>
		  </div>	
          <div class="row">
          		<div class="span6">
	              <div class="control-group">
		            <label class="control-label">Confirm New Password:</label>
		            <div class="controls">
		              <input type="password" class="input-xxlarge" name="confirmPassword" id="confirmPassword" value="">
		            </div>
		          </div>
		         </div>
		  	</div>	
    	
          <div class="row">
          		<div class="span8">
	          		<div class="control-group">
			            <div class="controls">	
			              <button type="submit" class="btn btn-primary">Change Password</button>
			            </div>
			    	</div>
	          	</div>
          </div>
          
        </form>
        
      </div>

<jsp:include page="../footer.jsp" />