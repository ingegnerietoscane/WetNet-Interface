<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html ng-app="wetnetApp">
    <head>
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title><spring:message code="statistic-g12.head.title" /></title>
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
<body ng-controller="WetnetControllerG12">
	<div class="container-fluid">
 	<jsp:include page="../../common/nav.jsp" />
	
		<div class="row">
	        <div class="col-md-2">
	            <p class="input-group bootstrap-datepicker-correction">
	              <label class="sr-only" for="startDate"><spring:message code="statistic-g12.form.startDate" /></label>
	              <input id="startDate" type="text" class="form-control" datepicker-popup="yyyy-MM-dd" ng-model="g12Data.startDate" is-open="openedStartDate"  />
	              <span class="input-group-btn">
	                <button type="button" class="btn btn-default" ng-click="openStartDate($event)"><i class="glyphicon glyphicon-calendar"></i></button>
	              </span>
	   			</p>
	   		</div>
	        <div class="col-md-2">
	            <p class="input-group bootstrap-datepicker-correction">
	              <label class="sr-only" for="endDate"><spring:message code="statistic-g12.form.endDate" /></label>
	              <input id="endDate" type="text" class="form-control" datepicker-popup="yyyy-MM-dd" ng-model="g12Data.endDate" is-open="openedEndDate"  />
	              <span class="input-group-btn">
	                <button type="button" class="btn btn-default" ng-click="openEndDate($event)"><i class="glyphicon glyphicon-calendar"></i></button>
	              </span>
	            </p>
			</div>
			<div class="col-md-3">
				<div class="btn-group form-group">
					<a href="#" class="btn btn-success" ng-change="updateDate()" ng-model="radioModel" btn-radio="'2y'" title="<spring:message code="time.form.2y-title" />"><spring:message code="time.form.2y" /></a>   
					<a href="#" class="btn btn-success" ng-change="updateDate()" ng-model="radioModel" btn-radio="'4y'" title="<spring:message code="time.form.4y-title" />"><spring:message code="time.form.4y" /></a>
					<a href="#" class="btn btn-success" ng-change="updateDate()" ng-model="radioModel" btn-radio="'6y'" title="<spring:message code="time.form.6y-title" />"><spring:message code="time.form.6y" /></a>					
					<a href="#" class="btn btn-success" ng-change="updateDate()" ng-model="radioModel" btn-radio="'8y'" title="<spring:message code="time.form.8y-title" />"><spring:message code="time.form.8y" /></a>
					<a href="#" class="btn btn-success" ng-change="updateDate()" ng-model="radioModel" btn-radio="'10y'" title="<spring:message code="time.form.10y-title" />"><spring:message code="time.form.10y" /></a>
				</div>
			</div>	
	    	<!-- GC 25/11/2015 -->
	    	<div class="col-md-5">
	   				<div class="form-group">
	   					<table>
		   					<tr>
			   					<td><label for="zoneSelect" class="col-sm-1 control-label"><spring:message code="statistic-g7.form.zoneSelect.label" /></label>
			   					</td>
			   					<td>
			   					<!-- <select ng-options="z for z in zones" ng-model="filterValue" ng-change="filterDistricts('zone');"></select>-->
			   					<select  ng-model="filterValueZ" ng-change="filterDistricts('zone');">
			   					<option value = ''>--select all--</option>
        						<option ng-repeat="z in zones">{{z}}</option>
			   					</select>
			   					</td>
			   					<td><label for="waterAuthoritySelect" class="col-sm-1 control-label"><spring:message code="statistic-g7.form.waterAuthoritySelect.label" /></label>
			   					</td>
			   					<td>
			   					<!-- <select ng-options="w for w in waterAuthorities" ng-model="filterValue" ng-change="filterDistricts('waterAuthority');"></select>-->
			   					<select ng-model="filterValueW" ng-change="filterDistricts('waterAuthority');">
			   					<option  value = ''>--select all--</option>
        						<option ng-repeat="w in waterAuthorities">{{w}}</option>
			   					</select>
			   					</td>
		   					</tr>
	   					</table>
				 </div>
			</div>
		</div>
		<div class="row">  		
			<span ng-if="dataError">
				<div class="col-md-4">
					<div class="form-group errorblock">
							<spring:message code="statistic-g12.form.errorData" />
					</div>
				</div>
			</span>
			<span ng-if="rangeError">
					<div class="col-md-4">
						<div class="form-group errorblock">
								<spring:message code="statistic-g12.form.errorRange" />
						</div>
					</div>
			</span>
		</div>
   		<div class="row">
			<div class="col-md-6">
  				<form class="form-inline">
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.min-night" />" type="radio" ng-model="g12Data.dVariables['minNight']" ng-value="true" ng-change="dChange('minNight')"> <spring:message code="statistic-g12.form.min-night" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.min-day" />" type="radio" ng-model="g12Data.dVariables['minDay']" ng-value="true" ng-change="dChange('minDay')"> <spring:message code="statistic-g12.form.min-day" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.max-day" />" type="radio" ng-model="g12Data.dVariables['maxDay']" ng-value="true" ng-change="dChange('maxDay')"> <spring:message code="statistic-g12.form.max-day" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.avg-day" />" type="radio" ng-model="g12Data.dVariables['avgDay']" ng-value="true" ng-change="dChange('avgDay')"> <spring:message code="statistic-g12.form.avg-day" /></label></div>
				</form>
	   		</div>
			<div class="col-md-6">
				<form class="form-inline">
   					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.min-night" />" type="radio" ng-model="g12Data.mVariables['minNight']" ng-value="true" ng-change="mChange('minNight')"> <spring:message code="statistic-g12.form.min-night" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.min-day" />" type="radio" ng-model="g12Data.mVariables['minDay']" ng-value="true" ng-change="mChange('minDay')"> <spring:message code="statistic-g12.form.min-day" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.max-day" />" type="radio" ng-model="g12Data.mVariables['maxDay']" ng-value="true" ng-change="mChange('maxDay')"> <spring:message code="statistic-g12.form.max-day" /></label></div>
					<div class="radio"><label><input name="<spring:message code="statistic-g12.form.avg-day" />" type="radio" ng-model="g12Data.mVariables['avgDay']" ng-value="true" ng-change="mChange('avgDay')"> <spring:message code="statistic-g12.form.avg-day" /></label></div>
				</form>
	   		</div>
		</div>
		
   		<div class="row">
			<div class="col-md-6">
				<div>
					<label><spring:message code="statistic-g12.form.selectedDistricts" /></label>
					<div ng-dropdown-multiselect events="filteredDistrictsEvents" options="filteredDistrictsData" selected-model="filteredDistrictsModel" extra-settings="filteredDistrictsSettings"></div>
				</div>
	   		</div>
			<div class="col-md-6">
				<div>
					<label><spring:message code="statistic-g12.form.selectedMeasures" /></label>
					<div ng-dropdown-multiselect events="filteredMeasuresEvents" options="filteredMeasuresData" selected-model="filteredMeasuresModel" extra-settings="filteredMeasuresSettings"></div>
				</div>
	   		</div>
		</div>
		<br>
	   	<div class="row">
			<div class="col-md-6">
			<!-- GC 25/11/2015 -->
				<!-- <label ng-show="g12Data.districtsSelected.length > 0"><spring:message code="statistic-g7.form.selectedDistricts" /></label> -->
		    	<div  ng-repeat="item in g12Data.districtsSelected">
			    	<dl>
			    	<dt><button type="button" class="btn btn-info" tooltip="<spring:message code="statistic-g7.district.button.remove.tooltip" />"  ng-click="districtSelectedRemove(item)">{{item.name}}</button>
						<sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
			    			<a href="<c:url value="/wetnet/manager/district?id={{item.idDistricts}}" />" class="btn btn-success" tooltip="<spring:message code="statistic-g7.district.button.modify-title" />"><spring:message code="statistic-g7.district.button.modify" /></a>
		    			</sec:authorize>
		    					<sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
			    			<a href="<c:url value="/wetnet/manager/district?id={{item.idDistricts}}" />" class="btn btn-success" tooltip="<spring:message code="statistic-g7.district.button.show-title" />"><spring:message code="statistic-g7.district.button.modify" /></a>
		    			</sec:authorize>
		    		</dt>
			    	<dd><span ng-repeat="m in item.measures"><button type="button" class="btn btn-link" tooltip="<spring:message code="statistic-g7.measure.button.add.tooltip" />" ng-click="measureSelectedAdd(m, m, m.name)" >{{m.name}} ({{checkSign(m.sign)}})</button></span></dd>
			    	</dl>
		    	</div>
	   		</div>
			<div class="col-md-6">
				<!-- GC 25/11/2015 -->
				<!--<label ng-show="g12Data.measuresSelected.length > 0"><spring:message code="statistic-g7.form.selectedMeasures" /></label>-->
			    <div class="form-group">
			    	<div ng-repeat="item in g12Data.measuresSelected">
				    	<button type="button" class="btn btn-info"  tooltip="<spring:message code="statistic-g7.measure.button.remove.tooltip" />" ng-click="measureSelectedRemove(item)">{{item.name}}</button>
			   			<sec:authorize access="hasAnyRole({'ROLE_ADMINISTRATOR'})">
			   				<a href="<c:url value="/wetnet/manager/measure?id={{item.idMeasures}}" />" class="btn btn-success" tooltip="<spring:message code="statistic-g7.measure.button.modify-title" />"><spring:message code="statistic-g7.measure.button.modify" /></a>
		   				</sec:authorize>
		    			<sec:authorize access="hasAnyRole({'ROLE_SUPERVISOR'})">
		    				<a href="<c:url value="/wetnet/manager/measure?id={{item.idMeasures}}" />" class="btn btn-success" tooltip="<spring:message code="statistic-g7.measure.button.show-title" />"><spring:message code="statistic-g7.measure.button.modify" /></a>
		    			</sec:authorize>
		   			</div>
		   		</div>
	   		</div>
		</div>
   		<!-- ***RC 01/12/2015*** -->
   		<div class="row">
	  		<div class="alert alert-info" role="alert" ng-show="confDialog">
				<label for="confDesc"><small><spring:message code="configuration.description.label" /></small></label>
				<input type="text" name="confDesc" id="confDesc" class="form-control">
				<button class="alert-link" ng-click="saveConf()"><spring:message code="configuration.button.save" /></button>
				<br/>
				<div>
				    <div class="table-responsive" style="height:250px; overflow-y:scroll;">
				    	<table class="table table-bordered wetnet-table-head" style="background: white;">
				    		<thead>
								<tr>
									<th><spring:message code="configuration.table.date" /></th>
									<th><spring:message code="configuration.table.description" /></th>
									<th><spring:message code="configuration.table.apply" /></th>
									<th><spring:message code="configuration.table.cancel" /></th>
								</tr>
						  	</thead>
						  	<tbody>
								<tr ng-repeat="c in configList">
							  		<td align="center">{{c.save_date | date:'yyyy-MM-dd HH:mm:ss'}}</td>
							    	<td align="center">{{c.description}}</td>
							    	<td align="center"><button class="btn btn-success" ng-click="configSelected(c)"><spring:message code="configuration.button.apply"/></button></td>
							    	<td align="center"><button class="btn btn-danger" ng-click="configDeleted(c)"><spring:message code="configuration.button.cancel"/></button></td>
							  	</tr>
  							</tbody>
						</table>
						
				    </div>
  				</div>				
				<br/>
				<button ng-click="dialogCancelled()" class="alert-link"><spring:message code="district.form.delete.messagge.confirm.cancel" /></button>
			</div>
		</div>
   		<!-- ***END*** -->

	   	<div class="row">
	   		<div class="col-md-1">
		   		<div class="form-group">
		   			<button ng-click="loadData()" class="btn btn-default" ><spring:message code="statistic-g7.form.button.update" /></button>
		   		</div>
	   		</div>
	   		<!-- ***RC 01/12/2015*** -->
	   		<div class="col-md-1">
	   			<button class="btn btn-danger" ng-click="showDialog()"><spring:message code="configuration.button.configure" /></button>
	   		</div>
	   		<!-- ***END*** -->
<!-- 	   		<div class="col-md-2">
		   		<div class="form-group">
	   			</div>
   			</div>
   			-->
	   		<div class="col-md-6">
		   		<div class="form-group">
		   		<!-- 	<button ng-click="loadDataForMeasure()" class="btn btn-default" ><spring:message code="statistic-g7.form.button.updateMeasure" /></button> -->
		   		</div>
	   		</div>
		   </div>

	<!-- SeasonaL Graphs -->
    <div class="row">
        <div class="col-md-6">
			<label><spring:message code="statistic-g12.graph.time-series-chart"/></label>
            <div class="row chart-wrap">
                <div id="time-series-chart" build-chart></div>
            </div>
        </div>
        <div class="col-md-6">
			<label><spring:message code="statistic-g12.graph.seasonal-chart"/></label>
			<div class="row chart-wrap">
				<div id="seasonal-chart" build-chart></div>
			</div>
        </div>
    </div>
    <div class="row">
		<div class="col-md-6">
			<label><spring:message code="statistic-g12.graph.trend-chart"/></label>
			<div class="row chart-wrap">
				<div id="trend-chart" build-chart></div>
			</div>			
		</div>
		<div class="col-md-6">
			<label><spring:message code="statistic-g12.graph.residue-chart"/></label>
			<div class="row chart-wrap">
				<div id="residue-chart" build-chart></div>
			</div>
		</div>
        </div>
</div>
<jsp:include page="../../common/footer.jsp" />

<!-- Utlizzato per l'export del grafico	-->
<canvas id="canvas" width="1072px" height="676px" class="ng-hide"></canvas>
</body>
  
</html>

