<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="../header.jsp" />
	
	<div class="container">
		
		<ul class="breadcrumb">
        	<li>
          		<a href="#">Home</a>
          		<span class="divider">/</span>
        	</li>
        	<li class="active">
          		Clients
        	</li>
      	</ul>
		
		<div class="row">
        	<table border="0" style="width:100%;">
            	<tr>
              		<td style="width:20%;">
                		<table border="0" style="width:100%;">
                  			<tr>
                    			<td align="center">
                    				<img src="https://cdn1.iconfinder.com/data/icons/general04/png/256/clients.png" width="80">
                    			</td>
                    			<td>
                    				<h3>Clients</h3>
                    			</td>
                  			</tr>
                		</table>
              		</td>
              		<td style="width:80%;">
                		<a class="btn pull-right">New client</a>
              		</td>
            	</tr>
          	</table>
      	</div>
		
		<div class="row-fluid" style="margin-top:30px;">
         	<div class="span7" style="margin:0 auto;float:none;">
            	<form class="form-horizontal">
              		<div class="control-group">
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox1" value="option1">
                  			Name
                		</label>
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox2" value="option2">
                  			Contact person
                		</label>
                		<label class="radio inline">
                  			<input type="radio" id="inlineCheckbox3" value="option3">
                  			All
                		</label>
              		</div>
              		<div class="control-group">
                		<input type="text" class="input-xxlarge">
                		<button type="submit" class="btn">
                  			Search
                		</button>
              		</div>
            	</form>
        	</div>
		</div>	

<jsp:include page="../footer.jsp" />