<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="../main/sub_header.jsp" />

<script type="text/javascript">
const VMS_SRC_ARRAY = ['../img/fac/map_icon_vms_g.png'
    , '../img/fac/map_icon_vms_r.png'
    , '../img/fac/map_icon_vms_s.png'];
const CCTV_SRC_ARRAY = ['../img/fac/map_icon_cctv_g.png'
    , '../img/fac/map_icon_cctv_r.png'
    , '../img/fac/map_icon_cctv_s.png'];
var vmsLayer;
var cctvLayer;

$(document).ready(function(){
    map_init();
    const TARGET_PROJECTION = ol.proj.get('EPSG:5181');
    map.getView().setCenter(ol.proj.transform([126.971453, 37.380367], 'EPSG:4326', TARGET_PROJECTION));

    $(".vcbx").change(function() {
        filterVMS();
    });
    $(".ccbx").change(function() {
        filterCCTV();
    });

    showVMS();
    showCCTV();
});

function zoomControl() {}
function getRandomNumber() {
    return Math.floor(Math.random() * 3);
}

function getCheckedBox() {

}

async function showVMS() {
    // vms 추가
    fetch("/bjw/vms.do")
        .then((response) => response.json())
        .then((vmsList) => {
            const iconArr = [];
            const TARGET_PROJECTION = ol.proj.get('EPSG:5181');

            for (const vms of vmsList) {
                if (vms.coordx !== undefined && vms.coordy !== undefined) {
                    const num = getRandomNumber();
                    var transformedCoord = ol.proj.transform([vms.coordx, vms.coordy], 'EPSG:4326', TARGET_PROJECTION);
                    var iconFeature = new ol.Feature({
                        geometry: new ol.geom.Point(transformedCoord)
                        , group: 'vmsGroup' + num
                    });
                    var iconStyle = new ol.style.Style({
                        image: new ol.style.Icon(({
                            src: VMS_SRC_ARRAY[num]
                        }))
                    });

                    iconFeature.setStyle(iconStyle);
                    iconArr.push(iconFeature);
                }
            }

            var vectorSource = new ol.source.Vector({
                features: iconArr
            });
            vmsLayer = new ol.layer.Vector({
                source: vectorSource
            });

            map.addLayer(vmsLayer);
        })
        .catch(error => console.error(error));
}

async function showCCTV() {
    fetch("/bjw/cctv.do")
        .then((response) => response.json())
        .then((cctvList) => {
            const iconArr = [];
            const TARGET_PROJECTION = ol.proj.get('EPSG:5181');

            for (const cctv of cctvList) {
                if (cctv.gisPosx !== undefined && cctv.gisPosy !== undefined) {
                    const num = getRandomNumber();
                    var transformedCoord = ol.proj.transform([cctv.gisPosx, cctv.gisPosy], 'EPSG:4326', TARGET_PROJECTION);
                    var iconFeature = new ol.Feature({
                        geometry: new ol.geom.Point(transformedCoord)
                        , group: 'cctvGroup' + num
                });
                    var iconStyle = new ol.style.Style({
                        image: new ol.style.Icon(({
                            src: CCTV_SRC_ARRAY[num]
                        }))
                    });

                    iconFeature.setStyle(iconStyle);
                    iconArr.push(iconFeature);
                }
            }

            cctvLayer = new ol.layer.Vector({
                source: new ol.source.Vector({
                    features: iconArr
                })
            });

            map.addLayer(cctvLayer);
        })
        .catch(error => console.error(error));
}

function filterVMS() {
    const features = vmsLayer.getSource().getFeatures();
    // const filteredFeatures = features.filter(function(feature) {
    //     return feature.get('group') === 'vmsGroup1';
    // });

    const arr = [];
    $('.vcbx:checked').each((key, val) => {
        arr.push(getGroupName(val.id));
    });

    for (const feature of features) {
        if (arr.includes(feature.get('group'))) {
            feature.setStyle(
                new ol.style.Style({
                    image: new ol.style.Icon(({
                        src: VMS_SRC_ARRAY[lastCharToNumber(feature.get('group'))]
                    }))
                }));
        } else {
            feature.setStyle(
                new ol.style.Style({
                    image: new ol.style.Circle({
                        radius: 0
                    })
            }));
        }
    }
}

function filterCCTV() {
    const features = cctvLayer.getSource().getFeatures();
    // const filteredFeatures = features.filter(function(feature) {
    //     return feature.get('group') === 'vmsGroup1';
    // });

    const arr = [];
    $('.ccbx:checked').each((key, val) => {
        arr.push(getGroupName(val.id));
    });

    for (const feature of features) {
        if (arr.includes(feature.get('group'))) {
            feature.setStyle(
                new ol.style.Style({
                    image: new ol.style.Icon(({
                        src: CCTV_SRC_ARRAY[lastCharToNumber(feature.get('group'))]
                    }))
                }));
        } else {
            feature.setStyle(
                new ol.style.Style({
                    image: new ol.style.Circle({
                        radius: 0
                    })
                }));
        }
    }
}

function lastCharToNumber(str) {
    return parseInt(str[str.length - 1]);
}
function getGroupName(checkBoxId) {
    switch (checkBoxId) {
        case 'vmsG':
            return 'vmsGroup0';
        case 'vmsR':
            return 'vmsGroup1';
        case 'vmsS':
            return 'vmsGroup2';
        case 'cctvG':
            return 'cctvGroup0';
        case 'cctvR':
            return 'cctvGroup1';
        case 'cctvS':
            return 'cctvGroup2';
    }
}
</script>
<div class="container">
    <div class="content_body">
        <div id="map" style="width: 100%; height: 85.1vh;"></div>
        <div id="controls" style="background-color: white; position: absolute; top: 105px; right: 20px;">
            <div>
                <label>VMS</label><br>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk vcbx" type="checkbox" id="vmsG" checked>
                    <label for="vmsG">정상</label><br>
                </span>
                </div>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk vcbx" type="checkbox" id="vmsR" checked>
                    <label for="vmsR">장애</label><br>
                </span>
                </div>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk vcbx" type="checkbox" id="vmsS" checked>
                    <label for="vmsS">알수없음</label><br>
                </span>
                </div>
            </div>
            <div>
                <label>CCTV</label><br>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk ccbx" type="checkbox" id="cctvG" checked>
                    <label for="cctvG">정상</label><br>
                </span>
                </div>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk ccbx" type="checkbox" id="cctvR" checked>
                    <label for="cctvR">장애</label><br>
                </span>
                </div>
                <div class="chk_wrap">
                <span class="inp_chk_wrap">
                    <input class="inp_chk ccbx" type="checkbox" id="cctvS" checked>
                    <label for="cctvS">알수없음</label><br>
                </span>
                </div>
            </div>
        </div>

    </div>
</div>


