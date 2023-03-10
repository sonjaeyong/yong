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
<script src="../js/jquery-1.12.3.min.js"></script>
<meta charset="UTF-8">
<title>교차로수정</title>
<style>
 #listForm{
 	width:1500px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align:center;
 	margin-bottom:10px;
 }
 #listTable, th, td{
 	border-collapse:collapse;
 }
 #listTable{
 	width:100%;
 	text-align:center;
 	border-left:none;
 	border-right:none;
 	border-width:2px;
 }
 #listTable caption{
 	font-size:20px;
 	font-weight:bold;
 	padding: 0 0 10px 0;
 }
 #listTable th{
 	border-left:none;
 	border-right:none;
 	border-top:none;
 	border-width:2px;
 	background-color: #E2E2E2;
 }
 #crossVal td{
 	border-left:0;
 }
 #updateForm{
 	width:400px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align:center;
 	background-color:#78E150;
 	padding:20px;
 }
 #updateForm input{
 	width:250px;
 	height:35px;
 	border:none;
 	border-radius:8px;
 	margin-bottom:10px;
 }
 #buttonPos{
 	width:300px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align:center;
 }
 button{
 	width:255px;
 	border:none;
 	height:30px;
 	background-color:#147814;
 	color:white;
 	font-size:15px;
 	border-radius:8px;
 	margin-bottom:10px;
 	font-weight:bold;
 	cursor:pointer;
 }
 #crossVal td{
 	cursor: pointer;
 }
 #upText{
 	font-weight: bold;
 	font-size: 20px;
 }
</style>
</head>
<script type="text/javascript">
var id;
 $(document).ready(function(){
	$("#crossVal tr").click(function(){
		var resArr = [];
		$(this).children("td").each(function(i){
			resArr.push($(this).children("input[type='hidden']:eq()").val());
		});
		console.log(resArr);
		id = resArr[0];
		$("#updateForm input[type='text']").each(function(i){
			$(this).val(resArr[i]);
		});
	});
 });
 var basic = 0;
 function clickTr(trColor){
 	if(basic){
 		basic.style.color = "#000000";
 		basic.style.fontWeight = "normal";
 	}
 	trColor.style.color = "#147814";
 	trColor.style.fontWeight = "bold";
 	basic = trColor;
 }
 //페이징
 function paging(num, tab){
 	if(num){
 		$("#pageNo").val(num);
 	}
 	$("#listForm").attr("action", "/sjy/crossUpdate.do").submit();
 }
 function updateBtn(){
	 var go = false;
	 console.log(id);
	 if(id == null){
		 alert("선택한 교차로가 없습니다. 클릭해주세요!");
		 go = false;
		 return false;
	 }
	 else{
		 $("#updateForm input[type='text']").each(function(i){
				if(!$(this).val()){
					alert("모든 칸을 입력해주세요!");
					go = false;
					return false;
				}
				else{go = true;}
		 }); 
	 }
	 if(!go){return;}
	 if(!confirm("수정하시겠습니까?")){
		 return false;
	 }
	 $("#updateForm").attr("action", "/sjy/crossFormUpdate.do").submit();
 }
</script>
<body>
 <div>
  <form id="listForm" name="listForm" method="post">
 <input type="hidden" name="hiddenNm" />
  <table border=1 id="listTable">
  <caption>교차로목록</caption>
   <thead>
    <tr>
     <th>ID</th>
     <th>NAME</th>
     <th>NUMBER</th>
     <th>POS_X</th>
     <th>POS_Y</th>
     <th>USE(Y/N)</th>
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
       <input type="hidden" id="<c:out value='${rs.crossNm }'/>" name="ckName"
       value="<c:out value='${rs.crossNm }'/>" />
       <c:out value="${rs.crossNm }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.crossNo }'/>" name="ckNum"
       value="<c:out value='${rs.crossNo }'/>" />
       <c:out value="${rs.crossNo }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.gisPosx }'/>" name="ckgisX"
       value="<c:out value='${rs.gisPosx }'/>" />
       <c:out value="${rs.gisPosx }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.gisPosy }'/>" name="ckgisY"
       value="<c:out value='${rs.gisPosy }'/>" />
       <c:out value="${rs.gisPosy }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.useYn }'/>" name="ckYn"
       value="<c:out value='${rs.useYn }'/>" />
       <c:out value="${rs.useYn }" />
      </td>
     </tr>
    </c:forEach>
   </tbody>
  </table>
   <c:if test="${ paginationInfo.totalRecordCount > 0}">
	<div>
	 <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="paging" />
	 <input type="hidden" id="pageNo" name="pageNo" value="<c:out value='${params.pageNo }' />" />
	</div>
   </c:if>
  </form>
 </div>
 
 <div id="upFormPos">
  <form id="updateForm">
   <p id="upText">목록에서 클릭 후 수정해주세요</p>
   <input type="text" name="id" placeholder="ID 변경불가" readonly>
   <input type="text" name="updateNm" id="교차로명" placeholder="교차로명">
   <input type="text" name="updateNo" id="번호" placeholder="번호">
   <input type="text" name="updateX" id="X좌표" placeholder="X좌표">
   <input type="text" name="updateY" id="Y좌표" placeholder="Y좌표">
   <input type="text" name="updateYn" id="사용여부" placeholder="사용여부">
   <div id="buttonPos">
    <button type="button" onclick="updateBtn(); return false;">수정</button>
    <button type="button" onclick="location.replace('/sjy/index.do');">닫기</button>
   </div>
  </form>
 </div>
</body>
</html>