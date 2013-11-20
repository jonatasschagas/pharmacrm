<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
 <%@ page pageEncoding="utf-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>

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