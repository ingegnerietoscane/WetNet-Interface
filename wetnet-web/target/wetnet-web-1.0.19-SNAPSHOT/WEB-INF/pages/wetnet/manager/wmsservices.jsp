<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html ng-app="wetnetApp" >
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<jsp:include page="../../common/common-head.jsp" />
</head>
<body>
  
<div class="container-fluid" ng-controller="ManagerWmsServicesController">
<jsp:include page="../../common/nav.jsp" />

    <div class="row">
	    <div class="col-md-12">
            <sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
                <a class="btn btn-default" href="<c:url value="/wetnet/manager/wmsservice" />"><spring:message code="wmsservices.form.addWmsService.button" /></a>
            </sec:authorize>
	    </div>
	</div>

   	<div class="row">
   		<div class="col-md-12">
			<div class="table-responsive">
			  <table class="table table-striped table-condensed">
			  <thead>
			  <tr>
			  <th><spring:message code="wmsservices.table.name" /></th>
			  <th><spring:message code="wmsservices.table.url" /></th>
			  <th><spring:message code="wmsservices.table.layer" /></th>
			  <th><spring:message code="wmsservices.table.server_type" /></th>
			  <th></th>
			  </tr>
			  </thead>
			  <tbody>
			  <tr ng-repeat="wms in wmsservices">
			  	<td>{{wms.name}}</td>
			  	<td>{{wms.url}}</td>
			  	<td>{{wms.layer}}</td>
			  	<td>{{wms.server_type}}</td>
			  	<td><a href="<c:url value="/wetnet/manager/wmsservice?id={{wms.idwms_services}}" />" type="button" class="btn btn-default">
			  		<sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
				  		<spring:message code="users.table.edit" />
			  		</sec:authorize>
			  		<sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
				  		<spring:message code="users.table.view" />
			  		</sec:authorize>
			  	</a></td>
			  </tr>
			  </tbody>
			  </table>
			</div>
   		</div>
   	</div>


</div>

  
<jsp:include page="../../common/footer.jsp" />
  
  
</body>


</html>
