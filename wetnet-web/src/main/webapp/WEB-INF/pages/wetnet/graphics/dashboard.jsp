<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html ng-app="wetnetApp">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title><spring:message code="dashboard.head.title" /></title>
<jsp:include page="../../common/common-head.jsp" />
<link href="<c:url value="/css/ol.css" />" type="text/css" rel="stylesheet" />
<link href="<c:url value="/css/map.css" />" type="text/css" rel="stylesheet" />
<!-- <script src="https://maps.google.com/maps/api/js?v=3"></script> -->
<!-- utilizzo openlayer 3 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/script/lib/ol.js"></script>
<script>
	$(document).ready(function(){
		dragElement(document.getElementById('district-measures'));
	});
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

/* GC - 05/11/2015 
		*  cambio colore alle iconcine del menu mappa
		*/
.icon-white {
	color: #FFFFFF;
}
/* GC - 05/11/2015 
		*  disabilito bullet per liste
		*/
.no_bullet li
{
list-style-type: none;
}
/* Ristringe popup sulla mappa */
#map .popover-title, #map .popover-content {
    font-size: 12px;
    padding-top: 2px;
    padding-bottom: 2px;
}
</style>


<body ng-controller="DashboardController">

	<div class="container-fluid">
		<jsp:include page="../../common/nav.jsp" />

		<!-- Pannello Ricerca -->
		 <sec:authorize access="!hasRole('ROLE_METER_READER')">
		<div class="row">
			<div class="col-md-3">
				<div class="form-group">
					<input
						tooltip="<spring:message code="dashboard.form.districts.tooltip" />"
						placeholder="<spring:message code="dashboard.form.districts.placeholder" />"
						type="text" ng-model="dSelected"
						typeahead-on-select="districtSelectedZoom($item, $model, $label)"
						typeahead="d as d.name for d in districts | filter:$viewValue | limitTo:districts.length"
						class="form-control">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input
						tooltip="<spring:message code="dashboard.form.measures.tooltip" />"
						placeholder="<spring:message code="dashboard.form.measures.placeholder" />"
						type="text" ng-model="mSelected"
						typeahead-on-select="measureSelectedZoom($item, $model, $label)"
						typeahead="d as d.name for d in measures | filter:$viewValue | limitTo:measures.length"
						class="form-control">
				</div>
			</div>
			<div class="col-md-2">
				<p class="input-group bootstrap-datepicker-correction">
					<label class="sr-only" for="endDate"><spring:message
							code="dashboard.form.endDate" /></label> <input id="endDate" type="text"
						class="form-control" datepicker-popup="yyyy-MM-dd"
						ng-model="eventBean.endDate" is-open="openedEndDate"
						ng-change="loadEvents()" /> <span class="input-group-btn">
						<button type="button" class="btn btn-default"
							ng-click="openEndDate($event)">
							<i class="glyphicon glyphicon-calendar"></i>
						</button>
					</span>
				</p>
			</div>
			<div class="col-md-4" ng-show="eventBean.districtsSelected">
				<div class="form-group">
					<button type="button" class="btn btn-info"
						tooltip="<spring:message code="dashboard.district.remove.tooltip" />"
						ng-click="removeDistrict()">{{eventBean.districtsSelected.name}}</button>
					<sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
						<a
							href="<c:url value="/wetnet/manager/district?id={{eventBean.districtsSelected.idDistricts}}" />"
							class="btn btn-success"
							tooltip="<spring:message code="dashboard.button.modify-title" />"><spring:message
								code="dashboard.button.modify" /></a>
					</sec:authorize>
					<sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
						<a
							href="<c:url value="/wetnet/manager/district?id={{eventBean.districtsSelected.idDistricts}}" />"
							class="btn btn-success"
							tooltip="<spring:message code="dashboard.button.show-title" />"><spring:message
								code="dashboard.button.modify" /></a>
					</sec:authorize>
				</div>
			</div>
		</div>
	</sec:authorize>
		<!-- Pannello Mappa -->
		<div class="row">
			<div class="col-md-12">
				<div class="form-group">
					<div id="map" class="dashboardmap">
						<div id="popup"></div>
					</div>
					<!--  <div id="toolbox" class="dropdown">
						<a href="#" class="dropdown-toggle map-link" title="<spring:message code="dashboard.panel.head.title" />"><spring:message code="dashboard.panel.head.menu" /></a>
						-->

					<!-- GC 05/11/2015 -->
					<div id="toolbox" class="dropdown keep-open">
						<button id="dLabel" role="button" href="#" data-toggle="dropdown" data-target="#" class="btn btn-primary map-link">
							<spring:message code="dashboard.panel.head.menu" />
							<span class="caret"></span>
						</button>
						<ul id="layerswitcher" class="dropdown-menu left" role="menu">
							<li><label><input type="radio" name="layer" value="0" ng-change="switchLayer(0)" ng-model="radioItem">
									<spring:message code="dashboard.panel.general.osmmap" /></label></li>
							
							<li><label><input type="radio" name="layer" value="1" ng-change="switchLayer(1)" ng-model="radioItem">
									<spring:message code="dashboard.panel.general.osmmapquest" /></label></li>
							
							<li><label><input type="radio" name="layer" value="2" ng-change="switchLayer(2)" ng-model="radioItem">
									<spring:message code="dashboard.panel.general.satellitemap" /></label></li>
							
							<li><label><input type="radio" name="layer" value="3" ng-change="switchLayer(3)" ng-model="radioItem">
									<spring:message code="dashboard.panel.general.hybridmap" /></label></li>
							
							<li class="divider"></li>
							
							<li><!-- <input type="checkbox" name="layer" ng-change="updateDistrictsCheck()" ng-model="showDistricts">-->
								<label><spring:message code="dashboard.panel.check.districts" />
								 <!-- GC 05/11/2015 -->
									<a data-toggle="collapse" href="#districtsCollapse"><span class="caret icon-white"></span></a></label>
								<div id="districtsCollapse" class="collapse">

									<ul class="no_bullet">
										<li><input type="checkbox" name="layer" ng-change="makeDistrictsVisible();updateDistrictsLevelsCheck()" ng-model="showDistrictsLevels">
											<label><spring:message code="dashboard.panel.check.districts.levels" />
												<!-- GC 05/11/2015 --> 
												<a data-toggle="collapse" href="#districtsLevelsCollapse"><span class="caret icon-white"></span></a></label>
												<div id="districtsLevelsCollapse" class="collapse">
													<ul class="no_bullet">
														<li><input type="checkbox" name="layer" ng-change="makeDistrictsVisible(1);updateView()" ng-model="showDistrictsLevels1">
														<label><spring:message code="dashboard.panel.check.districts.levels.1" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="makeDistrictsVisible(2);updateView()" ng-model="showDistrictsLevels2">
														<label><spring:message code="dashboard.panel.check.districts.levels.2" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="makeDistrictsVisible(3);updateView()" ng-model="showDistrictsLevels3">
														<label><spring:message code="dashboard.panel.check.districts.levels.3" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="makeDistrictsVisible(4);updateView()" ng-model="showDistrictsLevels4">
														<label><spring:message code="dashboard.panel.check.districts.levels.4" /></label></li>
													</ul>
												</div>
										</li>
									</ul>
								</div></li>
								
							<li class="divider"></li>
							
							<li><!-- <input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasures"> -->
							<label><spring:message code="dashboard.panel.check.measures" /> 
							<!-- GC 05/11/2015 -->
									<a data-toggle="collapse" href="#measuresCollapse"><span class="caret icon-white"></span></a></label>
								<div id="measuresCollapse" class="collapse">

									<ul class="no_bullet">
										<li><input type="checkbox" name="layer" ng-change="updateMeasuresTypesCheck()" ng-model="showMeasuresTypes">
											<label><spring:message code="dashboard.panel.check.measures.types" />
												<!-- GC 05/11/2015 --> 
												<a data-toggle="collapse" href="#measuresTypesCollapse"><span class="caret icon-white"></span></a></label>
											 <div id="measuresTypesCollapse" class="collapse">
													<ul class="no_bullet">
														<li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasuresTypes0">
													    <label><spring:message code="dashboard.panel.check.measures.types.0" /></label></li>
													    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasuresTypes1">
													    <label><spring:message code="dashboard.panel.check.measures.types.1" /></label></li>
													    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasuresTypes2">
													    <label><spring:message code="dashboard.panel.check.measures.types.2" /></label></li>
													    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasuresTypes3">
													    <label><spring:message code="dashboard.panel.check.measures.types.3" /></label></li>
													    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showMeasuresTypes4">
													    <label><spring:message code="dashboard.panel.check.measures.types.4" /></label></li>
													</ul>
											</div>
										</li>
									</ul>
								</div></li>
							
							<li class="divider"></li>
							
							<li><!-- <input type="checkbox" name="layer" ng-change="updateView()" ng-model="showEvents"> -->
							<label><spring:message code="dashboard.panel.check.events" /> 
							<!-- GC 05/11/2015 -->
									<a data-toggle="collapse" href="#eventsCollapse"><span class="caret icon-white"></span></a></label>
								<div id="eventsCollapse" class="collapse">

									<ul class="no_bullet">
										<li><input type="checkbox" name="layer" ng-change="updateEventsTypesCheck();hideDistrictByEventType(showEventsTypes)" ng-model="showEventsTypes">
											<label><spring:message code="dashboard.panel.check.events.types" />
												<!-- GC 05/11/2015 --> 
												<a data-toggle="collapse" href="#eventsTypesCollapse"><span class="caret icon-white"></span></a></label>
											  <div id="eventsTypesCollapse" class="collapse">
													<ul class="no_bullet">
														<li><input type="checkbox" name="layer" ng-change="updateView();hideDistrictByEventType(showEventsTypes1, 1)" ng-model="showEventsTypes1">
														<label><spring:message code="dashboard.panel.check.events.types.1" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="updateView();hideDistrictByEventType(showEventsTypes2, 2)" ng-model="showEventsTypes2">
														<label><spring:message code="dashboard.panel.check.events.types.2" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="updateView();hideDistrictByEventType(showEventsTypes3, 3)" ng-model="showEventsTypes3">
														<label><spring:message code="dashboard.panel.check.events.types.3" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="updateView();hideDistrictByEventType(showEventsTypes4, 4)" ng-model="showEventsTypes4">
														<label><spring:message code="dashboard.panel.check.events.types.4" /></label></li>
														<li><input type="checkbox" name="layer" ng-change="updateView();hideDistrictByEventType(showEventsTypes5, 5)" ng-model="showEventsTypes5">
														<label><spring:message code="dashboard.panel.check.events.types.5" /></label></li>
													</ul>
											 </div>
										</li>

										<li><input type="checkbox" name="layer" ng-change="updateEventsMarkersCheck()" ng-model="showEventsMarkers">
											<label><spring:message code="dashboard.panel.check.events.markers" />
												<!-- GC 05/11/2015 --> 
												<a data-toggle="collapse" href="#eventsMarkersCollapse"><span class="caret icon-white"></span></a></label>
											<div id="eventsMarkersCollapse" class="collapse">
												<ul class="no_bullet">
												<li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showEventsMarkersRanking">
											    <label><spring:message code="dashboard.panel.check.events.markers.ranking" /></label></li>
												<li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showEventsMarkersValue">
											    <label><spring:message code="dashboard.panel.check.events.markers.value" /></label></li>
											    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showEventsMarkersDuration">
											    <label><spring:message code="dashboard.panel.check.events.markers.duration" /></label></li>
											    <li><input type="checkbox" name="layer" ng-change="updateView()" ng-model="showEventsMarkersDelta">
											    <label><spring:message code="dashboard.panel.check.events.markers.delta" /></label></li>
												</ul>
										   </div>
										</li>
									</ul>
												
								</div></li>
							
							<li class="divider"></li>

							<li><label><spring:message code="dashboard.panel.general.wmsmap" />

                                    <a data-toggle="collapse" href="#wmsCollapse"><span class="caret icon-white"></span></a></label>
                                <div id="wmsCollapse" class="collapse" ng-controller="ManagerWmsServicesController">
                                    <ul class="no_bullet">
                                        <li ng-repeat="wms in wmsservices">
                                           <input type="checkbox" name="{{wms.name}}" ng-change="updateWmsView(wms.name)" ng-model="showWmsView">
                                            <label>{{wms.name}}</label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="divider"></li>

                            <li><label><input type="checkbox" name="layer"
                            		ng-change="updatePunctual()" ng-model="showPunctual"> <spring:message
                            			code="dashboard.panel.check.punctual" /></label></li>
							<li><label><input type="checkbox" name="layer"
									ng-change="updateAreal()" ng-model="showAreal"> <spring:message
										code="dashboard.panel.check.areal" /></label></li>
							<li><label><input type="checkbox" name="layer"
									ng-change="updateLinear()" ng-model="showLinear"> <spring:message
										code="dashboard.panel.check.linear" /></label></li>
						</ul>
					</div>

				</div>
			</div>
		</div>

 <sec:authorize access="!hasRole('ROLE_METER_READER')">
 
 <!-- Pannello Filtri -->
 <div class="row" ng-show="eventsSize > 0">
 <div class="col-md-1">
		    	<button type="button" class="btn btn-info"  ng-click="showFiltriMethod()"><spring:message code="dashboard.button.filtraView.title" /></button>
	    	</div>
	    <div class="col-md-1">
	    		<button ng-show="showFilterView" type="button" class="btn btn-warning"  ng-click="showFiltriMethod()"><spring:message code="dashboard.button.filtraChiudi.title" /></button>
	    </div>
 </div>
</br>
 <div class="row" ng-show="eventsSize > 0">
   		 <div class="form-group" ng-show="showFilterView">
					<jsp:include page="../../common/alerts.jsp" />
					<div class="alert alert-info col-md-9" role="alert" ng-show="showFilterView">
					
					<div class="row">
					<div class="col-md-2">
					&nbsp;&nbsp;&nbsp;
				  <label><small><spring:message code="dashboard.filter.column" /></small></label>
				  
				  <select class="form-control" ng-model="columnSelected" ng-change="changeColumns(columnSelected)">
					  	 <option ng-repeat="option in columnsFilter" value="{{option}}">
					  		{{option === 'duration' ? '<spring:message code="dashboard.form.table.duration" />' : ''}}
					  		{{option === 'value' ? '<spring:message code="dashboard.form.table.value" />' : ''}}
					  		{{option === 'ranking' ? '<spring:message code="dashboard.form.table.ranking" />' : ''}}
					  		{{option === 'district_name' ? '<spring:message code="dashboard.form.table.district" />' : ''}}
					  		{{option === 'district_ev_variable_type' ? '<spring:message code="dashboard.form.table.district_ev_variable_type" />' : ''}}
					  		{{option === 'delta_value' ? '<spring:message code="dashboard.form.table.delta" />' : ''}}
					  		{{option === 'type' ? '<spring:message code="dashboard.form.table.type" />' : ''}}
					  	</option>
					  </select>	
				    </div>
					<div class="col-md-2">
					 <label><small><spring:message code="dashboard.filter.column.operator" /></small></label>
					  <select class="form-control" ng-model="operatorsSelected">
					  	 <option ng-repeat="option in operators" value="{{option}}">
					  	 {{option === 'contiene' ? '<spring:message code="dashboard.filter.operator.contain" />' : ''}}
					  	 {{option === 'uguale' ? '<spring:message code="dashboard.filter.operator.uguale" />' : ''}}
					  	  {{option === '>' ? '>' : ''}}
					  	   {{option === '<' ? '<' : ''}}
					  	    {{option === '=' ? '=' : ''}}
					  	 </option>
					  </select>	
					 
					</div>
					<div class="col-md-2">
					 <label><small><spring:message code="dashboard.filter.column.value" /></small></label>
					 <input type="text" ng-model="valueInserted" name="valueInserted" ng-show="!filterIsNumber && !showVarType && !showType"/>
					  <input type="number" step="0.05" class="form-control input-sm" ng-model="valueInserted" name="valueInserted" ng-show="filterIsNumber && !showVarType && !showType"/>
					  
					  <select class="form-control" ng-model="valueInserted" ng-show="showVarType">
					   <option value="0"><spring:message code="dashboard.form.ev_variable_type.val.0" /></option>
					   <option value="1"><spring:message code="dashboard.form.ev_variable_type.val.1" /></option>
					   <option value="2"><spring:message code="dashboard.form.ev_variable_type.val.2" /></option>
					   <option value="3"><spring:message code="dashboard.form.ev_variable_type.val.3" /></option>
					   <option value="4"><spring:message code="dashboard.form.ev_variable_type.val.4" /></option>
					</select>
					
					 <select class="form-control" ng-model="valueInserted" ng-show="showType">
					   <option value="1"><spring:message code="events.types.1" /></option>
					   <option value="2"><spring:message code="events.types.2" /></option>
					   <option value="3"><spring:message code="events.types.3" /></option>
					   <option value="4"><spring:message code="events.types.4" /></option>
					   <option value="5"><spring:message code="events.types.5" /></option>
					</select>
					  
					  
					</div>
					<div class="col-md-2">
					 <label><small><spring:message code="dashboard.filter.add.button" /></small></label>
					 <button type="button" class="btn btn-warning"  ng-click="addFiltro()" ng-disabled="valueInserted.length == 0"><spring:message code="dashboard.filter.add.button" /></button>
					</div>
					</div>
					
					<div class="row" ng-show="numFilters > 0">
						<div class="col-md-9">
						
						    <div class="table-responsive" style="height:250px; overflow-y:auto;">
				    	<table class="table table-bordered wetnet-table-head" style="background: white;">
				    		<thead>
								<tr>
									<th class="col-md-2"><label><small><spring:message code="dashboard.filter.column" /></small></label></th>
									<th class="col-md-2"><label><small><spring:message code="dashboard.filter.column.operator" /></small></label></th>
									<th class="col-md-3"><label><small><spring:message code="dashboard.filter.column.value" /></small></label></th>
									<th class="col-md-2"><label><small><spring:message code="configuration.table.cancel" /></small></label></th>
								</tr>
						  	</thead>
						  	<tbody>
								<tr ng-repeat="c in filtersInserted">
							  		<td align="center" class="col-md-2">
							  		<label ng-if="c.column === 'duration'"><small><spring:message code="dashboard.form.table.duration" /></small></label>
							  		<label ng-if="c.column === 'value'"><small><spring:message code="dashboard.form.table.value" /></small></label>
							  		<label ng-if="c.column === 'ranking'"><small><spring:message code="dashboard.form.table.ranking" /></small></label>
							  		<label ng-if="c.column === 'district_name'"><small><spring:message code="dashboard.form.table.district" /></small></label>
							  		<label ng-if="c.column === 'district_ev_variable_type'"><small><spring:message code="dashboard.form.table.district_ev_variable_type" /></small></label>
							  		<label ng-if="c.column === 'delta_value'"><small><spring:message code="dashboard.form.table.delta" /></small></label>
							  		<label ng-if="c.column === 'type'"><small><spring:message code="dashboard.form.table.type" /></small></label>
							  		
							  		</td>
							    	<td align="center" class="col-md-2">
							    	<label ng-if="c.operator === 'contiene'"><small><spring:message code="dashboard.filter.operator.contain" /></small></label>
							  		<label ng-if="c.operator === 'uguale'"><small><spring:message code="dashboard.filter.operator.uguale" /></small></label>
							  		<label ng-if="c.operator === '>' || c.operator === '<' || c.operator === '='"><small>{{c.operator}}</small></label>
							  		</td>
							    	<td align="center" class="col-md-3"><label><small>{{c.val}}</small></label></td>
							    	<td align="center" class="col-md-2"><button class="btn btn-danger" ng-click="removeFiltro($index)"><spring:message code="configuration.button.cancel"/></button></td>
							  	</tr>
  							</tbody>
						</table>
						
				    </div>
						</div>
					</div>
					
					
				</div>
			  </div>
   		</div>
 <!-- Fine Pannello Filtri -->
 
		<!-- Pannello Eventi -->
		<div class="row">
			<div class="col-md-9">
				<div class="form-group">
					<div ng-show="eventsSize > 0">
						<div class="table-responsive">
							<table class="table table-bordered wetnet-table-head"
								style="background: white;">
								<thead>
									<tr>
										<th><a href="#" ng-click="sortEventsList('duration')"
											tooltip="<spring:message code="events.tooltip.duration" />"><spring:message
													code="dashboard.form.table.duration" /></a></th>
										<th><a href="#" ng-click="sortEventsList('value')"
											tooltip="<spring:message code="events.tooltip.value" />"><spring:message
													code="dashboard.form.table.value" /></a></th>
										<th><a href="#" ng-click="sortEventsList('ranking')"><spring:message
													code="dashboard.form.table.ranking" /></a></th>
										<th><a href="#"
											ng-click="sortEventsList('district_name')"><spring:message
													code="dashboard.form.table.district" /></a></th>
										
										<!-- GC 11/11/2015 -->
													<th><a href="#"
											ng-click="sortEventsList('district_ev_variable_type')"><spring:message
													code="dashboard.form.table.district_ev_variable_type" /></a></th>
													
										<th><a href="#" ng-click="sortEventsList('delta_value')"
											tooltip="<spring:message code="events.tooltip.delta_value" />"><spring:message
													code="dashboard.form.table.delta" /></a></th>
										<th><a href="#" ng-click="sortEventsList('type')"><spring:message
													code="dashboard.form.table.description" /></a></th>
										<th><a><spring:message
													code="dashboard.form.table.goToChart" /></a></th>
									    <th><a href="#"><spring:message
													code="dashboard.form.table.measures" /></a></a></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="e in events | orderBy: orderByField | applyFilters:filtersInserted">
										<td align="center">{{e.duration}}</td>
										<td align="center">{{e.value}}</td>
										<td align="center">{{e.ranking}}&#37;</td>
										<td><sec:authorize
												access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
												<a
													href="<c:url value="/wetnet/manager/district?id={{e.districts_id_districts}}" />"
													tooltip="<spring:message code="dashboard.form.table.district.modify-title" /> - {{e.districts_id_districts}}">{{e.district_name}}</a>
											</sec:authorize> <sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
												<a
													href="<c:url value="/wetnet/manager/district?id={{e.districts_id_districts}}" />"
													tooltip="<spring:message code="dashboard.form.table.district.show-title" />  - {{e.districts_id_districts}}">{{e.district_name}}</a>
											</sec:authorize> <sec:authorize
												access="hasAnyRole({'ROLE_OPERATOR', 'ROLE_USER'})">
								  			{{e.district_name}}
	
								  		</sec:authorize></td>
								  		
								  		<!--  GC 11/11/2015 -->
								  		<td align="center">
								  			<div ng-show="e.district_ev_variable_type == 0"><spring:message code="dashboard.form.ev_variable_type.val.0" /></div>
								  			<div ng-show="e.district_ev_variable_type == 1"><spring:message code="dashboard.form.ev_variable_type.val.1" /></div>
								  			<div ng-show="e.district_ev_variable_type == 2"><spring:message code="dashboard.form.ev_variable_type.val.2" /></div>
								  			<div ng-show="e.district_ev_variable_type == 3"><spring:message code="dashboard.form.ev_variable_type.val.3" /></div>
								  			<div ng-show="e.district_ev_variable_type == 4"><spring:message code="dashboard.form.ev_variable_type.val.4" /></div>
								  		</td>
										
										<td align="center">
											{{e.delta_value}}
										</td>
										<td align="center"><a href="#"
											ng-click="fromListToMap(e.districts_id_districts)"><img
												ng-show="e.type == 1" tooltip="{{e.description}}"
												class="img-responsive" alt="{{e.description}}"
												src="<c:url value="/images/anomal_increase_found.png" />"
												height="40" width="40"></a> <a href="#"
											ng-click="fromListToMap(e.districts_id_districts)"><img
												ng-show="e.type == 2" tooltip="{{e.description}}"
												class="img-responsive" alt="{{e.description}}"
												src="<c:url value="/images/possible_water_loss.png" />"
												height="40" width="40"></a> <a href="#"
											ng-click="fromListToMap(e.districts_id_districts)"><img
												ng-show="e.type == 3" tooltip="{{e.description}}"
												class="img-responsive" alt="{{e.description}}"
												src="<c:url value="/images/anomal_decrease_found.png" />"
												height="40" width="40"></a> <a href="#"
											ng-click="fromListToMap(e.districts_id_districts)"><img
												ng-show="e.type == 4" tooltip="{{e.description}}"
												class="img-responsive" alt="{{e.description}}"
												src="<c:url value="/images/possible_water_gain.png" />"
												height="40" width="40"></a> <a href="#"
											ng-click="fromListToMap(e.districts_id_districts)"><img
												ng-show="e.type == 5" tooltip="{{e.description}}"
												class="img-responsive" alt="{{e.description}}"
												src="<c:url value="/images/out_of_control.png" />"
												height="40" width="40"></a>
												<div ng-show="e.type == 5">
												<a href="<c:url value="/wetnet/alarms/alarms-active" />" ><spring:message code="dashboard.form.table.alarms-link" /></a>
												</div></td>
										<td style="font-size: 12px;"><a
											href="<c:url value="/wetnet/graphics/statistic?idDistricts={{e.districts_id_districts}}" />"
											tooltip="<spring:message code="dashboard.form.table.g1-title" />"><spring:message
													code="dashboard.form.table.g1" /></a> <br>
										<a
											href="<c:url value="/wetnet/graphics/statistic-g2?idDistricts={{e.districts_id_districts}}&day={{e.day | date:'yyyy-MM-dd' }}&duration={{e.duration}}" />"
											tooltip="<spring:message code="dashboard.form.table.g2-title" />"><spring:message
													code="dashboard.form.table.g2" /></a> <br>
										<a
											href="<c:url value="/wetnet/graphics/statistic-g7?idDistricts={{e.districts_id_districts}}&day={{e.day | date:'yyyy-MM-dd' }}&duration={{e.duration}}" />"
											tooltip="<spring:message code="dashboard.form.table.g7-title" />"><spring:message
													code="dashboard.form.table.g7" /></a> <br>
										<a
											href="<c:url value="/wetnet/graphics/statistic-g9?districtId={{e.districts_id_districts}}&date={{e.day | date:'yyyy-MM-dd' }}" />"
											tooltip="<spring:message code="dashboard.form.table.g9-title" />"><spring:message
													code="dashboard.form.table.g9"/></a>
										</td>
										<td style="font-size: 12px;">
										    <input type="checkbox" ng-model="showDistrictFlow[e.districts_id_districts]"
										    	ng-change="displayMeasuresInDistrict(showDistrictFlow[e.districts_id_districts], e.districts_id_districts, 0)">
										    	<spring:message code="dashboard.form.table.flow" />
										    <br>
                                            <input type="checkbox" ng-model="showDistrictPressure[e.districts_id_districts]"
                                            	ng-change="displayMeasuresInDistrict(showDistrictPressure[e.districts_id_districts], e.districts_id_districts, 1)">
                                            	<spring:message code="dashboard.form.table.pressure" />
                                           	<br>
                                           	<a href="#" ng-click="loadDistrictMeasures(e.districts_id_districts, e.district_name)"
                                           		onclick="showElementById('district-measures')"><spring:message code="dashboard.form.table.allMeasures" /></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- ****RC 26/10/2015**** -->
					<div ng-show="eventsSize == 0">
						<h2>
							<spring:message code="dashboard.events.result" />
						</h2>
						<div class="table-responsive">
							<table class="table table-bordered wetnet-table-head"
								style="background: white;">
								<thead>
									<tr>
										<th><a href="#"
											tooltip="<spring:message code="events.tooltip.duration" />"><spring:message
													code="dashboard.form.table.duration" /></a></th>
										<th><a href="#"
											tooltip="<spring:message code="events.tooltip.value" />"><spring:message
													code="dashboard.form.table.value" /></a></th>
										<th><a href="#"><spring:message
													code="dashboard.form.table.ranking" /></a></th>
										<th><a href="#"><spring:message
													code="dashboard.form.table.district" /></a></th>
												
												<!-- GC 11/11/2015 -->
													<th><a href="#" ><spring:message
													code="dashboard.form.table.district_ev_variable_type" /></a></th>	
													
										<th><a href="#"
											tooltip="<spring:message code="events.tooltip.delta_value" />"><spring:message
													code="dashboard.form.table.delta" /></a></th>
										<th><a href="#"><spring:message
													code="dashboard.form.table.description" /></a></th>
										<th><a><spring:message
													code="dashboard.form.table.goToChart" /></a></th>
										<th><a href="#"><spring:message
													code="dashboard.form.table.measures" /></a></a></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-show="eventBean.districtsSelected">
										<td align="center"></td>
										<td align="center"></td>
										<td align="center"></td>
										<td><sec:authorize
												access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
												<a
													href="<c:url value="/wetnet/manager/district?id={{eventBean.districtsSelected.idDistricts}}" />"
													tooltip="<spring:message code="dashboard.form.table.district.modify-title" /> - {{eventBean.districtsSelected.idDistricts}}">{{eventBean.districtsSelected.name}}</a>
											</sec:authorize> <sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
												<a
													href="<c:url value="/wetnet/manager/district?id={{eventBean.districtsSelected.idDistricts}}" />"
													tooltip="<spring:message code="dashboard.form.table.district.show-title" />  - {{eventBean.districtsSelected.idDistricts}}">{{eventBean.districtsSelected.name}}</a>
											</sec:authorize> <sec:authorize
												access="hasAnyRole({'ROLE_OPERATOR', 'ROLE_USER'})">
								  			{{eventBean.districtsSelected.name}}
								  		</sec:authorize></td>
										<td align="center"></td>
										<td align="center"></td>
										<td align="center"></td>
										<td style="font-size: 12px;"><a
											href="<c:url value="/wetnet/graphics/statistic?idDistricts={{eventBean.districtsSelected.idDistricts}}" />"
											tooltip="<spring:message code="dashboard.form.table.g1-title" />"><spring:message
													code="dashboard.form.table.g1" /></a> <br>
										<a
											href="<c:url value="/wetnet/graphics/statistic-g2?idDistricts={{eventBean.districtsSelected.idDistricts}}&day={{eventBean.endDate | date:'yyyy-MM-dd'}}&duration=4" />"
											tooltip="<spring:message code="dashboard.form.link.pcm" />"><spring:message
													code="dashboard.form.link.pcm" /></a> <br>
										<a
											href="<c:url value="/wetnet/graphics/statistic-g7?idDistricts={{eventBean.districtsSelected.idDistricts}}&day={{eventBean.endDate | date:'yyyy-MM-dd'}}&duration=0" />"
											tooltip="<spring:message code="dashboard.form.link.sg" />"><spring:message
													code="dashboard.form.link.sg" /></a></td>
										<td style="font-size: 12px;">
										    <input type="checkbox" ng-model="showDistrictFlow[e.districts_id_districts]"
										    	ng-change="displayMeasuresInDistrict(showDistrictFlow[e.districts_id_districts], e.districts_id_districts, 0)">
										    	<spring:message code="dashboard.form.table.flow" />
										    <br>
                                            <input type="checkbox" ng-model="showDistrictPressure[e.districts_id_districts]"
                                            	ng-change="displayMeasuresInDistrict(showDistrictPressure[e.districts_id_districts], e.districts_id_districts, 1)">
                                            	<spring:message code="dashboard.form.table.pressure" />
                                           	<br>
                                           	<a href="#" ng-click="loadDistrictMeasures(eventBean.districtsSelected.idDistricts, eventBean.districtsSelected.name)"
                                           		onclick="showElementById('district-measures')"><spring:message code="dashboard.form.table.allMeasures" /></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div id="pie-chart" build-chart></div>
			</div>
		</div>
		</sec:authorize>

	</div>

	<div class="footer-logo" style="bottom: -70;">
		<jsp:include page="../../common/footer-logo.jsp" />
	</div>

	<!-- Modal (personalizzato) -->
	<div id="district-measures" class="modal-content modal-draggable">
		<div id="district-measures-drag-picker" class="modal-header drag-picker">
			<button type="button" class="close" style="font-size:14px;" onclick="hideElementById('district-measures')">&times;</button>
			<h4 class="modal-title"><spring:message code="dashboard.modal.title" /> "<b>{{modalDistrictName}}</b>"</h4>
		</div>
		<div class="modal-body resizable">
			<table class="table table-hover">
				<thead>
					<tr>
						<th><spring:message code="dashboard.modal.measureId" /></th>
						<th><spring:message code="dashboard.modal.measureName" /></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="m in districtMeasures">
						<td>{{m.measures_id_measures}}</td>
						<td>{{m.measures_name}}</td>
						<td ng-switch on="m.sign">
							<span ng-switch-when="0">(+) Portata in ingresso</span>
							<span ng-switch-when="1">(-) Portata in uscita</span>
							<span ng-switch-when="2">Pressione interna o al contorno</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<!-- GC 05/11/2015 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/script/map_utils.js"></script>
</body>
</html>