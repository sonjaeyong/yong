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
<title>회원가입</title>
<style>
 #registForm {
 	background-color: #FFD1B7;
 	margin-top:50px;
 	width: 300px;
 	margin-right: auto;
 	margin-left: auto;
 	padding: 20px;
 	text-align: center;
 }
 input{
 	width: 250px;
 	height: 30px;
 	font-size: 15px;
 	padding: 5px;
 	border: none;
 	border-radius: 7px;
 	margin-bottom: 10px;
 }
 button{
 	width: 260px;
 	height: 40px;
 	font-size: 15px;
 	padding: 5px;
 	border: none;
 	border-radius: 7px;
 	margin-bottom: 10px;
 	background-color: #FF9364;
 	cursor: pointer;
 }
</style>
</head>
<script type="text/javascript">
var userArr = [];
var id;
$(document).ready(function(){
	$("#hiddenTable td").each(function(i){
		 userArr.push($(this).children("input[type='hidden']").val());
	 });
	console.log(userArr);
});
function regist(){
	id = $("input[name='id']").val();
	if(userArr.includes(id)){
		alert("중복된 ID입니다!!");
		return false;
	}
	else{
		if(!confirm("가입하시겠습니까?")){
			return false;
		}
	}
	alert("회원가입 완료!");
	$("#registForm").attr("action", "/sjy/registId.do").submit();
}
function cancel(){
	location.replace("/sjy/login.do");
}
</script>
<body>
 <div>
  <table id="hiddenTable">
  <c:forEach items="${result }" var="rs" varStatus="status">
   <tr>
    <td>
     <input type="hidden" id="<c:out value='${rs.userId }'/>" name="ckId"
       value="<c:out value='${rs.userId }'/>" />
    </td>
   </tr>
   </c:forEach>
  </table>
 </div>
 <div class="wrapper">
  <form id="registForm" name="registForm" method="post">
   <input type="text" id="아이디" name="id" placeholder="아이디">
   <input type="text" id="이름" name="name" placeholder="이름">
   <input type="text" id="비밀번호" name="pwd" placeholder="비밀번호">
   <input type="text" id="전화번호" name="phonenum" placeholder="전화번호">
   <input type="text" id="주소" name="address" placeholder="주소">
   <input type="text" id="이메일" name="email" placeholder="이메일">
   <button type="button" onclick="regist(); return false;">회원가입</button>
   <button type="button" onclick="cancel(); return false;">취소</button>
  </form>
 </div>
</body>
</html>