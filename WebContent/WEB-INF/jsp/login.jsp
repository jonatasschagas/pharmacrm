<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="header.jsp" />
  		
		<div class="hero-unit">
			<form class="form-horizontal" action="login.do" method="POST">
			<legend>Login</legend>
			  <div class="control-group">
			    <label class="control-label" for="email">E-mail</label>
			    <div class="controls">
			      <input type="text" id="email" name="email" placeholder="Email">
			    </div>
			  </div>
			  <div class="control-group">
			    <label class="control-label" for="inputPassword">Password</label>
			    <div class="controls">
			      <input type="password" id="password" name="password" placeholder="Password">
			    </div>
			  </div>
			  <div class="control-group">
			    <div class="controls">
			      <button type="submit" class="btn">Sign in</button>
			    </div>
			  </div>
			</form>
		</div>


<jsp:include page="footer.jsp" />