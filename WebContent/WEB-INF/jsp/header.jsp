<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
 <%@ page pageEncoding="utf-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>

<!DOCTYPE html> 
<html lang="en">
	<head>
    	<title>PharmaSynth CRM</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<meta charset="utf-8">
    	<link rel="shortcut icon" type="image/x-icon" href="${path}img/favicon.ico">
    	<link rel="stylesheet" href="${path}/css/bootstrap.css" >
    	<link rel="stylesheet" href="${path}/css/bootstrap.min.css">
    	<link rel="stylesheet" href="${path}/css/bootstrap-responsive.css">
    	<link rel="stylesheet" href="${path}/css/bootstrap-responsive.min.css" >
    	<link rel="stylesheet" href="${path}/css/bootstrap.jet.css">
    	<link rel="stylesheet" href="${path}/css/datepicker.css">
    	<link rel="stylesheet" href="${path}/css/pharmacrm.css">
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    	<script type="text/javascript" src="${path}/js/bootstrap.js"></script>
    	<script type="text/javascript" src="${path}/js/bootstrap.min.js"></script>
    	<script type="text/javascript" src="${path}/js/bootstrap-tooltip.js"></script>
    	<script type="text/javascript" src="${path}/js/bootstrap-popover.js"></script>

		<script src="${path}/js/highcharts.js"></script>
		<script src="${path}/js/exporting.js"></script>
    	
    	<script src="${path}js/bootstrap-datepicker.js"></script>
    	<script src="${path}js/functions.js"></script>
		
		<script type="text/javascript">
		
			$(document).ready(function(){
			    $('.datepicker').datepicker({format : 'yyyy-mm-dd'});
			});
		
		</script>
		
		<style media="print">
		  .noPrint{ display: none; }
		  .yesPrint{ display: block !important; }
		</style>
		
				
	</head>
  	<body>
  		
		<div class="navbar navbar-inverse navbar-fixed-top noPrint">
	    	<div class="navbar-inner">
	        	<div class="container">
	        		<table>
	        			<tr>
	        				<td>
	        					<img src="${path}img/small_logo.png"/>	
	        				</td>
	        				<td>
	        					<span class="brand">
				            		PharmaSynth CRM
				          		</span>
				        	</td>
			        		<td style="vertical-align: bottom;">
				        		<c:if test='${not empty logged_in && param.pageName != null}'>
					          		<div class="nav-collapse collapse">
							            <ul class="nav">
							              <li <c:if test="${param.pageName == 'clients'}">class="active"</c:if>>
							                <a href="${path}/clients/index.do">
							                  	Clients
							                </a>
							              </li>
							              <li <c:if test="${param.pageName == 'products'}">class="active"</c:if>>
							                <a href="${path}/products/index.do">
							                  	Products
							                </a>
							              </li>
							              <li <c:if test="${param.pageName == 'orders'}">class="active"</c:if>>
							                <a href="${path}/orders/index.do">
							                	Orders
							                </a>
							              </li>
							             <li <c:if test="${param.pageName == 'reports'}">class="active"</c:if>>
							                <a href="${path}/reports/index.do">
							                	Reports
							                </a>
							              </li>
							              <li>
							                <a href="#">
							                  Documents
							                </a>
							              </li>
							              <li <c:if test="${param.pageName == 'settings'}">class="active"</c:if>>
							                <a href="${path}/settings/index.do">
							                	Settings
							                </a>
							              </li>
							              <li>
							                <a href="${path}/logout.do">Logout</a>
							              </li>
							            </ul>
							          </div>
				          			<!--/.nav-collapse -->
				          			</c:if>
			          		</td>
			          		<td style="vertical-align: bottom;">
			          			
			          		</td>
	          			</tr>
	        		</table>
	        		
	        	</div>
	      	</div>
	    </div>
		
		<div class="container body-container">
		
		<jsp:include page="validation_messages.jsp" />
        	