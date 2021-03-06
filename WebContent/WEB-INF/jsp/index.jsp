<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<jsp:include page="header.jsp" />

	  <table style="text-align:center;" border="0" cellpadding="40" align="center">
        <tbody>
          <tr>
            <td>
              <a href="${path}/clients/index.do">
              	<img src="${path}/img/clients.png" width="80px">
	            <div class="icon_text">Clients</div>
              </a>
            </td>
            <td>
              <a href="${path}/products/index.do">
              	<img src="${path}/img/products.png" width="80px">
	            <div class="icon_text">Products</div>
              </a>
            </td>
            <td>
              <a href="${path}/orders/index.do">
              	<img src="${path}/img/orders.png" width="80px">
	            <div class="icon_text">Orders</div>
              </a>
            </td>
          </tr>
          <tr>
            <td>
              <a href="${path}/reports/index.do">
              	<img src="${path}/img/reports.png" width="80px">
	            <div class="icon_text">Reports</div>
              </a>
            </td>
            <td>
              <img src="${path}/img/documents.png" alt="Documents" width="80px ">
              <div class="icon_text">
                Documents
              </div>
            </td>
            <td>
              <a href="${path}/settings/index.do">
              	<img src="${path}/img/settings.png" width="80px">
	            <div class="icon_text">Settings</div>
              </a>
            </td>
          </tr>
        </tbody>
      </table>


	 <div class="container ">
		<table class="table table-striped ">
	             <thead>
	               <tr>
	                 <th>Activity Log</th>
	               </tr>
	             </thead>
	               <tbody><tr>
	                 <td>Anca Agapi</td>
	                 <td>12/04/2013</td>
	                 <td>Added NARD as new client</td>
	               </tr>
	               <tr>
	                 <td>Olavi Logg</td>
	                 <td>14/05/2013</td>
	                 <td>Added PE2I as new product</td>
	               </tr>
	               <tr>
	                 <td>Anca Agapi</td>
	                 <td>01/06/2013</td>
	                 <td>Updated KI contact person</td>
	               </tr>
	             </tbody>
	   </table>
	 </div>

<jsp:include page="footer.jsp" />