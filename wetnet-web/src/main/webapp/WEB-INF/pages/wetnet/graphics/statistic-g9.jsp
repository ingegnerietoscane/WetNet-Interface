<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html ng-app="wetnetApp" >
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<title><spring:message code="statistic-g9.head.title" /></title>
	<jsp:include page="../../common/common-head.jsp" />
	<script>
		
	</script>

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

<body ng-controller="WetnetControllerG9">
<div class="container-fluid">
  <jsp:include page="../../common/nav.jsp" />

	<div class="row">

        <div class="col-md-2">
            <div class="input-group">
              <label class="sr-only" for="date"><spring:message code="statistic-g9.form.date" /></label>
              <input id="date" type="text" class="form-control" datepicker-popup="yyyy-MM-dd" ng-model="date" is-open="openedDate" close-text="<spring:message code='statistic-g9.form.close'/>" />
              <div class="input-group-btn">
                <button type="button" class="btn btn-default" ng-click="openDate($event)"><i class="glyphicon glyphicon-calendar"></i></button>
              </div>
            </div>
        </div>

        <div class="col-md-3">
			<div class="form-group">
				<input tooltip="<spring:message code='statistic-g9.form.districts.tooltip'/>" placeholder="<spring:message code='statistic-g9.form.districts.placeholder' />" type="text" ng-model="dSelected" typeahead-on-select="districtSelectedShow($item, $model, $label)" typeahead="d as d.name for d in districts | filter:$viewValue | limitTo:districts.length" class="form-control">
	       	</div>
       	</div>

    	<div class="col-md-3" ng-show="selectedDistrict != null">
	    	<div class="form-group">
	    		<button type="button" class="btn btn-info">{{selectedDistrict.name}}</button>
	   		</div>
   		</div>

	</div>

	<div class="row">
		<div class="col-md-2">
			<div class="form-group">
				<button id="loadData" ng-click="loadData()" class="btn btn-default"><spring:message code="statistic-g9.form.button.update"/></button>
			</div>
		</div>

		<!-- <div class="col-md-1">
			<button class="btn btn-danger" ng-click="showDialog()"><spring:message code="configuration.button.configure" /></button>
		</div> -->

   		<div class="col-md-4">
			<div class="form-group">
				<div class="btn-group" dropdown is-open="status.isopen">
					<button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
						<spring:message code="statistic-g9.form.button.saveDataAs" /><span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a class="savePNG" id="g9-chart-savePNG" export-chart-id="g9-chart" export-chart="images" href="#"><spring:message code="statistic-g9.form.button.saveDataAsPNG" /></a></li>
					</ul>
				</div>
				<div class="btn-group" dropdown is-open="status2.isopen">
					<button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
						<spring:message code="statistic-g9.form.button.exportData" /><span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a id="exportCSV" href="#" ng-click="exportCSV()"><spring:message code="statistic-g9.form.button.exportCSV" /></a></li>
					</ul>
				</div>
			</div>
	    </div>

	</div>

  	<center ng-show="data.length > 0">
  		<h4>{{graphTitle}}</h4>
  	</center>

  	<div class="row chart-wrap">
		<div class="chart-left-control" ng-show="data.length > 0">
			<div class="form-group"><input ng-model="maxY" class="form-control input-xs" type="number" placeholder="Max"></div>
			<div class="form-group"><input ng-model="minY" class="form-control input-xs" type="number" placeholder="Min"></div>
		</div>
	 	<div id="g9-chart" class="chart" build-chart></div>
	</div>

 </div>

<jsp:include page="../../common/footer.jsp" />

<!-- Utlizzato per l'export del grafico	-->
<canvas id="canvas" width="1072px" height="676px" class="ng-hide"></canvas>
</body>

</html>
