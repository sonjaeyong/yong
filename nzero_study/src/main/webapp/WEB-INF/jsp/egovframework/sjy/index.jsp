<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/jquery-1.12.3.min.js"></script>
<link rel="stylesheet" href="../css/sjy_footer.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=427a060c69c17c68946877ce82dd8d2e"></script>
<title>메인</title>
<style>
#wholeWrap{
	min-height:100%;
	padding-bottom: 64px;
}
.footer{
	position: relative;
	background:rgba(37,74,115,.9);
	width: 100%;
	height: 64px;
	transform:translateY(200%);
}
 #crossVal td{cursor : pointer; border-bottom:1px solid black;
 border-right: none; border-top:none; border-left: none;}
 #crossTitle th{
 	border:none;
 	border-radius:7px;
 	color: white;
 	background-color: #FF7F50;
 	box-shadow: inset 0 0 12px 12px #FFAD7E;
 }
 #listWrap{
 	float: left;
 	padding: 0 0 0 10px;
 	margin-right: 50px;
 }
 #listWrap #listForm{
 	width:370px;
 	height:420px;
 }
 #listTable {
 	width:100%;
 	height:100%;
 	border-left:none;
 	border-right:none;
 	border-top:none;
 	border-width:3px;
 	text-align: center;
 }
 #listTable, th, td {
 	border-collapse:collapse;
 }
 #crossVal{
 	font-size: 17px;
 	text-align: center;
 }
 #resultWrap{
 	width:1020px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align: center;
 	margin-bottom: 7px;
 }
 #resTable{
 	width: 100%;
 	text-align:center;
 	border-collapse:collapse;
 	border-left:none;
 	border-right:none;
 	border-width:2px;
 }
 #resTitle th{border-left:none; border-right:none; border-top:none;
 border-width:2px; background-color: #E2E2E2;}
 #resTable caption{
 	font-size:18px;
 	font-weight:bold;
 	padding:0 0 10px 0;
 }
 #cookiePos {
 	float: right;
 	margin-right: 10px;
 }
 #buttonPos{
 	float:right;
 	margin-bottom:10px;
 }
 #buttonPos > button {
 	font-size: 17px;
 	font-weight: bold;
 	font-family: Impact, Charcoal, sans-serif;
 	cursor : pointer;
 	padding: 5px 10px 5px 10px;
 	border: none;
 	border-radius: 8px;
 	background-color: #1E90FF;
 	color: white;
 }
 #showId {
 	font-weight: bold;
 	color: #1478FF;
 }
 #linkPos {
 	margin-top: 5px;
 	margin-bottom: 5px;
 }
 #linkPos a {
 	text-decoration: none;
 	font-size: 18px;
 	font-weight: bold;
 	color: white;
 	background-color: #FF8C0A;
 	padding: 6px 12px 6px 12px;
 	margin-right: 5px;
 	display: inline-block;
 	border-radius: 8px;
 	font-family: Impact, Charcoal, sans-serif;
 }
 .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
 .wrap * {padding: 0;margin: 0;}
 .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
 .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
 .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
 .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
 .info .close:hover {cursor: pointer;}
 .info .body {position: relative;overflow: hidden;}
 .info .desc {position: relative;margin: 13px 0 0 85px;height: 75px;}
 .desc .ellipsis {font-size: 17px; text-overflow: ellipsis;white-space: nowrap;}
 .desc .jibun {font-size: 15px;color: #888;margin-top: -2px;}
 .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}

</style>
</head>

<script type="text/javascript">
$(document).ready(function(){
	var loginId = getCookie("loginId");
	console.log(loginId);
	$("#showId").append(loginId);
});
var click;
var resX;
var resY;
$(document).ready(function(){
	$("#crossVal td").click(function(){
		click = $(this).children("input[type='hidden']:eq()").val();
		console.log(click);
		var data = {
				click : click
		}
		$.ajax({
			url : "/sjy/clickList.do",
			dataType : "json",
			type : "POST",
			data : JSON.stringify(data),
			contentType : "application/json",
			success : function(result){
				var str = "";
				var crossNm;
				var crossId;
				var useYn;
				$("#resultList").empty();
				$.each(result, function(i){
					resX = result[0].gisPosy;
					resY = result[0].gisPosx;
					crossNm = result[0].crossNm;
					crossId = result[0].crossId;
					useYn = result[0].useYn;
					str += "<tr>";
					str += "<td>" + result[i].crossId + "</td>";
					str += "<td>" + result[i].crossNm + "</td>";
					str += "<td>" + result[i].crossNo + "</td>";
					str += "<td>" + result[i].gisPosx + "</td>";
					str += "<td>" + result[i].gisPosy + "</td>";
					str += "<td>" + result[i].useYn + "</td>";
					str += "</tr>"
				});
				console.log(resX,resY);
				$("#resultList").append(str);
				//지도, 마커
				var mapContainer = document.getElementById('map'),
				mapOption = {
						center : new kakao.maps.LatLng(resX, resY),
						level : 5
				};
				var map = new kakao.maps.Map(mapContainer, mapOption);
				var markerPos = new kakao.maps.LatLng(resX, resY);
				var marker = new kakao.maps.Marker({
					map : map,
					position : markerPos
				});
				//마커 오버레이
				var content = "<div class='wrap'>" +
								"<div class='info'>" +
									"<div class='title'>" + crossNm +
										"<div class='close' onclick='closeOverlay()' title='닫기'></div>" +
									"</div>" +
									"<div class='body'>" +
										"<div class='desc'>" +
											"<div class='ellipsis'>ID: " + crossId + "</div>" +
											"<div class='jibun ellipsis'>사용여부: " + useYn + "</div>" +
										"</div>" +
									"</div>" +
								"</div>" +
							  "</div>";
				var overlay = new kakao.maps.CustomOverlay({
					content: content,
					map: map,
					position: marker.getPosition()       
				});
				kakao.maps.event.addListener(marker, 'click', function() {
				    overlay.setMap(map);
				});
				closeOverlay = function() {
				    overlay.setMap(null);     
				}
			}
		})
	});
});
//쿠키 가져오기
var getCookie = function(name){
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
};
//쿠키 삭제
var deleteCookie = function(name){
	document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
};
var basic = 0;
function clickTr(trColor){
	if(basic){
		basic.style.color = "#000000";
		basic.style.fontWeight = "normal";
	}
	trColor.style.color = "#FF8200";
	trColor.style.fontWeight = "bold";
	basic = trColor;
}
//페이징
function paging(num, tab){
	if(num){
		$("#pageNo").val(num);
	}
	$("input[name='hiddenNm']").val("");
	$("#listForm").attr("action", "/sjy/index.do").submit();
}
//로그아웃
function logout(){
	if(!confirm("로그아웃 하시겠습니까?")){
		return false;
	}
	deleteCookie("loginId");
	location.replace("/sjy/login.do");
}
//정보수정
function updateInfo(){
	if(!confirm("정보수정창으로 이동합니다!")){
		return false;
	}
	location.href = "/sjy/updateInfo.do";
}
//회원탈퇴
function deleteInfo(){
	if(!confirm("회원탈퇴창으로 이동합니다!")){
		return false;
	}
	location.href = "/sjy/deleteInfo.do";
}
</script>
<body>
<div id="wholeWrap">
 <div id="listWrap">
 <form id="listForm" name="listForm" method="post">
 <input type="hidden" name="hiddenNm" />
  <table id="listTable" border=1>
   <thead id="crossTitle">
    <tr>
     <th colspan="3"><h2>교차로목록</h2></th>
    </tr>
   </thead>
   <tbody id="crossVal">
    <c:forEach items="${result }" var="rs" varStatus="status">
     <tr onclick="clickTr(this);">
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckId"
       value="<c:out value='${rs.crossId }'/>" />
       <c:out value="${rs.crossId }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckName"
       value="<c:out value='${rs.crossId }'/>" />
       <c:out value="${rs.crossNm }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckNum"
       value="<c:out value='${rs.crossId }'/>" />
       <c:out value="${rs.crossNo }" />
      </td>
     </tr>
    </c:forEach>
   </tbody>
  </table>
   <c:if test="${ paginationInfo.totalRecordCount > 0}">
	<div style="margin-left:120px;">
	 <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="paging" />
	 <input type="hidden" id="pageNo" name="pageNo" value="<c:out value='${params.pageNo }' />" />
	</div>
   </c:if>
   <div id="linkPos">
   <a href="/sjy/crossRegist.do">교차로등록</a>
   <a href="/sjy/crossUpdate.do">교차로수정</a>
   <a href="/sjy/crossDelete.do">교차로삭제</a>
 </div>
  </form>
 </div>
 
 <div id="cookiePos">
  <p><span id="showId"></span>님 환영합니다!</p>
  <div id="buttonPos">
   <button type="button" onclick="logout(); return false;">로그아웃</button>
   <button type="button" onclick="updateInfo(); return false;">정보수정</button>
   <button type="button" onclick="deleteInfo(); return false;">회원탈퇴</button>
  </div>
 </div>
 
 <div id="resultWrap">
  <table border=1 id="resTable">
  <caption>상세정보</caption>
  <colgroup>
  <col>
  <col>
  <col width="100">
  <col>
  <col>
  <col width="100">
  </colgroup>
   <thead id="resTitle">
   <tr>
    <th>ID</th>
    <th>NAME</th>
    <th>NUMBER</th>
    <th>GIS_X</th>
    <th>GIS_Y</th>
    <th>USE</th>
   </tr>
   </thead>
   <tbody id="resultList">
    <tr>
     <td colspan="6">교차로를 클릭해주세요!</td>
    </tr>
   </tbody>
  </table>
 </div>
 
 <div id="map" style="width:75%; height:380px;"></div>
 </div>
 <jsp:include page="../main/sub_footer.jsp" />
</body>
</html>