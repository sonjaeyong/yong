var map;

// var wmsUrl = "http://3.35.14.119:8080/geoserver/gangneung/wms"; 운영
var wmsUrl = "http://nzero.kr:18088/geoserver/GNITSDEV/wms";

var TRAFFIC_LAYERS1 = 'gangneung:V_MAP_TRAFFIC1';			//zoom level 10이상
var TRAFFIC_LAYERS2 = 'gangneung:V_MAP_TRAFFIC2';
var TRAFFIC_LAYERS3 = 'gangneung:V_MAP_TRAFFIC3';
var TRAFFIC_LAYERS4 = 'gangneung:V_MAP_TRAFFIC4';
var TRAFFIC_LAYERS5 = 'gangneung:V_MAP_TRAFFIC5';
var resolutions = [2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25];

var projection = new ol.proj.Projection({
    code: 'EPSG:5181',
    extent: [-30000,-60000, 1018576, 988576],
    units: 'm'
});

var projectionExtent = projection.getExtent();
var MapLayer_Traffic_Level_1 = null; // >= 10
var MapLayer_Traffic_Level_2 = null; // 9
var MapLayer_Traffic_Level_3 = null; // 8
var MapLayer_Traffic_Level_4 = null; // 7
var MapLayer_Traffic_Level_5 = null; //  < 7
var daumBaseLayer;
var daumSatelliteLayer;
var daumHybridLayer;
var prevZoomLv;
var carMarkerArr = [];

var routeVectorLayer;
var resultMap = new Map();
var locResultList, locResultListLength;
var geoMarker;
var geoMarkerInterval;
var geoMarkerIntervalIndex = 0;

//projection
var p;

var styles = {
	'route': new ol.style.Style({
		stroke: new ol.style.Stroke({
			width: 6, color: [255, 0, 0, 0.8]
		})
	}),
	'geoMarker': new ol.style.Style({
		image: new ol.style.Icon({
			anchor: [0.5, 0.5],
			src: '../img/vehicle_green_n.svg',
			scale: 0.8,
		})
	})/*,
	'geoMarker': new ol.style.Style({
		image: new ol.style.Circle({
			radius: 7,
			snapToPixel: false,
			fill: new ol.style.Fill({color: 'black'}),
			stroke: new ol.style.Stroke({
				color: 'white', width: 2
			})
		})
	})*/
};


function map_init() {
            // 좌표계 설정
            initProj();
            var center = [202965.38111507287, 442945.04133676185];
            var interactions = ol.interaction.defaults().extend([]);
            prevZoomLv = 4;

            var view = new ol.View({
				center: center,
		        projection: 'EPSG:5181',
		        resolutions	: resolutions,
		        zoom: prevZoomLv,
		        minZoom: 1
			});
			
			map = new ol.Map({
				interactions: interactions,
				target: 'map',
				layers : [],
			    controls: ol.control.defaults({ attribution: false }).extend(
			        [ new ol.control.ZoomSlider(),
			          new ol.control.ScaleLine(),
			          new ol.control.MousePosition({
			              coordinateFormat: ol.coordinate.createStringXY(4),
			              undefinedHTML: '&nbsp;'
			          })
			        ]),
			    view: view
			});
        
            // 배경지도 레이어 추가
            addBaseLayer(map);
            
 
            daumBaseLayer.setVisible(true);
            
            //소통이미지 1 layer
			MapLayer_Traffic_Level_1 = new ol.layer.Tile({
			    extent: projectionExtent,
			    projection: projection,
			    id: 'MapLayer_Traffic_Level_1',
				source: new ol.source.TileWMS(({
					url: wmsUrl,
			        serverType: 'geoserver',
			        format: 'image/png',
			        projection: projection,
			        extent: projectionExtent,
			        style: 'default',
			        crossOrigin : null,
			        
			        preload: 0,
			        params: { VERSION: '1.1.1',
			                  LAYERS: TRAFFIC_LAYERS1,
			                  TILED: true,
			                  TRANSPARENT : 'true'
			        },
			        tileGrid: new ol.tilegrid.TileGrid({
			            origin: ol.extent.getTopLeft(projectionExtent),
			            resolutions: resolutions
			        })
				}))
			});
			MapLayer_Traffic_Level_1.setVisible(false);
			map.addLayer(MapLayer_Traffic_Level_1);
			
			//소통이미지 2 layer
			MapLayer_Traffic_Level_2 = new ol.layer.Tile({
			    extent: projectionExtent,
			    projection: projection,
			    id: 'MapLayer_Traffic_Level_2',
				source: new ol.source.TileWMS(({
					url: wmsUrl,
			        serverType: 'geoserver',
			        format: 'image/png',
			        projection: projection,
			        extent: projectionExtent,
			        style: 'default',
			        crossOrigin : null,
			        
			        preload: 0,
			        params: { VERSION: '1.1.1',
			                  LAYERS: TRAFFIC_LAYERS2,
			                  TILED: true,
			                  TRANSPARENT : 'true'
			        },
			        tileGrid: new ol.tilegrid.TileGrid({
			            origin: ol.extent.getTopLeft(projectionExtent),
			            resolutions: resolutions
			        })
				}))
			});
			MapLayer_Traffic_Level_2.setVisible(false);
			map.addLayer(MapLayer_Traffic_Level_2);
			
			//소통이미지 3 layer
			MapLayer_Traffic_Level_3 = new ol.layer.Tile({
			    extent: projectionExtent,
			    projection: projection,
			    id: 'MapLayer_Traffic_Level_3',
				source: new ol.source.TileWMS(({
					url: wmsUrl,
			        serverType: 'geoserver',
			        format: 'image/png',
			        projection: projection,
			        extent: projectionExtent,
			        style: 'default',
			        crossOrigin : null,
			        
			        preload: 0,
			        params: { VERSION: '1.1.1',
			                  LAYERS: TRAFFIC_LAYERS3,
			                  TILED: true,
			                  TRANSPARENT : 'true'
			        },
			        tileGrid: new ol.tilegrid.TileGrid({
			            origin: ol.extent.getTopLeft(projectionExtent),
			            resolutions: resolutions
			        })
				}))
			});
			MapLayer_Traffic_Level_3.setVisible(false);
			map.addLayer(MapLayer_Traffic_Level_3);
			
			//소통이미지 4 layer
			MapLayer_Traffic_Level_4 = new ol.layer.Tile({
			    extent: projectionExtent,
			    projection: projection,
			    id: 'MapLayer_Traffic_Level_4',
				source: new ol.source.TileWMS(({
					url: wmsUrl,
			        serverType: 'geoserver',
			        format: 'image/png',
			        projection: projection,
			        extent: projectionExtent,
			        style: 'default',
			        crossOrigin : null,
			        
			        preload: 0,
			        params: { VERSION: '1.1.1',
			                  LAYERS: TRAFFIC_LAYERS4,
			                  TILED: true,
			                  TRANSPARENT : 'true'
			        },
			        tileGrid: new ol.tilegrid.TileGrid({
			            origin: ol.extent.getTopLeft(projectionExtent),
			            resolutions: resolutions
			        })
				}))
			});
			MapLayer_Traffic_Level_4.setVisible(false);
			map.addLayer(MapLayer_Traffic_Level_4);
			
			//소통이미지 5 layer
			MapLayer_Traffic_Level_5 = new ol.layer.Tile({
			    extent: projectionExtent,
			    projection: projection,
			    id: 'MapLayer_Traffic_Level_5',
				source: new ol.source.TileWMS(({
					url: wmsUrl,
			        serverType: 'geoserver',
			        format: 'image/png',
			        projection: projection,
			        extent: projectionExtent,
			        style: 'default',
			        crossOrigin : null,
			        
			        preload: 0,
			        params: { VERSION: '1.1.1',
			                  LAYERS: TRAFFIC_LAYERS5,
			                  TILED: true,
			                  TRANSPARENT : 'true'
			        },
			        tileGrid: new ol.tilegrid.TileGrid({
			            origin: ol.extent.getTopLeft(projectionExtent),
			            resolutions: resolutions
			        })
				}))
			});
			MapLayer_Traffic_Level_5.setVisible(false);
			map.addLayer(MapLayer_Traffic_Level_5);
            
            /*map.getView().on('change:resolution', function(event) {
				if(map.getView().getZoom() % 1 == 0)
            		if(MapLayer_Traffic_Level_1 != null || MapLayer_Traffic_Level_2 != null || MapLayer_Traffic_Level_3 != null || MapLayer_Traffic_Level_4 != null || MapLayer_Traffic_Level_5 != null){
            			zoomControl();
            		}
            });*/
 
        }

        function zoomControl(){
			var currentZoomLv = map.getView().getZoom();
			//
			for(var i=1; i<6; i++){
				eval( 'MapLayer_Traffic_Level_' + i + '.setVisible(false);' );
			}
			if(currentZoomLv > 9){
				prevZoomLv > 9? null : MapLayer_Traffic_Level_1.setVisible(true);
			}else if(currentZoomLv < 7){
				prevZoomLv < 7? null : MapLayer_Traffic_Level_5.setVisible(true);
			}else{
				switch (currentZoomLv) {
					case 9:
						MapLayer_Traffic_Level_2.setVisible(true);
						break;
					case 8:
						MapLayer_Traffic_Level_3.setVisible(true);
						break;
					case 7:
						MapLayer_Traffic_Level_4.setVisible(true);
				}
			}
			prevZoomLv = currentZoomLv;
		}
 
        function initProj() {
 
            // google 좌표계
            //proj4.defs('EPSG:3857', '+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs');
 
            // UTM-K 좌표계
            //proj4.defs('EPSG:5179', '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs');
 
            // 중부원점(GRS80) [200,000 500,000]
            //proj4.defs('EPSG:5181', '+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs');
            proj4.defs("EPSG:5181","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
			proj4.defs("EPSG:2097","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs");
			p = proj4('EPSG:4326','EPSG:5181');

        }
 
        function addBaseLayer(map) {
 
            // ------------------------------
            // daum(kakao) layers
            // ------------------------------
            var daumTileGrid = new ol.tilegrid.TileGrid({
                extent : [(-30000-524288), (-60000-524288), (494288+524288), (988576+524288)],
                tileSize : 256,
                resolutions : [4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25], 
                minZoom : 1
            });
 
            function getDaumTileUrlFunction(type) {
 
                var tileUrlFunction = function(tileCoord, pixelRatio, projection) {
 
                    var res = this.getTileGrid().getResolutions();
                    var sVal = res[tileCoord[0]];
                    
                    var yLength = 988576 - (-60000) + 524288 + 524288;
                    var yTile = yLength / (sVal * this.getTileGrid().getTileSize());
 
                    var tileGap = Math.pow(2, (tileCoord[0] -1));
                    yTile = yTile - tileGap;
                    
                    var xTile = tileCoord[1] - tileGap;
            
                    if (type == 'base') {
                        return 'http://map' + Math.floor( (Math.random() * (4 - 1 + 1)) + 1 ) + '.daumcdn.net/map_office/2d/L' + (15 - tileCoord[0]) + '/' + (yTile + tileCoord[2]) + '/' + xTile + '.png';
                    } else if (type == 'satellite') {
                        return 'https://map' + Math.floor( (Math.random() * (4 - 1 + 1)) + 1 ) + '.daumcdn.net/map_skyview_hd/L' + (15 - tileCoord[0]) + '/' + (yTile + tileCoord[2]) + '/' + xTile + '.jpg';
                    } else if (type == 'hybrid') {
                        return 'http://map' + Math.floor( (Math.random() * (4 - 1 + 1)) + 1 ) + '.daumcdn.net/map_hybrid_hd/2111ydg/L' + (15 - tileCoord[0]) + '/' + (yTile + tileCoord[2]) + '/' + xTile + '.png';
                    }
 
                };
 
                return tileUrlFunction;
 
            }
 
            // daum base
            daumBaseLayer = new ol.layer.Tile({
                source: new ol.source.XYZ({
                    projection : 'EPSG:5181',
                    tileGrid: daumTileGrid,
                    tileUrlFunction: getDaumTileUrlFunction('base'),
                    tilePixelRatio: 2,              // 타일사이즈 512일때 해상도 비율
                }),
                id: 'daum_base',
                visible: false
            });
            map.addLayer(daumBaseLayer);
 
            // daum satellite
            daumSatelliteLayer = new ol.layer.Tile({
                source: new ol.source.XYZ({
                    projection : 'EPSG:5181',
                    tileGrid: daumTileGrid,
                    tileUrlFunction: getDaumTileUrlFunction('satellite'),
                    tilePixelRatio: 2,              // 타일사이즈 512일때 해상도 비율
                }),
                id: 'daum_satellite',
                visible: false
            });
            map.addLayer(daumSatelliteLayer);
 
            // daum hybrid
            daumHybridLayer = new ol.layer.Tile({
                source: new ol.source.XYZ({
                    projection : 'EPSG:5181',
                    tileGrid: daumTileGrid,
                    tileUrlFunction: getDaumTileUrlFunction('hybrid'),
                    tilePixelRatio: 2,              // 타일사이즈 512일때 해상도 비율
                }),
                id: 'daum_hybrid',
                visible: false
            });
            map.addLayer(daumHybridLayer);
 
}


function getLocAndRouteAjax(id){
	var paramObj = {
		serviceId : id,
	};
	var locAjax = commonAjax('/gnpsj/selectEmergencyLocAjax.do', 'emergencyLocList', paramObj);
	var routeAjax = commonAjax('/gnpsj/selectEmergencyRouteAjax.do', 'emergencyRouteList', paramObj);
	var innerHtml ='';

	$.when(locAjax, routeAjax).done(function(){
		var routeResultList = [];
		locResultList = [];
		resultMap.get('emergencyRouteList').forEach(function (item) {
			routeResultList.push(p.forward([item.lon, item.lat]));
		});
		resultMap.get('emergencyLocList').forEach(function (item) {
			locResultList.push(
				{
					lonLat : p.forward([item.lon, item.lat]),
					regTime : item.regTime,
					seq : item.seq,
				}
			);
		});

		//현재차량 아이콘
		geoMarker = new ol.Feature({
			type: 'geoMarker',
			geometry: new ol.geom.Point(locResultList[0].lonLat)
		});

		locResultListLength = locResultList.length;

		var routeLineString = new ol.geom.LineString(routeResultList);

		map.getView().fit(ol.extent.boundingExtent(routeResultList),
			map.getSize());

		//차량 예상경로
		var routeFeature = new ol.Feature({
			type: 'route',
			geometry: routeLineString
		});

		if(routeVectorLayer){
			routeVectorLayer.getSource().clear();
			routeVectorLayer.getSource().addFeatures([routeFeature, geoMarker]);
		}else{
			routeVectorLayer = new ol.layer.Vector({
				source: new ol.source.Vector({
					features: [routeFeature, geoMarker]
				}),
				style: function(feature) {
					return styles[feature.get('type')];
				}
			});
			map.addLayer(routeVectorLayer);
		}

		locResultList.forEach(function(item){
			innerHtml += locTrStart() + locTdStart('seqTd') + item.seq + locTdEnd();
			innerHtml += locTdStart() + item.regTime + locTdEnd() + locTrEnd();
		});

		$('#locTable').html(innerHtml);

		animationStart();

	});

}

function locTrStart(){
	return '<tr>';
}

function locTrEnd(){
	return '</tr>';
}

function locTdStart(className){
	return '<td class = "' + className + '">';
}

function locTdEnd(){
	return '</td>';
}

function animationStart(){
	if(geoMarkerIntervalIndex != 0) geoMarkerIntervalIndex = 0;
	if(geoMarkerInterval) clearInterval(geoMarkerInterval);

	geoMarkerInterval = setInterval(function (){
		if(locResultListLength > geoMarkerIntervalIndex ){
			//td 색상변경
			$(".seqTd").filter(function() {
				return $(this).text() == "" + (geoMarkerIntervalIndex+1) ;
			}).parent().css('text-decoration','line-through');

			//point 이동
			var source = routeVectorLayer.getSource();
			source.removeFeature(geoMarker);
			geoMarker = new ol.Feature({
				type: 'geoMarker',
				geometry: new ol.geom.Point(locResultList[geoMarkerIntervalIndex].lonLat)
			});
			source.addFeature(geoMarker);
			map.render();

			geoMarkerIntervalIndex ++;
		}else{
			clearInterval(geoMarkerInterval);
		}
	}, 500);
}


























