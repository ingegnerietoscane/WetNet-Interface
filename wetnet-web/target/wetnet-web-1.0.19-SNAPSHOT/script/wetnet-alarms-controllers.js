"use strict";

var wetnetAlarmsControllers = angular.module('wetnetAlarmsControllers', []);

wetnetAlarmsControllers.controller("WetnetControllerAlarms", [ '$scope', '$http', 'Measures','Alarms','$log','$filter',
                                                         	function($scope, $http, Measures, Alarms, $log, $filter) {
	$scope.config = new Object();

	$scope.measures = Measures.getData(); //carico le misure utlizzate per la ricerca

	
	// inizializzazioni
	$scope.formBean = new Object();
	$scope.alarmsSize = -1;
	$scope.mSelected = null;

	$scope.measureSelectedShow = function($item, $model, $label) {
		$scope.mSelected = $model;
	}
	
	// callback for ng-click 'loadData':
	$scope.loadData = function() {
		$scope.formBean.measuresSelected = $scope.mSelected;
		$scope.formBean.closedAlarms=false; //la query è per active alarms
			Alarms.getData($scope.formBean, function(data) {
				$scope.alarms = data;
				$scope.alarmsSize = data.length;
				
				for(var i = 0; i < $scope.alarms.length; i++)
					{
					var a = $scope.alarms[i];
					
					//calcolo day inizio
					var inizio = getDateFromFormat(a.timestamp.substring(0, 10),"yyyy-MM-dd");
					
					//calcolo fine inizio
					//oggi
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1;
					var yyyy = today.getFullYear();
					
					//calcolo duration
					//oggi - data inizio in giorni
					var gg = parseInt((today-inizio)/(24*3600*1000))
					
					a.differenceDay=gg - 1;
					a.day=today;
					
					$scope.alarms[i] = a;
					}
				
			});
		
	}
	
	// callback for ng-click 'loadHistoryData':
	$scope.loadHistoryData = function() {
		$scope.formBean.measuresSelected = $scope.mSelected;
		$scope.formBean.closedAlarms=true; //la query è per history alarms
			Alarms.getData($scope.formBean, function(data) {
				$scope.alarms = data;
				$scope.alarmsSize = data.length;
				
				for(var i = 0; i < $scope.alarms.length; i++)
				{
				var a = $scope.alarms[i];
				
				//calcolo day inizio
				var inizio = getDateFromFormat(a.timestamp.substring(0, 10),"yyyy-MM-dd");
				
				//calcolo fine inizio
				//oggi
				var today = new Date();
				var dd = today.getDate();
				var mm = today.getMonth()+1;
				var yyyy = today.getFullYear();
				
				//calcolo duration
				//oggi - data inizio in giorni
				var gg = parseInt((today-inizio)/(24*3600*1000))
				
				a.differenceDay=gg - 1;
				a.day=today;
				
				$scope.alarms[i] = a;
				}
				
			});
		
	}
	
	// callback for ng-click 'exportCSV':
	$scope.exportCSV = function () {
		$http({method: 'POST', url: '/wetnet/rest/alarms/csv', data: $scope.alarms}).
		  success(function(data, status, headers, config) {
		     var element = angular.element('#exportCSV');
		     element.attr({
		         href: 'data:attachment/csv;charset=utf-8,' + encodeURI(data),
		         target: '_blank',
		         download: 'alarms-list.csv'
		     });
		  }).
		  error(function(data, status, headers, config) {
		    // if there's an error you should see it here
		  });
	}

	
	$scope.removeMeasure = function() {
		$scope.mSelected = null;
	}
	
}]);


