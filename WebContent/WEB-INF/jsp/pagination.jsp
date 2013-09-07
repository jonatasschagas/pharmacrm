<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<div class="pagination">
  <ul>
	<c:if test="${currentPage > 0}">
		<li><a href="${param.link}?page=${currentPage - 1}&${param.parameters}">Prev</a></li>
	</c:if>
	<c:forEach begin="0" end="${numberOfPages}" var="i">
		<c:if test="${i == currentPage}">
			<li class="active"><a href="${param.link}?page=${i}&${param.parameters}">${i}</a></li>
		</c:if>
		<c:if test="${i != currentPage}">
			<li><a href="${param.link}?page=${i}&${param.parameters}">${i}</a></li>
		</c:if>
	</c:forEach>
	<c:if test="${currentPage < numberOfPages}">
		<li><a href="${param.link}?page=${currentPage + 1}&${param.parameters}">Next</a></li>
  	</c:if>
  </ul>
</div>