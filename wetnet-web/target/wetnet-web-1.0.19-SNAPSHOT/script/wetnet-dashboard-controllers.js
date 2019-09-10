"use strict";

var wetnetDashboardControllers = angular.module('wetnetDashboardControllers', []);

wetnetDashboardControllers.filter('applyFilters', function () {
	  return function (items, filters) {
		 
		 if (!items) return;
		 
		  var filtered = new Array();
		  
		  for(var i = 0; i < items.length; i++)
			  {
			  var e = items[i];
			 
			  var checkFilter = true;
			  
			  for(var j = 0; j<filters.length; j++)
				  {
				  
				  var f = filters[j];
				  
				  	if(f.column === 'duration' || f.column === 'value' || f.column === 'ranking' || f.column === 'delta_value')
					{
					
						if(f.column === 'duration')
							{
							    
								if(f.operator === '>')
									{
									if(e.duration <= f.val) checkFilter = false;
									}
								else if(f.operator === '<')
								{
									if(e.duration >= f.val) checkFilter = false;
								}
								else if(f.operator === '=')
								{
									if(e.duration > f.val) checkFilter = false;
									if(e.duration < f.val) checkFilter = false;
								}
							
							}
						else if(f.column === 'value')
						{
							if(f.operator === '>')
							{
							if(e.value <= f.val) checkFilter = false;
							}
						else if(f.operator === '<')
						{
							if(e.value >= f.val) checkFilter = false;
						}
						else if(f.operator === '=')
						{
							if(e.value > f.val) checkFilter = false;
							if(e.value < f.val) checkFilter = false;
						}
						}
						else if(f.column === 'ranking')
						{
							if(f.operator === '>')
							{
							if(e.ranking <= f.val) checkFilter = false;
							}
						else if(f.operator === '<')
						{
							if(e.ranking >= f.val) checkFilter = false;
						}
						else if(f.operator === '=')
						{
							if(e.ranking > f.val) checkFilter = false;
							if(e.ranking < f.val) checkFilter = false;
						}
						}
						else if(f.column === 'delta_value')
						{
							if(f.operator === '>')
							{
							if(e.delta_value <= f.val) checkFilter = false;
							}
						else if(f.operator === '<')
						{
							if(e.delta_value >= f.val) checkFilter = false;
						}
						else if(f.operator === '=')
						{
							if(e.delta_value > f.val) checkFilter = false;
							if(e.delta_value < f.val) checkFilter = false;
						}
						}
						
						
					}
					else
						{
						
						if(f.column === 'district_name')
						{
						
						if(f.operator === 'contiene')
							{
							 if(e.district_name.toUpperCase().indexOf(f.val.toUpperCase()) === -1) checkFilter = false;
							}
						else
							{
							if(e.district_name !== f.val) checkFilter = false;
							}
						}
						else if(f.column === 'district_ev_variable_type')
							{
							var x = parseInt(f.val, 10);
							var y = parseInt(e.district_ev_variable_type, 10);
							if(x !== y)
								{
								checkFilter = false;
								}
							}
						else if(f.column === 'type' && e.type !== f.val) checkFilter = false;
						
					}
				  }
			  
			  if(checkFilter) filtered.push(e);
			  }
		
	    
	    return filtered;
	  };
	});


wetnetDashboardControllers.controller("DashboardController", ['$scope', '$http', 'Districts', 'Measures', 'Events', 'WmsServices1', 'RoundNumber', 'UsersPreferences', '$log','Properties','DashboardSettings', 'MeasuresHasDistricts',
                                          				function($scope, $http, Districts, Measures, Events, WmsServices1, RoundNumber, UsersPreferences, $log,Properties,DashboardSettings, MeasuresHasDistricts) {
        		
	
	
	$scope.settingsCheck = new Object();
	$scope.settingsCheck.level=0;
	$scope.settingsCheck.zoom = 10;
	$scope.settingsCheck.districtLevel1 = false;
	$scope.settingsCheck.districtLevel2 = false;
	$scope.settingsCheck.districtLevel3 = false;
	$scope.settingsCheck.districtLevel4 = false;
	$scope.settingsCheck.measureType0 = false;
	$scope.settingsCheck.measureType1 = false;
	$scope.settingsCheck.measureType2 = false;
	$scope.settingsCheck.measureType3 = false;
	$scope.settingsCheck.measureType4 = false;
	$scope.settingsCheck.eventType1 = false;
	$scope.settingsCheck.eventType2 = false;
	$scope.settingsCheck.eventType3 = false;
	$scope.settingsCheck.eventType4 = false;
	$scope.settingsCheck.eventType5 = false;
	$scope.settingsCheck.eventRanking = false;
	$scope.settingsCheck.eventValue = false;
	$scope.settingsCheck.eventDuration = false;
	$scope.settingsCheck.eventDelta = false;
	$scope.settingsCheck.areal = false;
	$scope.settingsCheck.linear = false;
	$scope.settingsCheck.punctual = false;
	
	
	//inizializza scope fields
 	$scope.radioItem = '0';
 	
 	/* GC 05/11/2015 */	
 	$scope.showDistrictsLevels = false;
 	$scope.showDistrictsLevels1 = false;
 	$scope.showDistrictsLevels2 = true;
 	$scope.showDistrictsLevels3 = false;
 	$scope.showDistrictsLevels4 = false;

 	$scope.settingsCheck.districtLevel1 = false;
	$scope.settingsCheck.districtLevel2 = true;    
	$scope.settingsCheck.districtLevel3 = false;
	$scope.settingsCheck.districtLevel4 = false;
	
 	
 	$scope.showMeasuresTypes = false;
 	$scope.showMeasuresTypes0 = false;
 	$scope.showMeasuresTypes1 = false;
 	$scope.showMeasuresTypes2 = false;
 	$scope.showMeasuresTypes3 = false;
 	$scope.showMeasuresTypes4 = false;
 	
 	
 	$scope.settingsCheck.measureType0 = false;
	$scope.settingsCheck.measureType1 = false;
	$scope.settingsCheck.measureType2 = false;
	$scope.settingsCheck.measureType3 = false;
	$scope.settingsCheck.measureType4 = false;
	
	 
	//***RQ 02-2019***
 	$scope.showEventsTypes = false;     
 	$scope.showEventsTypes1 = true;
 	$scope.showEventsTypes2 = true;
 	$scope.showEventsTypes3 = false;    
 	$scope.showEventsTypes4 = false;    
 	$scope.showEventsTypes5 = false;    
 	
 	
 	$scope.settingsCheck.eventType1 = true;
	$scope.settingsCheck.eventType2 = true;
	$scope.settingsCheck.eventType3 = false;    
	$scope.settingsCheck.eventType4 = false;    
	$scope.settingsCheck.eventType5 = false;    
	
 	
 	$scope.showEventsMarkers = false;
 	$scope.showEventsMarkersRanking = true;
 	$scope.showEventsMarkersValue = false;
 	$scope.showEventsMarkersDuration = false;
 	$scope.showEventsMarkersDelta = false;
 	
 	$scope.settingsCheck.eventRanking = true;
	$scope.settingsCheck.eventValue = false;
	$scope.settingsCheck.eventDuration = false;
	$scope.settingsCheck.eventDelta = false;
 	
	$scope.showAreal = false;
 	$scope.showLinear = false;
 	$scope.showPunctual = false;
 	
 	$scope.settingsCheck.areal = false;
	$scope.settingsCheck.linear = false;
	$scope.settingsCheck.punctual = false;
	
	var showWmsView= new Object();
	var wmsLayer;
	$scope.wmsservices = null;
	$scope.wmsservices2 = null;

	/* END GC */

	// RF - inizializza i checkbox delle misure nella tabella
	$scope.showDistrictPressure = [];
	$scope.showDistrictFlow = [];
	// END RF
	
	Properties.getProperties(null, function (data) { //carica le properties
		$scope.dashboard_lat = data.data.dashboard_latitude;
		$scope.dashboard_long = data.data.dashboard_longitude;
		$scope.dashboard_zoom=data.data.dashboard_zoom;
		$scope.dashboard_lat = $scope.roundToTwo($scope.dashboard_lat);
		$scope.dashboard_long = $scope.roundToTwo($scope.dashboard_long);
		
			$scope.map.setView(new ol.View({
				center: ol.proj.transform([$scope.dashboard_long, $scope.dashboard_lat], 'EPSG:4326', 'EPSG:3857'),
		        zoom: $scope.dashboard_zoom
			}));
			
		});
 	
 	$scope.roundToTwo = function (num) {    
 	    return +(Math.round(num + "e+2")  + "e-2");
 	};
	
	
	$scope.getDashboardSettings = function(){
		DashboardSettings.getSettings(null, function (data){
			if(data.status == 'success'){
				
				if(data.data.dashboard_settings!=null)
					{
						$scope.settingsCheck = data.data.dashboard_settings;
						$scope.loadDashboardSettings();
					}
			
			}
			
		});
	};
	
	
	//aggiunge toglie il layer areale
 	$scope.updateAreal = function (){
 		if ($scope.showAreal){
 			$scope.areal = $scope.arealLayer();
 			$scope.map.addLayer($scope.areal); 
 		} else {
 			$scope.map.removeLayer($scope.areal);
 		}
 		
 		$scope.settingsCheck.areal = $scope.showAreal;
 		$scope.updateSettingsCheck();
 	}
 	
 	//aggiunge toglie il layer lineare
 	$scope.updateLinear = function (){
 		if ($scope.showLinear) {
 			$scope.linear = $scope.linearLayer();
 			$scope.map.addLayer($scope.linear); 
 		} else {
 			$scope.map.removeLayer($scope.linear);
 		}
 		
 		$scope.settingsCheck.linear = $scope.showLinear;
 		$scope.updateSettingsCheck();
 	}

 	//aggiunge toglie il layer puntuale
 	$scope.updatePunctual = function (){
 		if ($scope.showPunctual) {
 			$scope.punctual = $scope.punctualLayer();
 			$scope.map.addLayer($scope.punctual);
 		} else {
 			$scope.map.removeLayer($scope.punctual);
 		}
 		
 		$scope.settingsCheck.punctual = $scope.showPunctual;
 		$scope.updateSettingsCheck();
	}
	
	$scope.loadDashboardSettings = function(){
		
		$scope.showDistrictsLevels1 = $scope.settingsCheck.districtLevel1;
	 	$scope.showDistrictsLevels2 = $scope.settingsCheck.districtLevel2;
	 	$scope.showDistrictsLevels3 = $scope.settingsCheck.districtLevel3;
	 	$scope.showDistrictsLevels4 = $scope.settingsCheck.districtLevel4;
	 	
	 	$scope.showMeasuresTypes0 = $scope.settingsCheck.measureType0;
	 	$scope.showMeasuresTypes1 = $scope.settingsCheck.measureType1;
	 	$scope.showMeasuresTypes2 = $scope.settingsCheck.measureType2;
	 	$scope.showMeasuresTypes3 = $scope.settingsCheck.measureType3;
	 	$scope.showMeasuresTypes4 = $scope.settingsCheck.measureType4;
	 	
		$scope.showEventsTypes1 = $scope.settingsCheck.eventType1;
	 	$scope.showEventsTypes2 = $scope.settingsCheck.eventType2;
	 	$scope.showEventsTypes3 = $scope.settingsCheck.eventType3;
	 	$scope.showEventsTypes4 = $scope.settingsCheck.eventType4;
	 	$scope.showEventsTypes5 = $scope.settingsCheck.eventType5;
	 	
	 	$scope.showEventsMarkersRanking = $scope.settingsCheck.eventRanking;
	 	$scope.showEventsMarkersValue = $scope.settingsCheck.eventValue;
	 	$scope.showEventsMarkersDuration = $scope.settingsCheck.eventDuration;
	 	$scope.showEventsMarkersDelta = $scope.settingsCheck.eventDelta;
	 	
	 	$scope.radioItem = ''+$scope.settingsCheck.level;
	 	
	 	$scope.showAreal = $scope.settingsCheck.areal;
	 	$scope.showLinear = $scope.settingsCheck.linear;
	 	$scope.showPunctual = $scope.settingsCheck.punctual;
	 	
	 	$scope.updateAreal();
	 	$scope.updatePunctual();
	 	$scope.updateLinear();
	 	
	 	$scope.map.setView(new ol.View({
			center: ol.proj.transform([$scope.dashboard_long, $scope.dashboard_lat], 'EPSG:4326', 'EPSG:3857'),
	        zoom: $scope.settingsCheck.zoom
		}));
	 	
	};
	
	$scope.getDashboardSettings();
	
	
	
	/*GC - settaggio $log per debug*/
	$scope.$log = $log;
	
	$scope.dashboard_zoom=0;
	$scope.dashboard_lat=0;
	$scope.dashboard_long=0;
	
	
   //MC - carica i dati dei layer WMS dal servizio REST
    WmsServices1.getData(null, function (data) { //carica i wms
        $scope.wmssevices2 = data;
        $scope.addWmsLayer(data);
        $scope.wmslayersLoaded = true;

        	// RF - District.getData() è invocata in WmsServices1.getData() per assicurare che il layer dei distretti si trovi sopra il layer servizi.
	        Districts.getData(null, function (data) { //carica i distretti
			$scope.districts = data;
		 	$scope.addDestrictLayer();
		 	$scope.districtsLoaded = true;
		 	$scope.getFeatureOverlay();
		 	$scope.getEventsOverlay();

		 	// RF - Measures.getData() è invocata in Districts.getData() per assicurare che il layer delle misure si trovi sopra il layer dei distretti.
		 	Measures.getData(null, function (data) { //carica le misure
				$scope.measures = data;
	 			$scope.measuresLoaded = true;
				$scope.getFeatureOverlay();
				$scope.addMeasureLayer();
	        });

		});

	});

    $scope.arealLayer = function () {
								var layer = new ol.layer.Vector({
										source : new ol.source.KML({
											projection : ol.proj.get('EPSG:3857'),
											url : '/wetnet/rest/map-view/areal-kml'
										})
								});
								return layer;
							}
	
	$scope.linearLayer = function () {
								var layer = new ol.layer.Vector({
										source : new ol.source.KML({
											projection : ol.proj.get('EPSG:3857'),
											url : '/wetnet/rest/map-view/linear-kml'
										})
								});
								return layer;
							}

	$scope.punctualLayer = function () {
								var layer = new ol.layer.Vector({
										source : new ol.source.KML({
											projection : ol.proj.get('EPSG:3857'),
											url : '/wetnet/rest/map-view/punctual-kml'
										})
								});
								return layer;
							}
	
	
 	
 	
	
 	
 	$scope.out = 0;
 	//***RC 26/10/2015***
 	$scope.orderByField = '-delta_value';
 	//***END***
 	
 	$scope.eventLayer = new Object();
 	
 	/*GC 05/11/2015*/
 	$scope.districtLevelsLayer1 = new Object();
 	$scope.districtLevelsLayer2 = new Object();
 	$scope.districtLevelsLayer3 = new Object();
 	$scope.districtLevelsLayer4 = new Object();
 	
 	$scope.districtLevels1Source = new ol.source.GeoJSON();
 	$scope.districtLevels2Source = new ol.source.GeoJSON();
 	$scope.districtLevels3Source = new ol.source.GeoJSON();
 	$scope.districtLevels4Source = new ol.source.GeoJSON();
 	
 	$scope.measureTypeLayer0 = new Object();
 	$scope.measureTypeLayer1 = new Object();
 	$scope.measureTypeLayer2 = new Object();
 	$scope.measureTypeLayer3 = new Object();
 	$scope.measureTypeLayer4 = new Object();
 	
 	$scope.measureType0Source = new ol.source.GeoJSON();
 	$scope.measureType1Source = new ol.source.GeoJSON();
 	$scope.measureType2Source = new ol.source.GeoJSON();
 	$scope.measureType3Source = new ol.source.GeoJSON();
 	$scope.measureType4Source = new ol.source.GeoJSON(); 	
 	/* END GC */
 	
 	$scope.popup = new Object();
 	$scope.baseLayers = [];
 	$scope.geoJSONParser = new ol.format.GeoJSON();
 	$scope.districtSource = new ol.source.GeoJSON();
 	$scope.measureSource = new ol.source.GeoJSON();
 	 	
 	
 	
 	$scope.map = new ol.Map({
	  	  target: 'map',
	  	  controls: ol.control.defaults().extend([ new ol.control.ScaleLine({ units:'metric' }) ]),
	  	  view: new ol.View({
		    		  center: ol.proj.transform([10.6, 43.7], 'EPSG:4326', 'EPSG:3857'),
		    		  zoom: 10
	  		  		})
		});
 	
 	$scope.map.on("moveend", function() {
 		var zoom = $scope.map.getView().getZoom(); 
       
       $scope.settingsCheck.zoom = zoom;
       
       $scope.updateSettingsCheck();
   });
 	
 	$scope.eventBean = new Object();
	$scope.tempDate = new Date();
	$scope.eventBean.endDate = new Date($scope.tempDate.getFullYear(), $scope.tempDate.getMonth(), $scope.tempDate.getDate() - 1, 0, 0, 0);
	$scope.eventBean.startDate = new Date($scope.tempDate.getFullYear(), $scope.tempDate.getMonth(), $scope.tempDate.getDate() - 1, 0, 0, 0);
 	$scope.eventsSize = -1;

	$scope.loadEvents = function() { //carica gli eventi
		if ($scope.eventBean.startDate != undefined && $scope.eventBean.endDate != undefined) {
			
			//***RC 26/10/2015***
		 	//$scope.orderByField = '-ranking';
			$scope.orderByField = '-delta_value';
		 	//***END***
			$scope.eventBean.endDate = new Date($scope.eventBean.endDate.getFullYear(), $scope.eventBean.endDate.getMonth(), $scope.eventBean.endDate.getDate(), 0, 0, 0);
			$scope.eventBean.startDate = new Date($scope.eventBean.endDate.getFullYear(), $scope.eventBean.endDate.getMonth(), $scope.eventBean.endDate.getDate(), 0, 0, 0);
			
			Events.getEvents($scope.eventBean, function(data) {
												$scope.events = data;
												$scope.eventsOrig = data;
												$scope.eventsSize = data.length;
												$scope.eventsLoaded = true;
												$scope.getEventsOverlay();
											});
		}
	};
	
	
 	//crea la mappa
 	$scope.createMap = function(){
 			
 		$scope.baseLayers[0] = new ol.layer.Tile({ source: new ol.source.OSM() });
 		$scope.baseLayers[1] = new ol.layer.Tile({ source: new ol.source.MapQuest({layer: 'osm'}), visible: false });
 		$scope.baseLayers[2] = new ol.layer.Tile({ source: new ol.source.MapQuest({layer: 'sat'}), visible: false });
 		$scope.baseLayers[3] = new ol.layer.Group({ layers: [ new ol.layer.Tile({ source: new ol.source.MapQuest({layer: 'sat'})}),
                                                               new ol.layer.Tile({ source: new ol.source.MapQuest({layer: 'hyb'})}) ] });
 //      $scope.baseLayers[4] = new ol.layer.WMS('Sentieri TOSCANA','http://www502.regione.toscana.it/wmsraster/com.rt.wms.RTmap/wms?map=wmssentieristica&map_resolution=91&', {layers: 'rt_sent.idareecai.rt'});
         
 		$scope.baseLayers[3].setVisible(false);
 		

 		
 		$scope.map.addLayer($scope.baseLayers[0]);
 		$scope.map.addLayer($scope.baseLayers[1]);
 		$scope.map.addLayer($scope.baseLayers[2]);
 		$scope.map.addLayer($scope.baseLayers[3]);
// 		$scope.map.addLayer($scope.baseLayers[4]);
 		

 		//prova WMS
 		//http://www502.regione.toscana.it/wmsraster/com.rt.wms.RTmap/wms?map=wmsarprot
// 		$scope.baseLayers[4] = new ol.layer.Tile({
//            source: new ol.source.TileWMS({
//                url: 'http://www502.regione.toscana.it/wmsraster/com.rt.wms.RTmap/wms?map=wmssentieristica',
//                params: {'LAYERS': 'rt_sent.idsentcai.mvn 2005.rt', 'TILED': true},
//                serverType: 'geoserver'
//              })
//            });

 //		$scope.map.addLayer($scope.baseLayers[4]);
 		      
         //registra l'onMouseMove sulla mappa
         $($scope.map.getViewport()).on('mousemove', function(evt) {
        	 $scope.displayFeatureInfo($scope.map.getEventPixel(evt.originalEvent));
     	 });
         
         //registra l'onSingleClick sulla mappa
         $scope.map.on('singleclick', function(evt) {
        	 $scope.goToLocation($scope.map.getEventPixel(evt.originalEvent));
     	 });
         
         $scope.popup = new ol.Overlay({
				           element: $("#popup"),
				           positioning: 'bottom-center',
				           stopEvent: false
				         });
         $scope.map.addOverlay($scope.popup);
     };
 	
     
      $scope.loadEvents(); //carica gli eventi
	 $scope.createMap(); //crea la mappa
 	
 	//aggiunge il layer dei distretti alla mappa
 	$scope.addDestrictLayer = function(){
 		$scope.addDistrictsTypesLayer();
 	}
 	
 	$scope.addDistrictsTypesLayer = function(){
 		 for (var i=0, len=$scope.districts.length; i < len; i++){
	        if ($scope.districts[i].map && $scope.districts[i].mapLevel)
	        {
	        	$scope.districtSource.addFeatures($scope.geoJSONParser.readFeatures($scope.districts[i].map));
	        
		        	if($scope.districts[i].mapLevel == 1)
		        	{
		        		$scope.districtLevels1Source.addFeatures($scope.geoJSONParser.readFeatures($scope.districts[i].map));
		        	}
		        	else if($scope.districts[i].mapLevel == 2)
		        	{
		        		$scope.districtLevels2Source.addFeatures($scope.geoJSONParser.readFeatures($scope.districts[i].map));
		        	}
		        	else if($scope.districts[i].mapLevel == 3)
		        	{
		        		$scope.districtLevels3Source.addFeatures($scope.geoJSONParser.readFeatures($scope.districts[i].map));
		        	}
		        	else if($scope.districts[i].mapLevel == 4)
		        	{
		        		$scope.districtLevels4Source.addFeatures($scope.geoJSONParser.readFeatures($scope.districts[i].map));
		        	}
 		      }
	       }
         
 		 //Districts Level 1
 		var styleCacheD = {};
        $scope.districtLevel1Layer = new ol.layer.Vector({
            source: $scope.districtLevels1Source,
            style : function(feature, resolution) {
            	if (feature.get('visible') != undefined && !feature.get('visible'))
					return null;
				var text = resolution < 50 || feature.get('highlighted') ? feature.get('name') : '';
				var fillColor = feature.get('highlighted') ? 'rgba(0, 200, 255, 0.25)' : 'rgba(255, 255, 255, 0.6)';
				var styleId = text + fillColor;
				if (!styleCacheD[styleId]) {
					styleCacheD[styleId] = [ new ol.style.Style({
						zIndex: 4,
						fill : new ol.style.Fill({
							color : fillColor
						}),
						stroke : new ol.style.Stroke({
							color : '#319FD3',
							width : 2
						}),
						text : new ol.style.Text({
							font : '13px Calibri, sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							offsetY: -17,
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'lightgrey',
								width : 1
							})
						})
					}) ];
				}
				return styleCacheD[styleId];
			}
        });
        
        $scope.map.addLayer($scope.districtLevel1Layer);
        
        
        
        //Districts Level 2
 		styleCacheD = {};
        $scope.districtLevel2Layer = new ol.layer.Vector({
            source: $scope.districtLevels2Source,
            style : function(feature, resolution) {
            	if (feature.get('visible') != undefined && !feature.get('visible'))
					return null;
				var text = resolution < 50 || feature.get('highlighted') ? feature.get('name') : '';
				var fillColor = feature.get('highlighted') ? 'rgba(0, 200, 255, 0.25)' : 'rgba(255, 255, 255, 0.6)';
				var styleId = text + fillColor;
				if (!styleCacheD[styleId]) {
					styleCacheD[styleId] = [ new ol.style.Style({
						fill : new ol.style.Fill({
							color : fillColor
						}),
						stroke : new ol.style.Stroke({
							color : '#319FD3',
							width : 2
						}),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							offsetY: -17,
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'lightgrey',
								width : 1
							})
						})
					}) ];
				}
				return styleCacheD[styleId];
			}
        });
        
        $scope.map.addLayer($scope.districtLevel2Layer);
        
        //Districts Level 3
 		styleCacheD = {};
        $scope.districtLevel3Layer = new ol.layer.Vector({
            source: $scope.districtLevels3Source,
            style : function(feature, resolution) {
            	if (feature.get('visible') != undefined && !feature.get('visible'))
					return null;
				var text = resolution < 50 || feature.get('highlighted') ? feature.get('name') : '';
				var fillColor = feature.get('highlighted') ? 'rgba(0, 200, 255, 0.25)' : 'rgba(255, 255, 255, 0.6)';
				var styleId = text + fillColor;
				if (!styleCacheD[styleId]) {
					styleCacheD[styleId] = [ new ol.style.Style({
						fill : new ol.style.Fill({
							color : fillColor
						}),
						stroke : new ol.style.Stroke({
							color : '#319FD3',
							width : 2
						}),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							offsetY: -17,
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'lightgrey',
								width : 1
							})
						})
					}) ];
				}
				return styleCacheD[styleId];
			}
        });
        
        $scope.map.addLayer($scope.districtLevel3Layer);
        
        //Districts Level 4
 		styleCacheD = {};
        $scope.districtLevel4Layer = new ol.layer.Vector({
            source: $scope.districtLevels4Source,
            style : function(feature, resolution) {
            	if (feature.get('visible') != undefined && !feature.get('visible'))
					return null;
				var text = resolution < 50 || feature.get('highlighted') ? feature.get('name') : '';
				var fillColor = feature.get('highlighted') ? 'rgba(0, 200, 255, 0.25)' : 'rgba(255, 255, 255, 0.6)';
				var styleId = text + fillColor;
				if (!styleCacheD[styleId]) {
					styleCacheD[styleId] = [ new ol.style.Style({
						fill : new ol.style.Fill({
							color : fillColor
						}),
						stroke : new ol.style.Stroke({
							color : '#319FD3',
							width : 2
						}),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							offsetY: -17,
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'lightgrey',
								width : 1
							})
						})
					}) ];
				}
				return styleCacheD[styleId];
			}
        });
        
        $scope.map.addLayer($scope.districtLevel4Layer);
        
        $scope.updateDistricstView();      
 	}
 	
 	
 	/* END GC*/

 	// RF - nasconde i distretti a cui e' associato l'evento di tipo 'type'
 	$scope.hideDistrictByEventType = function(checked, type = null) {
 		// console.log('I am hideDistrictByEventType(%d)', type);
 		if (checked) return; // non eseguire nulla se il checkbox e' stato selezionato
 		var districtId = [], features;
 		for (var i = 0; type && i < $scope.events.length; i++) {
 			if ($scope.events[i].type == type) {
 				districtId.push($scope.events[i].districts_id_districts);
 			}
 		}
 		var layers = [$scope.districtLevel1Layer, $scope.districtLevel2Layer, $scope.districtLevel3Layer, $scope.districtLevel4Layer];
 		for (i = 0; i < layers.length; i++) {
 			if (!layers[i].getVisible())
 				continue; 
 			features = layers[i].getSource().getFeatures();
 			for(var j = 0; j < features.length; j++) {
 				if (type == null || districtId.includes(features[j].get('id'))) {
 					features[j].set('visible', false);
 					// console.log('District hidden: id=%d', features[j].get('id'));
 				}
 			}
 		}
 	}

 	/* GC 05/11/2015*/
 	//aggiunge il layer delle misure alla mappa
 	$scope.addMeasureLayer = function(){
 		$scope.addMeasuresTypesLayer();
 	}
 	
 	
 	$scope.addMeasuresTypesLayer = function(){
		 for (var i=0, len = $scope.measures.length; i < len; i++){
 	        if ($scope.measures[i].map)
 	        	{
	 	        	$scope.measureSource.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
	 	        	
	 	        	if($scope.measures[i].type == 0)
		        	{
	 	        		$scope.measureType0Source.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
		        	}
	 	        	else if($scope.measures[i].type == 1)
		        	{
	 	        		$scope.measureType1Source.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
		        	}
		        	else if($scope.measures[i].type == 2)
		        	{
		        		$scope.measureType2Source.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
		        	}
		        	else if($scope.measures[i].type == 3)
		        	{
		        		$scope.measureType3Source.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
		        	}
		        	else if($scope.measures[i].type == 4)
		        	{
		        		$scope.measureType4Source.addFeatures($scope.geoJSONParser.readFeatures($scope.measures[i].map));
		        	}
 	        	}
        }
		 
		 
		 //measure type 0 
		var styleCacheM0 = {};
		$scope.measureTypeLayer0 = new ol.layer.Vector({
           source: $scope.measureType0Source,
           visible: false,
           style : function(feature, resolution) {
           	var text = resolution < 50 ? feature.get('name') : '';
				if (!styleCacheM0[text]) {
					styleCacheM0[text] = [ new ol.style.Style({
						image: new ol.style.Circle({
				               radius: 6,
				               fill: new ol.style.Fill({color: 'rgba(255, 0, 0, 0.5)'}),
				               stroke: new ol.style.Stroke({color: 'rgba(255, 0, 0, 0.6)', width: 2})
				             }),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'white',
								width : 1
							})
						})
					}) ];
				}
				
				return styleCacheM0[text];
			}
       });
       
	   $scope.measureTypeLayer0.setVisible(false);
       $scope.map.addLayer($scope.measureTypeLayer0);
       
       
       //measure type 1 
		var styleCacheM1 = {};
		$scope.measureTypeLayer1 = new ol.layer.Vector({
          source: $scope.measureType1Source,
          visible: false,
          style : function(feature, resolution) {
          	var text = resolution < 50 ? feature.get('name') : '';
				if (!styleCacheM1[text]) {
					styleCacheM1[text] = [ new ol.style.Style({
						image: new ol.style.Circle({
				               radius: 6,
				               fill: new ol.style.Fill({color: 'rgba(0, 0, 100, 0.5)'}),
				               stroke: new ol.style.Stroke({color: 'rgba(0, 0, 100, 0.6)', width: 2})
				             }),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'white',
								width : 1
							})
						})
					}) ];
				}
				return styleCacheM1[text];
			}
      });
      
	   $scope.measureTypeLayer1.setVisible(false);
      $scope.map.addLayer($scope.measureTypeLayer1);
      
      //measure type 2 
		var styleCacheM2 = {};
		$scope.measureTypeLayer2 = new ol.layer.Vector({
         source: $scope.measureType2Source,
         visible: false,
         style : function(feature, resolution) {
         	var text = resolution < 50 ? feature.get('name') : '';
				if (!styleCacheM2[text]) {
					styleCacheM2[text] = [ new ol.style.Style({
						image: new ol.style.Circle({
				               radius: 6,
				               fill: new ol.style.Fill({color: 'rgba(0, 120, 255, 0.5)'}),
				               stroke: new ol.style.Stroke({color: 'rgba(0, 120, 255, 0.6)', width: 2})
				             }),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'white',
								width : 1
							})
						})
					}) ];
				}
				
				return styleCacheM2[text];
			}
     });
     
	   $scope.measureTypeLayer2.setVisible(false);
     $scope.map.addLayer($scope.measureTypeLayer2);
       
   //measure type 3 
		var styleCacheM3 = {};
		$scope.measureTypeLayer3 = new ol.layer.Vector({
      source: $scope.measureType3Source,
      visible: false,
      style : function(feature, resolution) {
      	var text = resolution < 50 ? feature.get('name') : '';
				if (!styleCacheM3[text]) {
					styleCacheM3[text] = [ new ol.style.Style({
						image: new ol.style.Circle({
				               radius: 6,
				               fill: new ol.style.Fill({color: 'rgba(115, 0, 230, 0.5)'}),
				               stroke: new ol.style.Stroke({color: 'rgba(115, 0, 230, 0.6)', width: 2})
				             }),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'white',
								width : 1
							})
						})
					}) ];
				}
				
				return styleCacheM3[text];
			}
  });
  
	   $scope.measureTypeLayer3.setVisible(false);
	   $scope.map.addLayer($scope.measureTypeLayer3);
	   

	 //measure type 4 
		var styleCacheM4 = {};
		$scope.measureTypeLayer4 = new ol.layer.Vector({
        source: $scope.measureType4Source,
        visible: false,
        style : function(feature, resolution) {
        	var text = resolution < 50 ? feature.get('name') : '';
				if (!styleCacheM4[text]) {
					styleCacheM4[text] = [ new ol.style.Style({
						image: new ol.style.Circle({
				               radius: 6,
				               fill: new ol.style.Fill({color: 'rgba(0, 80, 0, 0.5)'}),
				               stroke: new ol.style.Stroke({color: 'rgba(0, 80, 0, 0.6)', width: 2})
				             }),
						text : new ol.style.Text({
							font : '13px Calibri,sans-serif',
							text : text,
							textAlign: 'center',
							textBaseline: 'bottom',
							fill : new ol.style.Fill({
								color : '#000'
							}),
							stroke : new ol.style.Stroke({
								color : 'white',
								width : 1
							})
						})
					}) ];
				}
				
				return styleCacheM4[text];
			}
    });
    
	$scope.measureTypeLayer4.setVisible(false);
    $scope.map.addLayer($scope.measureTypeLayer4);
    
    
    $scope.updateMeasuresView();    
}

	/*
		RF - visualizza o nasconde (visible=true/false) le misure associate ad un distretto.
		Agisce sulle misure di tipo measureType o su tutte, se tale parametro e' ommesso.
	*/
	$scope.displayMeasuresInDistrict = function(visible, districtId, measureType = null) {
		// console.log("I am displayMeasuresInDistrict(%s, %d, %d)", visible, districtId, measureType);
		var layerName = "district_measures_" + districtId;
		if (visible)
			$scope.hideMeasuresTypesLayers();
		if ($scope.eventBean.districtsSelected && measureType != null) 
			$scope.hideMeasuresInDistricts(false);
		var layer = $scope.findDitrictMeasuresLayer(layerName);
		if (layer) {
			var features = layer.getSource().getFeatures();
			// console.log('Features: %O', features);
			for (var i = 0; i < features.length; i++) {
				if (measureType == null || features[i].get('measureType') == measureType) {
					features[i].set('visible', visible);
				}
			}
			layer.setVisible(true);
		}
		else
			$scope.addDistrictMeasuresLayer(districtId, measureType);
 	}

 	// RF - aggiunge layer con le misure associate ad un certo distretto.
 	$scope.addDistrictMeasuresLayer = function(districtId, measureType) {
 		// console.log("I am addDistrictMeasuresLayer(%d)", districtId);
		Measures.getDataByDistrictId({districtId: districtId, withSign: false}, function(measures) {
			// console.log("Received measures: %O", measures);
			var features, layerSource = new ol.source.GeoJSON();
			for (var i = 0; i < measures.length; i++) {
				features = $scope.geoJSONParser.readFeatures(measures[i].map);
				features.forEach(function(f) {
					f.set('measureType', measures[i].type);
				});
				// console.log(features);
				layerSource.addFeatures(features);
			}
			if (layerSource.getFeatures().length > 0) {
				// Crea layer
				var styleCache = [{}, {}, {}, {}, {}]; // cache per 5 tipi di misure
				var fillColors = ['rgba(255, 0, 0, 0.5)', 'rgba(0, 0, 100, 0.5), rgba(0, 120, 255, 0.5), rgba(115, 0, 230, 0.5), rgba(0, 80, 0, 0.5)'];
				var strokeColors = ['rgba(255, 0, 0, 0.6)', 'rgba(0, 0, 100, 0.6), rgba(0, 120, 255, 0.6), rgba(115, 0, 230, 0.6), rgba(0, 80, 0, 0.6)'];
				var layer = new ol.layer.Vector({
	        		source: layerSource,
	        		visible: false,
	        		style : function(feature, resolution) {
	        			if (!feature.get('visible'))
							return null;
	        			var text = resolution < 50 ? feature.get('name') : '';
	        			var mType = feature.get('measureType');
						if (!styleCache[mType][text]) {
							styleCache[mType][text] = [ new ol.style.Style({
								image: new ol.style.Circle({
									radius: 6,
									fill: new ol.style.Fill({color: fillColors[mType]}),
									stroke: new ol.style.Stroke({color: strokeColors[mType], width: 2})
								}),
								text: new ol.style.Text({
									font: '13px Calibri,sans-serif',
									text: text,
									textAlign: 'center',
									textBaseline: 'bottom',
									fill: new ol.style.Fill({
										color : 'black'
									}),
									stroke: new ol.style.Stroke({
										color : 'white',
										width : 1
									})
								})
							}) ];
						}
						return styleCache[mType][text];
					}
				});
				// aggiungi layer alla mappa
				var layerName = "district_measures_" + districtId;
				layer.set('name', layerName);
				layer.set('group', 'district_measures');
				$scope.map.addLayer(layer);
				// console.log("Added layer: name=%s, features.length=%d ", layerName, layerSource.getFeatures().length);
				$scope.displayMeasuresInDistrict(true, districtId, measureType);
			}
		});
 	}

 	// RF - nasconde tutti i layer con le misure associate ai distretti
 	$scope.hideMeasuresInDistricts = function(uncheck = true) {
 		// console.log("I am hideMeasuresInDistricts()");
 		$scope.map.getLayers().forEach(function(l) {
			if (l.get('group') != undefined && l.get('group') === "district_measures") {
				var features = l.getSource().getFeatures();
				for (var i = 0; i < features.length; i++)
					features[i].set('visible', false);
				l.setVisible(false);
			}
		});
		if (uncheck) {
			// Uncheck checkbox relativi alle misure
	 		$scope.showDistrictFlow = [];
	 		$scope.showDistrictPressure = [];
 		}
 	}

 	// RF - nasconde tutti i layer con le misure 
 	$scope.hideMeasuresTypesLayers = function() {
 		// console.log("I am hideMeasuresTypesLayers()");
 		$scope.showMeasuresTypes = false;
 		$scope.updateMeasuresTypesCheck();
 	}

 	// RF - carica le misure di tutti i tipi associate ad un distretto
 	$scope.loadDistrictMeasures = function(districtId, districtName) {
 		// console.log("I am loadDistrictMeasures(%d, %s)", districtId, districtName);
 		if ($scope.districtMeasures) {
 			$scope.districtMeasures = null;
 		}
 		var resp = MeasuresHasDistricts.getByDistrictsId({districts_id: districtId}, function() {
 			// console.log("Loaded measures: %O", resp);
 			$scope.districtMeasures = resp.data.measures;
 			$scope.modalDistrictName = districtName;
 		});
 	}

 	// RF
 	$scope.findDitrictMeasuresLayer = function(name) {
 		// console.log("I am findDitrictMeasuresLayer(%s)", name);
 		var layer;
 		var layers = $scope.map.getLayers().forEach(function(l) {
 			if (l.get('name') != undefined && l.get('name') === name) {
				// console.log("Layer found: name=%s", name);
				layer = l;
			}
 		});
		return layer;
 	}

 	// RF - ritorna oggetto misura che e' stato precaricato nella lista $scope.measures con id specificato 
 	$scope.findMeasureById = function(id) {
 		var list = $scope.measures;
 		for (var i = 0; i < list.length; i++) {
 			// console.log("findMeasureById: %O", list[i]);
 			if (list[i].idMeasures === id)
 				return list[i];
 		}
 	}

    //MC - aggiunge il layer dei wms alla mappa
 	$scope.addWmsLayer = function(data){
 	    wmsLayer = [];
        var wmsservices = data;
 		for (var i=0; i<wmsservices.length; i++){
 			      showWmsView[wmsservices[i].name] = false;
 		          wmsLayer[wmsservices[i].name] = new ol.layer.Tile({
                                                  source: new ol.source.TileWMS({
                                                      url: wmsservices[i].url,
                                                      params: {'LAYERS': wmsservices[i].layer, 'TILED': true},
                                                      serverType: wmsservices[i].serverType
                                                    })
                                                  });
 	            wmsLayer[wmsservices[i].name].setVisible(false);
	            $scope.map.addLayer(wmsLayer[wmsservices[i].name]);
 		}
 	}
 	
 	//costruisce l'Overlay per tutte le features della mappa
 	$scope.getFeatureOverlay = function(){
 		if ($scope.districtsLoaded && $scope.measuresLoaded){
	        $scope.highlightStyleCache = {};
	 		 $scope.featureOverlay = new ol.FeatureOverlay({
	    		map : $scope.map,
	    		style : function(feature, resolution) {
	    			var type = feature.get('type');
	    			if (type !== 'event'){
	    				var offsetY = (type === 'district') ? -17 : 0;
	    				//***RC 04/11/2015***
	    				
	    				if (type !== 'measure'){
	    					var text = resolution < 1500 ? feature.get('name') : '';
	    				}else{
	    					var text = '';
	    				}
	    				//***END***
		    			if (!$scope.highlightStyleCache[text]) {
		    				$scope.highlightStyleCache[text] = [ new ol.style.Style({
		    					stroke : new ol.style.Stroke({
		    						color : 'rgba(0, 0, 255, 0.6)',
		    						width : 2
		    					}),
		    					fill : new ol.style.Fill({
		    						color : 'rgba(0, 0, 255, 0.3)'
		    					}),
		    					image: new ol.style.Circle({
						               radius: 6,
						               fill: new ol.style.Fill({color: 'rgba(0, 0, 0, 0.1)'}),
						               stroke: new ol.style.Stroke({color: 'rgba(0, 0, 0, 0.5)', width: 3})
						             }),
		    					text : new ol.style.Text({
		    						font : '13px Calibri,sans-serif',
		    						text : text,
		    						textAlign: 'center',
									textBaseline: 'bottom',
									offsetY: offsetY,
		    						fill : new ol.style.Fill({
		    							color : '#000'
		    						}),
		    						stroke : new ol.style.Stroke({
		    							color : 'grey',
		    							width : 1
		    						})
		    					})
		    				}) ];
		    			}
		    			return $scope.highlightStyleCache[text];
	    			}
	    		}
	    	 });
 		}
 	}
 	
 	//***RC 02/11/2015***
 	$scope.retrieveOrientationDegrees = function(name) {
 		for (var i=0, len = $scope.measures.length; i < len; i++){
  	        if ($scope.measures[i].name == name)
  	        	{
  	        	return $scope.measures[i].orientation_degrees;
  	        	}
         }
 	} 	
 	//***END***	
 	
 	$scope.highlight;
 	$scope.displayFeatureInfo = function(pixel) { //evidenzia la feature selezionata col mouse
 		var feature = $scope.map.forEachFeatureAtPixel(pixel, function(feature, layer) {
 			$scope.findMeasureById(2)
			return feature;
		});
		
		if (feature !== $scope.highlight) {
			if ($scope.highlight) {
				if ($scope.highlight.get('type') === 'district')
					$scope.highlight.set('highlighted', false);
				else
					$scope.featureOverlay.removeFeature($scope.highlight);

				//***RC 02/11/2015***
				$("#popup").popover('destroy');
				//***END***	
			}
			if (feature) {
				if(feature.get('type') === 'district') {
					// RF - non creare overlay per distretto
					feature.set('highlighted', true);
				}
				//***RC 02/11/2015***
    			else if (feature.get('type') === 'measure') {
    				$scope.featureOverlay.addFeature(feature);
    				var od = $scope.retrieveOrientationDegrees(feature.get('name'));
    				var coord = feature.getGeometry().getCoordinates();
				    $scope.popup.setPosition(coord);
				    $("#popup").popover({
				      'placement': 'top',
				      'html': true,
				      'title': '<strong>' + feature.get('name') + '</strong>',
				      'content':'<div style="width:50px; position:relative;">' +
                                    '<img src="../images/cassa.png" style="position:absolute; width:100%; height:auto;">' +
                                    '<img id="image_canv" src="../images/puntatore.png" style="width:100%; height:auto; -webkit-transform: rotate(' +od +'deg); -moz-transform: rotate(' +od +'deg); -o-transform: rotate(' +od +'deg); -ms-transform: rotate(' +od +'deg); transform: rotate(' +od +'deg);">' +
                                '</div>' +
                                '<div>' +
                                    '<b>Id</b>: ' + feature.get('id') +
                                    '<br><b>Tag</b>: ' + $scope.findMeasureById(feature.get('id')).table_name +
                                    '<br><b>Strumentation type</b>: ' + MEASURE_STRUMENTATION_TYPES[$scope.findMeasureById(feature.get('id')).strumentation_type] +
                                '</div>'
				    });
				    $("#popup").popover('show');
				}
    			//***END***	
			}
			$scope.highlight = feature;
		}
	};

	//va alla sezione modifica del configuratore per distretti e misure e mostra la popup per gli eventi
	$scope.goToLocation = function(pixel) {
		var feature = $scope.map.forEachFeatureAtPixel(pixel, function(feature, layer) {
			return feature;
		});
		if (feature) {
			var type = feature.get('type');
			var id = feature.get('id');
			if (type){
				if (type === 'measure') {
					//***RC 03/11/2015***
					//window.location.href = '/wetnet/manager/measure?id=' + id;
					var currentDate = new Date();
					var dd = currentDate.getDate();
					var mm = currentDate.getMonth()+1;
					var yyyy = currentDate.getFullYear();

					if(dd<10) {
					    dd='0'+dd;
					} 
					if(mm<10) {
					    mm='0'+mm;
					} 
					
					currentDate = yyyy +'-' +mm +'-' +dd;
					window.location.href = '/wetnet/graphics/statistic-g2M?idMeasures=' +id +'&day=' +currentDate +'&duration=4';
					//***END***
				} else if (type === 'district') {
				 	$scope.eventBean.districtsSelected = new Object();
					$scope.eventBean.districtsSelected.idDistricts = id;
					$scope.eventBean.districtsSelected.name = feature.get('name');
					// RF
					$scope.hideMeasuresInDistricts();
					$scope.hideMeasuresTypesLayers();
					$scope.displayMeasuresInDistrict(true, id);
					// END RF
					$scope.loadEvents();
				} 
				if (type === 'event') {
					var coord = feature.getGeometry().getCoordinates();
				    $scope.popup.setPosition(coord);
				    $("#popup").popover({
				      'placement': 'top',
				      'html': true,
				      'title': '<strong>' + feature.get('district') + '</strong>',
				      'content': '<p>' + feature.get('description') + '</p>' + '<p><i>Ranking = ' +  feature.get('ranking') + '</i></p>' + '</p>' + '<p><i>Delta value = ' +  feature.get('deltavalue') + '</i></p>'
				    });
				    $("#popup").popover('show');
				} else {
					$("#popup").popover('destroy');
				}
			}
		} else {
			$("#popup").popover('destroy');
		}
		
	};
	
	//gestisce il menu di cambio del base layer
 	$scope.switchLayer = function (elem){
 		
 		 for (var i = 0, len = $scope.baseLayers.length; i < len; i++){

 			 $scope.baseLayers[i].setVisible(i == $scope.radioItem); 
 		 }
 		$scope.settingsCheck.level=elem;
 		$scope.updateSettingsCheck();
 	}
 	
 	//mostra nasconde i layers di distretti e misure
 	$scope.updateView = function (){
 		
 		/*GC 05/11/2015*/
 		$scope.updateDistricstView();
 		$scope.updateMeasuresView();
 		$scope.getEventsOverlay();
 	}
 	
 	
 	/*GC 05/11/2015*/
 	$scope.updateDistricstView = function (){
 		$scope.districtLevel1Layer.setVisible($scope.showDistrictsLevels1);
 		$scope.districtLevel2Layer.setVisible($scope.showDistrictsLevels2);
 		$scope.districtLevel3Layer.setVisible($scope.showDistrictsLevels3);
 		$scope.districtLevel4Layer.setVisible($scope.showDistrictsLevels4);
 		
 		$scope.settingsCheck.districtLevel1 = $scope.showDistrictsLevels1;
 		$scope.settingsCheck.districtLevel2 = $scope.showDistrictsLevels2;
 		$scope.settingsCheck.districtLevel3 = $scope.showDistrictsLevels3;
 		$scope.settingsCheck.districtLevel4 = $scope.showDistrictsLevels4;

 		$scope.updateSettingsCheck();
 	}

 	// RF - rende visibili le feature che rappresentano i distretti
	$scope.makeDistrictsVisible = function(districtLevel = null) {
 		var models = [$scope.showDistrictsLevels1, $scope.showDistrictsLevels2, $scope.showDistrictsLevels3, $scope.showDistrictsLevels4];
 		var layers = [$scope.districtLevel1Layer, $scope.districtLevel2Layer, $scope.districtLevel3Layer, $scope.districtLevel4Layer];
 		var features, i;
 		if (!districtLevel && $scope.showDistrictsLevels) {
 			for (i = 0; i < layers.length; i++)
 				$scope.makeOLFeaturesVisible(layers[i].getSource().getFeatures());
 			return;
 		}
 		i = districtLevel - 1;
 		if (models[i])
 			$scope.makeOLFeaturesVisible(layers[i].getSource().getFeatures());
 	}

 	//RF - rende visibili le feature di un layer (NB: la proprieta' "visible" non e' built-in di ol.Feature)
 	$scope.makeOLFeaturesVisible = function (features) {
 		for(var i = 0; i < features.length; i++)
 			features[i].set('visible', true);
 	}
 	
 	$scope.updateMeasuresView = function (){
 		$scope.measureTypeLayer0.setVisible($scope.showMeasuresTypes0);
 		$scope.measureTypeLayer1.setVisible($scope.showMeasuresTypes1);
 		$scope.measureTypeLayer2.setVisible($scope.showMeasuresTypes2);
 		$scope.measureTypeLayer3.setVisible($scope.showMeasuresTypes3);
 		$scope.measureTypeLayer4.setVisible($scope.showMeasuresTypes4);
	
 		
 		$scope.settingsCheck.measureType0 = $scope.showMeasuresTypes0;
 		$scope.settingsCheck.measureType1 = $scope.showMeasuresTypes1;
 		$scope.settingsCheck.measureType2 = $scope.showMeasuresTypes2;
 		$scope.settingsCheck.measureType3 = $scope.showMeasuresTypes3;
 		$scope.settingsCheck.measureType4 = $scope.showMeasuresTypes4;

 		// RF
 		if ($scope.showMeasuresTypes0 || $scope.showMeasuresTypes1 || $scope.showMeasuresTypes2 || $scope.showMeasuresTypes3 || $scope.showMeasuresTypes4) 
 			$scope.hideMeasuresInDistricts();
 		
 		$scope.updateSettingsCheck();
 	}
 	
 	$scope.updateDistrictsLevelsCheck = function()
 	{
 		$scope.showDistrictsLevels1 = $scope.showDistrictsLevels;
 	 	$scope.showDistrictsLevels2 = $scope.showDistrictsLevels;
 	 	$scope.showDistrictsLevels3 = $scope.showDistrictsLevels;
 	 	$scope.showDistrictsLevels4 = $scope.showDistrictsLevels;
 	 	
 	 	$scope.updateView();
 	}
 	
 	$scope.updateMeasuresTypesCheck = function()
 	{
 		$scope.showMeasuresTypes0 = $scope.showMeasuresTypes;
 	 	$scope.showMeasuresTypes1 = $scope.showMeasuresTypes;
 	 	$scope.showMeasuresTypes2 = $scope.showMeasuresTypes;
 	 	$scope.showMeasuresTypes3 = $scope.showMeasuresTypes;
 	 	$scope.showMeasuresTypes4 = $scope.showMeasuresTypes;
 	 	
 	 	$scope.updateView();
 	}
 	
 	$scope.updateEventsTypesCheck = function()
 	{
 		$scope.showEventsTypes1 = $scope.showEventsTypes;
 	 	$scope.showEventsTypes2 = $scope.showEventsTypes;
 	 	$scope.showEventsTypes3 = $scope.showEventsTypes;
 	 	$scope.showEventsTypes4 = $scope.showEventsTypes;
 	 	$scope.showEventsTypes5 = $scope.showEventsTypes;

 	 	$scope.updateView();
 	}
 	
 	$scope.updateEventsMarkersCheck = function()
 	{
 		$scope.showEventsMarkersRanking = $scope.showEventsMarkers;
 	 	$scope.showEventsMarkersValue = $scope.showEventsMarkers;
 	 	$scope.showEventsMarkersDuration = $scope.showEventsMarkers;
 	 	$scope.showEventsMarkersDelta = $scope.showEventsMarkers;
 	 	
 	 	$scope.getEventsOverlay();
 	}
 	/** end GC ***/
//Massimo Costantini - funzione per accendere e spegnare i layer WMS
 	$scope.updateWmsView = function(layer)
    {
 		wmsLayer[layer].setVisible(!wmsLayer[layer].getVisible());
 		$scope.updateView();
    }
 	
 	
 	
 	//fa lo zoom sul distretto e carica i suoi eventi
 	$scope.districtSelectedZoom = function($item, $model, $label) {
 		var feature;
 		var features = $scope.districtSource.getFeatures();
	  	for (var i = 0, len = features.length; i < len; i++){
	  		if ($model.idDistricts === features[i].get('id')){
	  			feature = features[i];
	  			break;
	  		}
	  	}
	  	if (feature){
			var polygon = feature.getGeometry();
			var size = $scope.map.getSize();
			$scope.map.getView().fitGeometry(polygon, size, {
				padding : [ 70, 70, 70, 70 ]
			});
			
			$scope.eventBean.districtsSelected = $model;
			$scope.loadEvents();
	  	}
	};
 	
 	//fa lo zoom sulla misura
 	$scope.measureSelectedZoom = function($item, $model, $label) {
		var feature;
 		var features = $scope.measureSource.getFeatures();
	  	for (var i = 0, len = features.length; i < len; i++){
	  		if ($model.idMeasures === features[i].get('id')){
	  			feature = features[i];
	  			break;
	  		}
	  	}
	  	if (feature){
			var point = feature.getGeometry();
			var size = $scope.map.getSize();
			$scope.map.getView().fitGeometry(point, size, {
				padding : [ 70, 70, 70, 70 ],
				minResolution: 20
			});
	  	}
	};
 	
 	//individua il distretto cliccando sulla lista eventi
 	$scope.fromListToMap = function(id){
 		var feature;
 		var features = $scope.districtSource.getFeatures();
	  	for (var i = 0, len = features.length; i < len; i++){
	  		if (id === features[i].get('id')){
	  			feature = features[i];
	  			break;
	  		}
	  	}
	  	if (feature){
			var polygon = feature.getGeometry();
			var size = $scope.map.getSize();
			$scope.map.getView().fitGeometry(polygon, size, {
				padding : [ 70, 70, 70, 70 ]
			});
	  	}
 	};
 	
 	/* GC 05/11/2015*/
 	
 	
 	//crea layer con icone degli eventi e ranking
 	$scope.getEventsOverlay = function(){
 		if ($scope.eventsLoaded && $scope.districtsLoaded){
 			
 			$scope.settingsCheck.eventType1 = $scope.showEventsTypes1;
 			$scope.settingsCheck.eventType2 = $scope.showEventsTypes2;
 			$scope.settingsCheck.eventType3 = $scope.showEventsTypes3;
 			$scope.settingsCheck.eventType4 = $scope.showEventsTypes4;
 			$scope.settingsCheck.eventType5 = $scope.showEventsTypes5;
 			$scope.settingsCheck.eventRanking = $scope.showEventsMarkersRanking;
 			$scope.settingsCheck.eventValue = $scope.showEventsMarkersValue;
 			$scope.settingsCheck.eventDuration = $scope.showEventsMarkersDuration;
 			$scope.settingsCheck.eventDelta = $scope.showEventsMarkersDelta;
 			
 			$scope.updateSettingsCheck();
 			
 			var vectorSource = new ol.source.Vector();
 			
 			if (!$scope.eventBean.districtsSelected) $scope.out = 0;
 			for (var i=0, len=$scope.events.length; i < len; i++){
 				var e = $scope.events[i];
 				
 				if (!$scope.eventBean.districtsSelected && e.type == 5 ) $scope.out++;
 				
 				/* GC 05/11/2015*/
 			// se l'evento non rientra in nessuno dei check selezionati non lo aggiungo
 				if(!(($scope.showEventsTypes1 && e.type ==1) || ($scope.showEventsTypes2 && e.type ==2) 
 						|| ($scope.showEventsTypes3 && e.type ==3) || ($scope.showEventsTypes4 && e.type ==4) 
 						|| ($scope.showEventsTypes5 && e.type ==5)))
 					{
 					continue;
 					}
 				
 					
 				
 				var feature = $scope.getFeatureByAttributeId($scope.districtSource, e.districts_id_districts);
 				if (feature){
 					var coor = ol.extent.getCenter(feature.getGeometry().getExtent());
	 				var imgsrc = '';
	 				var eventColor = '#000000';
	 				if (e.type == 1) {
	 					imgsrc = '../../images/anomal_increase_found.png';
	 					eventColor = '#FF9900';
	 				} else if (e.type == 2) {
	 					imgsrc = '../../images/possible_water_loss.png';
	 					eventColor = '#FF0000';
	 				} else if (e.type == 3) {
	 					imgsrc = '../../images/anomal_decrease_found.png';
	 					eventColor = '#99CC33';
	 				} else if (e.type == 4) {
	 					imgsrc = '../../images/possible_water_gain.png';
	 					eventColor = '#3399FF';
	 				} else if (e.type == 5) {
	 					imgsrc = '../../images/out_of_control.png';
	 					eventColor = '#000000';
	 				}
	 				
	 				//var rPerCent = e.ranking + '%';
	 				
	 				
	 				/*GC 05/11/2015*/
	 				/*
	 				 * disegno label per gli evento a seconda dei check selezionati
	 				 */
	 				var rPerCent = '';
	 				if($scope.showEventsMarkersRanking)
	 					{
	 					rPerCent = e.ranking + '% ';
	 					}
	 				if($scope.showEventsMarkersValue)
	 					{
	 					rPerCent = rPerCent + e.value + '[l/s] ';
	 					}
	 				if($scope.showEventsMarkersDuration)
 						{
	 					rPerCent = rPerCent + e.duration + '[gg] ';
 						}
	 				if($scope.showEventsMarkersDelta)
	 					{
	 					rPerCent = rPerCent + e.delta_value + '[l/s] ';
	 					}
	 				
 					var iconFeature = new ol.Feature({ //crea punto evento e associa properties
						 				  geometry: new ol.geom.Point(coor),
						 				  type:'event',
						 				  description: e.description,
						 				  district: e.district_name,
						 				  ranking: rPerCent,
						 				  deltavalue: e.delta_value
					 					});

	 				var iconStyle = new ol.style.Style({ //associa icona evento e ranking
					 					  	image: new ol.style.Icon(({
									 					    anchor: [0.5, 0.5],
									 					    anchorXUnits: 'fraction',
									 					    anchorYUnits: 'fraction',
									 					    scale: 0.4,
									 					    src: imgsrc
					 					  				})),
		 					  				text: new ol.style.Text({
					 										font : '14px Calibri,sans-serif',
					 										text : rPerCent,
					 										textAlign: 'center',
					 										textBaseline: 'top',
					 										offsetX: 16,
					 										offsetY: 11,
					 										fill : new ol.style.Fill({
					 											color : eventColor
					 										}),
					 										stroke : new ol.style.Stroke({
					 											color : eventColor,
					 											width : 1
					 										})
					 									})
					 								});
	 				
	 				iconFeature.setStyle(iconStyle);
	
	 				vectorSource.addFeature(iconFeature);
 				}
 			}
 			
 			$scope.map.removeLayer($scope.eventLayer);
 			
 			$scope.eventLayer = new ol.layer.Vector({
									  source: vectorSource
									});
 			
 			$scope.map.addLayer($scope.eventLayer);
 			
 			$scope.loadChartData($scope.districts.length, $scope.out);
 		}
 	};
 	
 	$scope.getFeatureByAttributeId = function(source, id){
 		var features = source.getFeatures();
 		for (var i=0, len=features.length; i<len; i++){
 			if (id === features[i].get('id')){
 				return features[i];
 			}
 		}
 	};
 	
	//rimuove il distretto selezionato
	$scope.removeDistrict = function() {
		$scope.eventBean.districtsSelected = null;
		$scope.loadEvents();
		$scope.hideMeasuresInDistricts(); // RF
	};
	
	//genera grafico a torta
	$scope.loadChartData = function(ok, out) {
		var rows = [["OK (" + ok + ")", ok],["OUT (" + out + ")", out]];
		var chart = c3.generate({
			bindto : '#pie-chart',
			data : {
				columns : rows,
				type : 'pie'
			},
			legend : {
				position : 'right'
			},
		    size: { 
		    	height: 240
	    	},
			padding: {
				left: 5,
				right: 5,
				top: 40,
				bottom: 5
			},
			color: {
		        pattern: ['#33CC33', '#330000']
		    }
		});
  	};
	
	//ordina la lista degli eventi al click
	$scope.sortEventsList = function(fieldToSortBy){
		var order = ($scope.orderByField.charAt(0) == '+') ? '-' : '+';
		$scope.orderByField = order + fieldToSortBy;
	};
	
 	$scope.openEndDate = function($event) {
		$event.preventDefault();
		$event.stopPropagation();
		$scope.openedEndDate = true;
	};
	
	
	

	
		$scope.updateSettingsCheck = function(){
			
			DashboardSettings.save($scope.settingsCheck, function (data){
				if(data.status == 'success'){
					if(data.data.dashboard_settings!=null)
					{
					}
					
				}
				else{
					
				}
			});
			
		};

		
		
	
		
		
		
		
		/*25072017!!!!!*/
		$scope.showFilterView = false;
		$scope.numFilters = 0;
		
		$scope.showFiltriMethod = function()
		{
			if(!$scope.showFilterView) $scope.showFilterView = true;
			else $scope.showFilterView = false;
		};
		
		$scope.valueInserted = '';
		$scope.columnSelected = '';
		$scope.columnsFilter = [];
		$scope.columnsFilter[0] = 'duration';
		$scope.columnsFilter[1] = 'value';
		$scope.columnsFilter[2] = 'ranking';
		$scope.columnsFilter[3] = 'district_name';
		$scope.columnsFilter[4] = 'district_ev_variable_type';
		$scope.columnsFilter[5] = 'delta_value';
		$scope.columnsFilter[6] = 'type';
		
		$scope.operatorsSelected = '';
		$scope.operators = [];
		
		$scope.operatorsMath = [];
		$scope.operatorsMath[0] = '>';
		$scope.operatorsMath[1] = '<';
		$scope.operatorsMath[2] = '=';
		$scope.filtersInserted =new Array();
		$scope.filterIsNumber = false;
		$scope.showVarType=false;
		$scope.showType=false;
		
		
		
		$scope.changeColumns = function(val)
		{
			$scope.showVarType=false;
			$scope.showType=false;
			
			$scope.operators = [];
			
			if(val === 'duration' || val === 'value' || val === 'ranking' || val === 'delta_value')
				{
				$scope.operators = $scope.operatorsMath;
				$scope.operatorsSelected = $scope.operators[0];
				$scope.filterIsNumber = true;
				}
			else {
				
				if(val === 'district_name')
					{
					$scope.operators[0] = 'contiene';
					$scope.operators[1] = 'uguale';
					}
				else
				{
					$scope.operators[0] = 'uguale';
					
					if(val==='type'){
						$scope.showType = true;
						$scope.showVarType = false;
					}
					else 
						{
						$scope.showType = false;
						$scope.showVarType = true;
						}
				}
				
				
				
				
				$scope.operatorsSelected = $scope.operators[0];
				$scope.filterIsNumber = false;
			}
			
			$scope.valueInserted = '';
		};
		
		
		$scope.addFiltro = function()
		{
			var f = {column:$scope.columnSelected, operator:$scope.operatorsSelected, val:$scope.valueInserted };		
			$scope.filtersInserted.push(f);
			
			$scope.numFilters = $scope.numFilters + 1;
			
			$scope.valueInserted = '';
			$scope.columnSelected = '';
			$scope.operatorsSelected = '';
			
		};
		
		
		$scope.removeFiltro = function(index)
		{
			$scope.numFilters = $scope.numFilters - 1;
			$scope.filtersInserted.splice(index, 1);
		};


		// RF - update map size in seguito al redimensionamento da parte dell'utente
		var mapIsDragged;
		angular.element('#map').on('mousedown', function() {
			mapIsDragged = true;
	    });
	    angular.element(document).on('mouseup', function() {
			if (mapIsDragged)
				$scope.map.updateSize();
	    });

}]);