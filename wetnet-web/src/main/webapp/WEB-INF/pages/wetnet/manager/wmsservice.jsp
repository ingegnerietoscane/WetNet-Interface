<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html ng-app="wetnetApp" >
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<jsp:include page="../../common/common-head.jsp" />

		<!-- disabilita il tasto enter per evitare l'invio del submit -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/script/disableEnterKey.js"></script>
	</head>

	<style>
	/* GC - 29/10/2015
	*  per dimensionare i campi di ricerca distretti /misure per angular js
	* posizionato qui per non essere sovrascritto da bootstrap
	*/
	.dropdown-menu {
		max-height: 250px;
		overflow-y: auto;
	}
	</style>
	<body>

		<div class="container-fluid" ng-controller="ManagerWmsServiceController">
			<jsp:include page="../../common/nav.jsp" />
			<form class="form-horizontal" role="form">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="form-group">
							<jsp:include page="../../common/alerts.jsp" />
							<div class="alert alert-info" role="alert" ng-show="confirmedAction">
								<spring:message code="wmsservice.form.delete.message.confirm" /><br/><button  ng-click="remove(wmsService)" class="alert-link"> <spring:message code="wmsservice.form.delete.message.confirm.ok" /></button> - <button ng-click="removeCancelled()" class="alert-link"><spring:message code="wmsservice.form.delete.message.confirm.cancel" /></button>
							</div>
						</div>
						<div class="form-group">
							<sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
								&nbsp;&nbsp; &nbsp;&nbsp;<button class="btn btn-success" ng-click="save(wmsService)"><spring:message code="wmsservice.form.save.button" /></button>
								<button class="btn btn-danger" ng-click="removeConfirm()" ng-show="wmsService.idwms_services"><spring:message code="wmsservice.form.delete.button" /></button>
							</sec:authorize>
							<button class="btn btn-info" ng-click="cancel()"><spring:message code="wmsservice.form.cancel.button" /></button>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title"><spring:message code="wmsservice.form.title.label" /></h3>
					</div>
					<div class="panel-body">

						<div class="form-group">
							<label for="name" class="col-sm-2 control-label"><spring:message code="wmsservices.form.name.label" /></label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="name" ng-model="wmsService.name" />
							</div>
						</div>
						<div class="form-group">
							<label for="url" class="col-sm-2 control-label"><spring:message code="wmsservices.form.url.label" /></label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="url" ng-model="wmsService.url" />
							</div>
						</div>
						<div class="form-group">
							<label for="layer" class="col-sm-2 control-label"><spring:message code="wmsservices.form.layer.label" /></label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="layer" ng-model="wmsService.layer" />
							</div>
						</div>
						<div class="form-group">
							<label for="role" class="col-sm-2 control-label"><spring:message code="wmsservices.form.server_type.label" /></label>
							<div class="col-sm-5">
								<select id="type" ng-model="wmsService.server_type" class="form-control input-sm">
									<option value="geoserver"><spring:message code="wmsservices.form.server_type.val.0" /></option>
									<option value="mapserver"><spring:message code="wmsservices.form.server_type.val.1" /></option>
									<option value="qgis"><spring:message code="wmsservices.form.server_type.val.2" /></option>
									<option value="carmentaserver"><spring:message code="wmsservices.form.server_type.val.3" /></option>
								</select>
							</div>
						</div>

					</div>
				</div>

			</form>

		</div>


		<jsp:include page="../../common/footer.jsp" />


	</body>


</html>
