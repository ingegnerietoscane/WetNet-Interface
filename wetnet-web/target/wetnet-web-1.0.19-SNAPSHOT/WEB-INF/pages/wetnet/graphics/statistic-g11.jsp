<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html ng-app="wetnetApp">

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>
		<spring:message code="dashboard.graphics.g11.title" />
	</title>
	<script>
		// Initialize Spring messages as js variable
		var MESSAGE_SOURCE = {
			DISTRICTS_INHABITANTS_PERCENTAGE: '<spring:message code="statistic-g11.districts.inhabitants.percentage" />',
			EV_VARIABLE_TYPE_0: '<spring:message code="district.form.ev_variable_type.val.0" />',
			EV_VARIABLE_TYPE_1: '<spring:message code="district.form.ev_variable_type.val.1" />',
			EV_VARIABLE_TYPE_2: '<spring:message code="district.form.ev_variable_type.val.2" />',
			EV_VARIABLE_TYPE_3: '<spring:message code="district.form.ev_variable_type.val.3" />',
			EV_VARIABLE_TYPE_4: '<spring:message code="district.form.ev_variable_type.val.4" />'
		};
	</script>
	<jsp:include page="../../common/common-head.jsp" />

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

<body ng-controller="WetnetControllerG11">
	<div class="container-fluid">
		<jsp:include page="../../common/nav.jsp" />


		<h3><spring:message code="dashboard.graphics.g11.title" /></h3>
		<hr/>
	   	<div class="row">
	   		<div class="col-md-4">
				<div class="form-group">
					<div class="btn-group" dropdown is-open="status.isopen">
					      <button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
					        <spring:message code="statistic-g11.btn.saveDataAs" /><span class="caret"></span>
					      </button>
					      <ul class="dropdown-menu" role="menu">
								<li><a class="savePNG" id="barChart-savePNG" export-chart-id="barChart" export-chart="images" href="#"><spring:message code="statistic-g10.btn.saveDataAsPNG" /></a></li>
					      </ul>
			    	</div>
			    	<div class="btn-group" dropdown is-open="status2.isopen" on-toggle="exportCSV()">
					      <button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
					        <spring:message code="statistic-g11.btn.exportData" /><span class="caret"></span>
					      </button>
					      <ul class="dropdown-menu" role="menu">
					        <li><a href="/wetnet/rest/d3/g11/csv"><spring:message code="statistic-g11.btn.exportCSV" /></a></li>
					      </ul>
			     	</div>
		    	</div>
	    	</div>
	   	</div>

	   	<hr/>

		<div class="row">
			<h4 class="text-center"><spring:message code="statistic-g11.districts.inhabitants.percentage" /></h4>
			<div id="barChart" build-chart></div>
		</div>
	
		<div class="row">

			<div class="col-md-6 text-center">
				<h4><spring:message code="statistic-g11.boxplot.title" /> 0</h4>
				<div id="boxPlotChartL0"></div>
			</div>

			<div class="col-md-6 text-center">
				<h4><spring:message code="statistic-g11.boxplot.title" /> 1</h4>
				<div id="boxPlotChartL1"></div>
			</div>

		</div><hr/>

		<div class="row">

			<div class="col-md-6 text-center">
				<h4><spring:message code="statistic-g11.boxplot.title" /> 2</h4>
				<div id="boxPlotChartL2"></div>
			</div>

			<div class="col-md-6 text-center">
				<h4><spring:message code="statistic-g11.boxplot.title" /> 3</h4>
				<div id="boxPlotChartL3"></div>
			</div>

		</div><hr/>

			<div class="table-responsive col-md-6">
				<table class="table table-striped table-bordered">
					<thead class="text-center">
						<tr>
							<th><spring:message code="statistic-g11.level" /></th>
							<th><spring:message code="statistic-g11.level.ev_variable_type" /></th>
							<th><spring:message code="statistic-g11.districts.count" /></th>
							<th><spring:message code="statistic-g11.districts.inhabitants" /></th>
							<th><spring:message code="statistic-g11.districts.inhabitants.percentage" /></th>
						</tr>
					</thead>
					<tbody class="text-right">
						<tr ng-repeat="d in data">
							<td rowspan="5" ng-show="$index % 5 == 0">{{d.mapLevel}}</td>
							<td>{{d.eventVariableTypeLabel}}</td>
							<td>{{d.districtsCount}}</td>
							<td>{{d.districtsInhabitantsSum}}</td>
							<td>{{d.districtsInhabitantsPercetage}}%</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="col-md-6 text-center">
				<h4><spring:message code="statistic-g11.boxplot.title" /> 4</h4>
				<div id="boxPlotChartL4"></div>
			</div>

		</div>

		<jsp:include page="../../common/footer.jsp" />

		<!-- Utlizzato per l'export del grafico	-->
		<canvas id="canvas" width="1072px" height="676px" class="ng-hide"></canvas>
</body>

</html>