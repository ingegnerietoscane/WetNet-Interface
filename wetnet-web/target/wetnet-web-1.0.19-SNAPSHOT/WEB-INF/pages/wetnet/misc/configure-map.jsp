<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html ng-app="wetnetApp">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title><spring:message code="configure-map.head.title" /></title>
	<jsp:include page="../../common/common-head.jsp" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/script/lib/bootstrap.file-input.js"></script>
</head>
<body>
<div class="container-fluid" ng-controller="ConfigMapController">
    <%System.out.println("SETT2017 (Mappa > configura mappa) configure-map.jsp > ConfigMapController");%>

<jsp:include page="../../common/nav.jsp" />

	
	
	<div class="panel panel-default">
		<div class="panel-body">
 			  <div class="form-group">
					<jsp:include page="../../common/alerts.jsp" />
			  </div>			  
			  <div class="form-group">
			          <button class="btn btn-success" ng-click="save()"><spring:message code="configure-map.form.save" /></button>
			  </div>
		  </div>
	</div>	
	<form method="POST" action="save-config" class="form-inline" role="form">
	<!-- Pannello Generale -->			
	<div class="panel panel-default">
  		<div class="panel-heading">
    		<h3 class="panel-title"><spring:message code="configure-map.head.title" /></h3>
  		</div>
  		<div class="panel-body">
  		
  			<!-- Areal upload -->
			<div class="row">
		        <div class="col-md-6">
		        <div class="form-group  form-group-sm">
				    <label for="name"><small><spring:message code="configure-map.form.zoom" /></small></label>
				    <div>
				     <input type="number" step="1" class="form-control input-sm" id="zoom" ng-model="zoom" />
				    </div>
				  </div>
				  <br>
				  <div class="form-group  form-group-sm">
				    <label for="name"><small><spring:message code="configure-map.form.lat" /></small></label>
				    <div>
				     <input type="number" step="0.5" class="form-control input-sm" id="lat" ng-model="lat" />
				    </div>
				  </div>
				  <br>
				   <div class="form-group  form-group-sm">
				    <label for="name"><small><spring:message code="configure-map.form.long" /></small></label>
				    <div>
				     <input type="number" step="0.5" class="form-control input-sm" id="long" ng-model="long" />
				    </div>
				  </div>
				  
		        	
		   		</div>
	   		</div>


		</div>
	</div>
	
	</form>
	
</div>

  
<jsp:include page="../../common/footer.jsp" />
  
  
</body>

</html>
