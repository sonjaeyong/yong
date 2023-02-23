<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="../main/sub_header.jsp" />
<style>
    .car {
        background-image: url(../img/vehicle_yellow_n.svg);
        width: 37px;
        height: 100px;
    }
</style>
<script type="text/javascript">
	
</script>
<div id="container" class="container">
        <div class="content inner">

            <div class="content_header">
                <h2>실증 시나리오
                	<c:choose>
                		<c:when test="${csvType eq '1' }">[정상주행]</c:when>
                		<c:when test="${csvType eq '2' }">[차로이탈]</c:when>
                		<c:when test="${csvType eq '3' }">[차량충돌경고]</c:when>
                		<c:when test="${csvType eq '4' }">[장애물감지]</c:when>
                		<c:when test="${csvType eq '5' }">[차량이상상황발생]</c:when>
                	</c:choose>
                </h2>
                <ol class="breadcrumb">
                    <li class="home"><img src="../img/breadcrumb_home.png" alt="메인"></li>
                    <li>시나리오</li>
                    <li>시나리오 리스트</li>
                </ol>
            </div><!-- //content_header -->

            <div class="content_body">
<form id="frm" name="frm" method="post">
<input type="hidden" name="pageC" id="pageC">
                <div class="dtb mt15">
                    <div class="dtc vat" style="width: 55%;">
                        <div class="bdg" id="map" style="height: 685px;">

                        </div>
                    </div>
                    <div id="mapCon" class="dtc vat" style="width: 44%;padding-left: 2.5%;">
                        <p class="title2 mt15">목록</p>
                        <div class="list_table bdbn tac" style="overflow-y: scroll;height: 300px;" id="idList">
                            <table>
                                <colgroup>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>msgCount</th>
                                        <th>id</th>
                                        <th>secMark</th>
                                        <th>lat</th>
                                        <th>lng</th>
                                        <th>speed</th>
                                        <th>heading</th>
                                    </tr>
                                </thead>
                                <tbody class="listClear" id="listTbd">
                                </tbody>
                            </table>
                        </div><!-- //list_table -->

                        <p class="title2 mt30">상세정보</p>
                        <div class="list_table bdbn tac mt15 clearT">
                            <table>
                                <colgroup>
                                    <col width="210">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>adasEvent</th>
                                        <td><input type="text" class="w100 required" readonly="" name="adasEvent" id="adasEvent"></td>
                                    </tr>
                                    <tr>
                                        <th>laneId</th>
                                        <td><input type="text" class="w100 required" readonly="" name="laneId" id="laneId"></td>
                                    </tr>
                                    <tr>
                                        <th>dectLane</th>
                                        <td><input type="text" class="w100 required" readonly="" name="dectLane" id="dectLane"></td>
                                    </tr>
                                    <tr>
                                        <th>eventFlag</th>
                                        <td><input type="text" class="w100 required" readonly="" name="eventFlag" id="eventFlag"></td>
                                    </tr>
                                    <tr>
                                    	<th>로그내역</th>
                                    	<td><textarea rows="3" id="titleArea" style="width: 537px;height: 500px;background-color: #e9e9e9;" readonly></textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div><!-- //list_table -->
                    </div>

                </div>
</form>
            </div><!-- //content_body -->

        </div><!-- //content -->
    </div><!-- //container -->
<script type="text/javascript">
var adasEventArr = [
	'이벤트가 감지되지 않음'
	,'버스와의 추돌위험(FCWS)이 있음'
	,'승용차와의 추돌위험(FCWS)이 있음'
	,'트럭과의 추돌위험(FCWS)이 있음'
	,'오토바이와의 추돌위험(FCWS)이 있음'
	,'특수차량과의 추돌위험(FCWS)이 있음'
	,'자전거와의 추돌위험(FCWS)이 있음'
	,'보행자와의 추돌위함(PCWS)이 있음'
	,'포트홀이 감지됨'
	,'러버콘이 감지됨'
	,'왼쪽차선이탈(LDWS)이 감지됨'
	,'오른쪽차선이탈(LDWS)이 감지됨'
	,'차선이탈(LDWS)이 감지됨'
];
var eventFlagArr = [
	'에어백 전개'
	,'타이어 공기압 이상'
	,'배터리 방전'
	,'차량 고온(화재 등)'
	,'차량 외부 등 이상'
	,'기타 차량 이상 (차량 외부 등 이상 제외)'
	,'차량 와이퍼 작동'
	,'예약필드'
];
var dectLaneArr = [
	'차로 유형이 검지되지 못함'
	,'버스전용차로'
	,'중앙버스차로'
	,'노변버스차로'
	,''
	,''
	,''
	,''
	,''
	,'일반차로'
	,'일반1차로'
	,'일반2차로'
	,'일반3차로'
	,'일반3차로'
	,'일반4차로'
	,'일반5차로'
	,'일반6차로'
	,'일반7차로'
	,'일반8차로'
	,'일반9차로'
	,'일반10차로'
	,'일반11차로'
	,'일반12차로'
	,'일반13차로'
	,'일반14차로'
	,'일반15차로'
	,'일반16차로'
	,'일반17차로'
	,'일반18차로'
	,'일반19차로'
	,'일반20차로'
	,'기타 차로'
];
$(document).ready(function(){
	map_init();
	
	var dataArr = "${result}".replaceAll("[","").split("]");
	$(dataArr).each(function(i){
		if(i != 0 && dataArr[i]){
			var tagStr = "<tr data='"+dataArr[i]+"' class='listTr'>";
			var dataRowArr = dataArr[i].split(",");
			$(dataRowArr).each(function(j){
				if(j != 0 && j < 4){
					tagStr += "<td>"+ dataRowArr[j].replace(" ","") + "</td>";
				}else if(j == 4){
					var lat = dataRowArr[j].replace(" ","");
					lat = lat.substr(0,2)+"."+lat.substr(2,lat.length-2);
					
					tagStr += "<td>"+ lat + "</td>";
				}else if(j == 5){
					var lng = dataRowArr[j].replace(" ","");
					lng = lng.substr(0,3)+"."+lng.substr(3,lng.length-3);
					
					tagStr += "<td>"+ lng + "</td>";
				}else if(j == 7){
					var speed = dataRowArr[j].replace(" ","");
					speed = speed*50/1000;
					tagStr += "<td>"+ speed + "</td>";
				}else if(j == 8){
					var heading = dataRowArr[j].replace(" ","");
					heading = (heading*0.0125).toFixed(2);
					tagStr += "<td>"+ heading + "</td>";
				}
				//console.log(dataRowArr[j]);
			});
			tagStr += "</tr>";
			$("#listTbd").append(tagStr);
		}
	});
	var listIdx = 0;
	var autoItv = setInterval(function(){
		if(listIdx <= $(".listTr").length-1){
			$(".listTr").css("background", "");
			$(".listTr:eq("+listIdx+")").click();
			$(".listTr:eq("+listIdx+")").css("background", "rgba(239,212,197,.3)");
			listIdx++;
		}else{
			clearInterval(autoItv);
			alert("종료");
			return;
		}
	},100);
	
	$(".listTr").click(function(){
		var $this = $(this);
		$(".listTr").css("background", "");
		var dataList = $(this).attr("data").split(",");
		$this.css("background", "rgba(239,212,197,.3)");
		var lat = dataList[4].replace(" ","");
		lat = lat.substr(0,2)+"."+lat.substr(2,lat.length-2);
		
		var lng = dataList[5].replace(" ","");
		lng = lng.substr(0,3)+"."+lng.substr(3,lng.length-3);
		
		var speed = dataList[7]*50/1000;
		//speed = speed.substr(0,2)+"."+speed.substr(2,lng.length-2);
		
		var heading = (dataList[8]*0.0125).toFixed(2);
		var headingRadian = parseFloat(heading, 10).toFixed(2) * (Math.PI / 180);
		//heading = heading.substr(0,3)+"."+heading.substr(3,lng.length-3);
		//parseFloat(degrees, 10).toFixed(2) * (Math.PI / 180);
		
		if(carMarkerArr.length > 0){
			$(carMarkerArr).each(function(i){
				map.removeLayer(carMarkerArr[i]);
			});
		}
		var errorFlag = false;
			console.log(dataList[14]);
			console.log(adasEventArr[Number(dataList[14])]);
			$("#adasEvent").val(adasEventArr[Number(dataList[14])]);
		if(dataList[14] >= 0){
			errorFlag = true;
			$this.find("td:eq(0)").css("color", "red");
		}else{
			$("#adasEvent").val("null");
		}
		
			$("#laneId").val(Number(dataList[20]));
		if(dataList[20] >= 0){
			$this.find("td:eq(0)").css("color", "red");
			errorFlag = true;
		}else{
			$("#laneId").val("null");
		}
		
			$("#dectLane").val(dectLaneArr[Number(dataList[21])]);
		if(dataList[21] >= 0){
			$this.find("td:eq(0)").css("color", "red");
			errorFlag = true;
		}else{
			$("#dectLane").val("null");
		}
		
			var evtFlag = Number(dataList[23]);
			evtFlag = evtFlag.toString(2);
			console.log(evtFlag);
			console.log(evtFlag.length);
			var evtStr = "";
			for(var z=evtFlag.length; z>0; z--){
				console.log(evtFlag.substr(z-1,1));
				if(evtFlag.substr(z-1,1) == "1"){
					if(evtStr != ""){
						evtStr += ", " +eventFlagArr[evtFlag.length-z];
					}else{
						evtStr += eventFlagArr[evtFlag.length-z];
					}
				}
			}
			$("#eventFlag").val(evtStr);
		if(dataList[23] >= 0){
			$this.find("td:eq(0)").css("color", "red");
			errorFlag = true;
		}else{
			$("#eventFlag").val("null");
		}
		if(!errorFlag){
			addMarker(parseFloat(lng),parseFloat(lat), 'car', headingRadian);
		}else{
			addMarker(parseFloat(lng),parseFloat(lat), 'car', headingRadian,'red');
		}
		var titleArr = ["msgCount","id","secMark","lat","long","elev","speed","heading","width","length","eventType_Kor","role_Kor","vehicleClass_Kor","adas_event","adas_distance","adas_time","adas_long","adas_lat","adas_confidence","laneID","dectLane","brakePedalCmd","eventFlags_kor"];

		var titleTag = "";
		$(dataList).each(function(i,v){
			if(i != 0){
				titleTag += titleArr[i-1]+":"+dataList[i]+"\r\n";
			}
		});
		
		$("#titleArea").text(titleTag);
	});
});

</script>
<jsp:include page="../main/sub_footer.jsp" />
