<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="header.jsp" />
  	
  	<style type="text/css">
      /* Override some defaults */
      html, body {
        background-color: white;
      }
      body {
        padding-top: 40px; 
      }
      .container {
        width: 300px;
      }

      /* The white background content wrapper */
      .container > .content {
        background-color: #fff;
        padding: 20px;
        margin: 30% -20px; 
        -webkit-border-radius: 10px 10px 10px 10px;
           -moz-border-radius: 10px 10px 10px 10px;
                border-radius: 10px 10px 10px 10px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
                box-shadow: 0 1px 2px rgba(0,0,0,.15);
      }

	  .login-form {
		margin-left: 65px;
	  }
	
	  legend {
		margin-right: -50px;
		font-weight: bold;
	  	color: #404040;
	  }

    </style>
  	
		
  	<div class="container">
		<div class="content">
			<div class="row">
		    	<div class="login-form">
		        	<h3>Login</h3>
		          	<form action="login.do" method="POST">
		            	<fieldset>
		              		<div class="clearfix">
		                		<input type="text" id="email" name="email" placeholder="Email">
		              		</div>
		              		<div class="clearfix">
		                		<input type="password" id="password" name="password" placeholder="Password">
		              		</div>
		              		<button class="btn primary" type="submit">Sign in</button>
		              		<a href="#">I forgot my password</a>
		            	</fieldset>
		          	</form>
		        </div>
			</div>
		</div>
	</div> <!-- /container -->
  		
<jsp:include page="footer.jsp" />