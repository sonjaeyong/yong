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
<title>교차로삭제</title>
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
 	border-left:0;
 	border-right:0;
 	border-width:2px;
 }
 #listTable caption{
 	font-size:20px;
 	font-weight:bold;
 	padding: 0 0 10px 0;
 }
 #listTable th{
 	border-left:0;
 	border-right:0;
 	border-top:0;
 	border-width:2px;
 	background-color: #E2E2E2;
 }
 #buttonPos{
 	text-align:center;
 }
 button{
 	width:100px;
 	border:none;
 	height:40px;
 	background-color:#CD7A7A;
 	color:white;
 	font-size:15px;
 	border-radius:8px;
 	font-weight:bold;
 	cursor:pointer;
 }
</style>
</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#chkAll").change(function(){
		if($(this).is(":checked")){
			$("input[name='chkYn']").prop("checked", true);
		}
		else{
			$("input[name='chkYn']").prop("checked", false);
		}
	});
});
//페이징
function paging(num, tab){
	if(num){
		$("#pageNo").val(num);
	}
	$("#listForm").attr("action", "/sjy/crossDelete.do").submit();
}
function deleteList(){
	var checkArr = [];
	$("input[name='chkYn']:checked").each(function(i, v){
		checkArr.push($(this).attr("id"));
	});
	if(checkArr.length == 0){
		alert("체크된 교차로가 없습니다!");
		return false;
	}
	else{
		if(!confirm("삭제 대상: [ "+checkArr+" "+"] <== 맞습니까?")){
			return false;
		}
	}
	$("#listForm").attr("action", "/sjy/crossFormDelete.do").submit();
}
</script>
<body>
 <div id="formPos">
  <form id="listForm" name="listForm" method="post">
 <input type="hidden" name="hiddenNm" />
  <table border=1 id="listTable">
  <caption>교차로목록</caption>
   <thead>
    <tr>
     <th>
      <div id="checkPos">
       <input type="checkbox" id="chkAll"/>
      </div>
     </th>
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
       <input type="checkbox" id="<c:out value='${rs.crossId }'/>" name="chkYn"
       value="<c:out value='${rs.crossId }'/>"/>
      </td>
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
 <div id="buttonPos">
  <button type="button" onclick="deleteList(); return false;">삭제</button>
  <button type="button" onclick="location.replace('/sjy/index.do');">닫기</button>
 </div>
</body>
</html>