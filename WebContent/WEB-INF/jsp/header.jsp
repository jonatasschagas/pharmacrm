<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">
	<head>
    	<title>PharmaSynth CRM</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<meta charset="utf-8">
    	<link href="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"  rel="stylesheet">
	    <link rel="stylesheet" href="${path}/css/bootstrap.css" media="screen">
    	<link rel="stylesheet" href="${path}/css//font-awesome.min.css">
	</head>
  	<body>
  		
		<div class="navbar navbar-inverse navbar-fixed-top">
	    	<div class="navbar-inner">
	        	<div class="container">
	          		<a class="brand" href="index.html">
	            		Pharmasynth CRM
	          		</a>
	          		<div class="nav-collapse collapse">
			            <ul class="nav">
			              <li class="active">
			                <a href="clients/index.do">
			                  Clients
			                </a>
			              </li>
			              <li>
			                <a href="clients/index.do">
			                  Products
			                </a>
			              </li>
			              <li>
			                <a href="clients/index.do">
			                  Orders
			                </a>
			              </li>
			              <li>
			                <a href="clients/index.do">
			                  Reports
			                </a>
			              </li>
			              <li>
			                <a href="clients/index.do">
			                  Documents
			                </a>
			              </li>
			              <li>
			                <a href="clients/index.do">
			                  Settings
			                </a>
			              </li>
			            </ul>
			          </div>
	          		<a class="btn pull-right">Logout</a>
	          		<!--/.nav-collapse -->
	        	</div>
	      	</div>
	    </div>
		  		
  		<div class="container">
			
		
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
          
       <c:if test='${not empty success || not empty param.success}'>
          <div class="row">
	          <div class="col-lg-12">
	            <div class="alert alert-dismissable alert-success">
	              <button type="button" class="close" data-dismiss="alert">×</button>
	              	<strong>Success</strong>
	              	<br/>
	              	<c:if test='${not empty success}'>
		  				${success}
		  			</c:if>
		  			<c:if test='${not empty param.success}'>
		  				${param.success}
		  			</c:if> 
	            </div>
	          </div>
          </div>
		</c:if>
        	