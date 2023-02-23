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

var carMarkerArr = [];
function map_init() {
            // 좌표계 설정
            initProj();
            var center = [202965.38111507287, 442945.04133676185];
            var interactions = ol.interaction.defaults().extend([]);
            
            var view = new ol.View({
				center: center,
		        projection: 'EPSG:5181',
		        resolutions	: resolutions,
		        zoom: 12,
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
            
            map.getView().on('change:resolution', function(event) {
            	zoomControl();
            	if(MapLayer_Traffic_Level_1 != null || MapLayer_Traffic_Level_2 != null || MapLayer_Traffic_Level_3 != null || MapLayer_Traffic_Level_4 != null || MapLayer_Traffic_Level_5 != null){
            		
            	
            	}
            });
 
        }
 
        function initProj() {

			// *WGS84 경위도: GPS가 사용하는 좌표계
			// 	EPSG:4326, EPSG:4166 (Korean 1995)
			// 	+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs
			// proj4.defs('EPSG:4326', '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs');

			// google 좌표계
            //proj4.defs('EPSG:3857', '+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs');
 
            // UTM-K 좌표계
            //proj4.defs('EPSG:5179', '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs');
 
            // 중부원점(GRS80) [200,000 500,000]
            //proj4.defs('EPSG:5181', '+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs');
            proj4.defs("EPSG:5181","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
			proj4.defs("EPSG:2097","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs");
			proj4.defs('EPSG:4326', '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs');
 
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
            var daumSatelliteLayer = new ol.layer.Tile({
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
            var daumHybridLayer = new ol.layer.Tile({
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

