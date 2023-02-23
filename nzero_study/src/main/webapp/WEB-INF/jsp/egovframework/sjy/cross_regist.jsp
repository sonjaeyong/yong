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
<title>교차로등록</title>
<style>
 #listForm{
 	width:1500px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align:center;
 	margin-bottom:10px;
 }
 #listForm > table{
 	width:100%;
 	text-align:center;
 }
 #insertForm{
 	width:400px;
 	margin-left:auto;
 	margin-right:auto;
 	text-align:center;
 	background-color:#7DA5E1;
 	padding:20px;
 }
 #insertForm input{
 	width:250px;
 	height:30px;
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
 	background-color:#1478CD;
 	color:white;
 	font-size:15px;
 	border-radius:8px;
 	margin-bottom:10px;
 	font-weight:bold;
 	cursor:pointer;
 }
</style>
</head>
<script type="text/javascript">
$(document).ready(function(){
	var flag = false;
	$("#insertBtn").click(function(){
		if(!$("input[type='text']").val()){
			alert("입력하지 않은 항목이 있습니다!");
			flag = false;
			return false;
		}
		if(!confirm("등록하시겠습니까?")){
			return false;
		}
		$("#insertForm").attr("action", "/sjy/crossInsert.do").submit();
	});
	$("#cancelBtn").click(function(){
		location.replace("/sjy/index.do");
	});
});
//페이징
function paging(num, tab){
	if(num){
		$("#pageNo").val(num);
	}
	$("#listForm").attr("action", "/sjy/crossRegist.do").submit();
}
</script>
<body>
 <div>
  <form id="listForm" name="listForm" method="post">
 <input type="hidden" name="hiddenNm" />
  <table border=1>
   <thead>
    <tr>
     <th colspan="6"><h2>교차로목록</h2></th>
    </tr>
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
     <tr>
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
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckNum"
       value="<c:out value='${rs.crossId }'/>" />
       <c:out value="${rs.gisPosx }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckNum"
       value="<c:out value='${rs.crossId }'/>" />
       <c:out value="${rs.gisPosy }" />
      </td>
      <td>
       <input type="hidden" id="<c:out value='${rs.crossId }'/>" name="ckNum"
       value="<c:out value='${rs.crossId }'/>" />
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

 <div id="formPos">
  <form id="insertForm" name="insertForm" method="post">
   <input type="text" id="아이디" name="insertId" placeholder="아이디"/>
   <input type="text" id="이름" name="insertNm" placeholder="이름"/>
   <input type="text" id="번호" name="insertNo" placeholder="번호"/>
   <input type="text" id="X좌표" name="insertX" placeholder="X좌표"/>
   <input type="text" id="Y좌표" name="insertY" placeholder="Y좌표"/>
   <input type="text" id="사용여부" name="insertYn" placeholder="사용여부"/>
   <div id="buttonPos">
    <button type="button" id="insertBtn">등록</button>
    <button type="button" id="cancelBtn">닫기</button>
   </div>
  </form>
 </div>
</body>
</html>