<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html ng-app="wetnetApp">
    <head>
    	<meta name="viewport" content="width=device-width, initial-scale=1"/>
    	<title><spring:message code="statistic-g6.head.title" /></title>
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

<body ng-controller="WetnetControllerG6">

<div class="container-fluid">	
	<jsp:include page="../../common/nav.jsp" />
	<div class="row">
        <div class="col-md-2">
            <p class="input-group bootstrap-datepicker-correction">
              <label class="sr-only" for="startDate"><spring:message code="statistic-g6.form.startDate" /></label>
              <input id="startDate" type="text" class="form-control" datepicker-popup="yyyy-MM-dd" ng-model="formBean.startDate" is-open="openedStartDate"  />
              <span class="input-group-btn">
                <button type="button" class="btn btn-default" ng-click="openStartDate($event)"><i class="glyphicon glyphicon-calendar"></i></button>
              </span>
   			</p>
   		</div>
        <div class="col-md-2">
            <p class="input-group bootstrap-datepicker-correction">
              <label class="sr-only" for="endDate"><spring:message code="statistic-g6.form.endDate" /></label>
              <input id="endDate" type="text" class="form-control" datepicker-popup="yyyy-MM-dd" ng-model="formBean.endDate" is-open="openedEndDate"  />
              <span class="input-group-btn">
                <button type="button" class="btn btn-default" ng-click="openEndDate($event)"><i class="glyphicon glyphicon-calendar"></i></button>
              </span>
            </p>
        </div>

		<div class="col-md-4">
	    	<jsp:include page="../../common/datetime-selector.jsp" />
    	</div>
  		</div>
  		
   	<div class="row">
    	<div class="col-md-4">
	    	<div class="form-group">
	   			<input tooltip="<spring:message code="statistic-g6.form.districts.tooltip" />" placeholder="<spring:message code="statistic-g6.form.districts.placeholder" />" type="text" ng-model="dSelected" typeahead-on-select="districtSelectedAdd($item, $model, $label)" typeahead="d as d.name for d in districts | filter:$viewValue | limitTo:districts.length" class="form-control">
	   		</div>
   		</div>
   		<div class="col-md-4">
	   		<div class="form-group">
	   			<input tooltip="<spring:message code="statistic-g6.form.municipalities.tooltip" />" placeholder="<spring:message code="statistic-g6.form.municipalities.placeholder" />" type="text" ng-model="mSelected" typeahead-on-select="municipalitySelectedAdd($item, $model, $label)" typeahead="m as m for m in municipalities | filter:$viewValue | limitTo:municipalities.length" class="form-control">
	   		</div>
   		</div>
   		<div class="col-md-4">
	   		<div class="form-group">
	   			<input tooltip="<spring:message code="statistic-g6.form.zones.tooltip" />" placeholder="<spring:message code="statistic-g6.form.zones.placeholder" />" type="text" ng-model="zSelected" typeahead-on-select="zoneSelectedAdd($item, $model, $label)" typeahead="z as z for z in zones | filter:$viewValue | limitTo:zones.length" class="form-control">
	   		</div>
   		</div>
   	</div>
   	
	<div class="row">
		<div class="col-md-4">
			<label ng-show="formBean.districtsSelected.length > 0"><spring:message code="statistic-g6.form.selectedDistricts" /></label>
	    	<div class="form-group">
	    		<button type="button" class="btn btn-info"  tooltip="<spring:message code="statistic-g6.form.selected-tooltip" />"  ng-repeat="item in formBean.districtsSelected" ng-click="districtSelectedRemove(item)">{{item.name}}</button>
   			</div>
   		</div>
		<div class="col-md-4">
			<label ng-show="formBean.municipalitySelected.length > 0"><spring:message code="statistic-g6.form.selectedMunicipalities" /></label>
		    <div class="form-group">
		    	<button type="button" class="btn btn-info"  tooltip="<spring:message code="statistic-g6.form.selected-tooltip" />"  ng-repeat="item in formBean.municipalitySelected" ng-click="municipalitySelectedRemove(item)">{{item}}</button>
	   		</div>
   		</div>
   		<div class="col-md-4">
			<label ng-show="formBean.zoneSelected.length > 0"><spring:message code="statistic-g6.form.selectedZones" /></label>
		    <div class="form-group">
		    	<button type="button" class="btn btn-info"  tooltip="<spring:message code="statistic-g6.form.selected-tooltip" />"  ng-repeat="item in formBean.zoneSelected" ng-click="zoneSelectedRemove(item)">{{item}}</button>
	   		</div>
   		</div>
	</div>

   	<div class="row">
   		<div class="col-md-1">
	   		<div class="form-group">
	   			<button id="loadChartData" name="loadChartData" ng-click="loadChartData()" class="btn btn-default" ><spring:message code="statistic-g6.form.button.update" /></button>
	   		</div>
   		</div>
   		<div class="col-md-4">
			<div class="form-group">
				<div class="btn-group" dropdown is-open="status.isopen">
				      <button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
				        <spring:message code="statistic-g6.form.button.saveDataAs" /><span class="caret"></span>
				      </button>
				      <ul class="dropdown-menu" role="menu">
							<li><a class="savePNG" id="g6-chart-savePNG" export-chart-id="g6-chart" export-chart="images" href="#"><spring:message code="statistic-g6.form.button.saveDataAsPNG" /></a></li>
				      </ul>
		    	</div>
		    	<div class="btn-group" dropdown is-open="status2.isopen" on-toggle="exportCSV()">
				      <button type="button" class="btn btn-primary dropdown-toggle" ng-disabled="disabled">
				        <spring:message code="statistic-g6.form.button.exportData" /><span class="caret"></span>
				      </button>
				      <ul class="dropdown-menu" role="menu">
				        <li><a id="exportCSV" href="#"><spring:message code="statistic-g6.form.button.exportCSV" /></a></li>
				      </ul>
		     	</div>
	    	</div>
    	</div>
   	</div>

	<div class="row chart-wrap">
		<div class="chart-left-control" ng-show="columnsSize > 0">
			<div class="form-group"><input ng-model="maxY" class="form-control input-xs" type="number" placeholder="Max"></div>
			<div class="form-group"><input ng-model="minY" class="form-control input-xs" type="number" placeholder="Min"></div>
		</div>
	 	<div id="g6-chart" class="chart" build-chart></div>
	</div>

	<div class="row" ng-show="columnsSize == 0">
		<div class="col-md-12">
			<h2><spring:message code="statistic-g6.chart.result" /></h2>
		</div>
	</div>

	<div class="footer-wetnet">
		<jsp:include page="../../common/footer.jsp" />
	</div>
	
	<!-- Utlizzato per l'export del grafico	-->
	<canvas id="canvas" width="1072px" height="676px" class="ng-hide"></canvas>
</div>

</body>
</html>

