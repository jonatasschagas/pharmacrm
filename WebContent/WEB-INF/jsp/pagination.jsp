<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<div class="pagination">
  <ul>
  	<c:set var="ommit" value="false"/>
	<c:if test="${currentPage > 0}">
		<li><a href="${param.link}?page=${currentPage - 1}&${param.parameters}">Prev</a></li>
	</c:if>
	<c:if test="${currentPage - 2 > 0}">
		<li><a href="">...</a></li>
	</c:if>
	<c:forEach begin="0" end="${numberOfPages}" var="i">
		<c:if test="${i == currentPage}">
			<li class="active"><a href="${param.link}?page=${i}&${param.parameters}">${i + 1}</a></li>
		</c:if>
		<c:choose>
			<c:when test="${i != currentPage && (i < (currentPage + 2) && i > (currentPage - 2))}">
				<li><a href="${param.link}?page=${i}&${param.parameters}">${i + 1}</a></li>
			</c:when>
			<c:otherwise>
				<c:set var="ommit" value="true"/>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${ommit && !(currentPage + 2 > numberOfPages)}">
		<li><a href="">...</a></li>
	</c:if>
	<c:if test="${currentPage < numberOfPages}">
		<li><a href="${param.link}?page=${currentPage + 1}&${param.parameters}">Next</a></li>
  	</c:if>
  </ul>
</div>