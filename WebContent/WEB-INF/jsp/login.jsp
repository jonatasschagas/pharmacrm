<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="header.jsp" />

	    	<div class="row">
	    		<div class="col-lg-12">
	    			<div class="well">
	    				<form name="login_form" id="login_form" action="${path}/login.do" method="POST" class="form-horizontal">
	    					<fieldset>
	    						<legend>Login</legend>
	    						<div class="form-group">
	    							<label for="email" class="col-lg-2 control-label">E-mail</label>
	    							<div class="col-lg-5">
				                    	<input type="email" class="form-control" id="email" name="email" placeholder="E-mail">
				                    </div>
	    						</div>
	    						<div class="form-group">
	    							<label for="password" class="col-lg-2 control-label">Password</label>
	    							<div class="col-lg-5">
				                    	<input type="password" class="form-control" id="password" name="password" placeholder="Password">
				                    </div>
	    						</div>
	    						<div class="form-group">
				                    <div class="col-lg-10 col-lg-offset-2">
				                    	<button type="submit"  class="btn btn-primary">Login</button> 
                    				</div>
	  			                </div>
	    					</fieldset>
	    				</form>
	    			</div>
	    		</div>
	    	</div>


<jsp:include page="footer.jsp" />