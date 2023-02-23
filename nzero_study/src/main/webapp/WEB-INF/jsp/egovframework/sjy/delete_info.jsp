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
<title>회원탈퇴</title>
<style>
 #checkPos{
 	text-align: center;
 	margin-bottom: 10px;
 }
 #checkForm > button{
 	width: 100px;
 	background-color: #F4A460;
 }
 #tablePos{
 	width: 1000px;
 	margin-right: auto;
 	margin-left: auto;
 	text-align: center;
 	margin-bottom: 10px;
 }
 #tablePos table{
 	width: 100%;
 	text-align: center;
 }
 #buttonPos{
 	margin-right: auto;
 	margin-left: auto;
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
 	font-weight: bold;
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
 var loginId;
 var pwd;
 function check(){
	 loginId = getCookie("loginId");
	 $("input[name='id']").val(loginId);
	 var id = $("input[name='id']").val();
	 pwd = $("input[name='pwd']").val();
	 var data = {
			 id : id,
			 pwd : pwd
	 };
	 $.ajax({
		 url : "/sjy/pwdCheck.do",
		 dataType : "json",
		 type : "POST",
		 data : JSON.stringify(data),
		 contentType : "application/json",
		 success : function(result){
			 var str = "";
			 $("#myInfo").empty();
			 $(result).each(function(i){
				str += "<tr>";
				str += "<td>" + result[i].userId + "</td>";
				str += "<td>" + result[i].userNm + "</td>";
				str += "<td>" + result[i].userPw + "</td>";
				str += "<td>" + result[i].userPn + "</td>";
				str += "<td>" + result[i].userAdr + "</td>";
				str += "<td>" + result[i].userEm + "</td>";
				str += "</tr>";
			 });
			 if(result[0] == null){
				 alert("비밀번호가 일치하지 않습니다!");
				 var err = "";
				 err += "<tr>";
				 err += "<td colspan='6'>" + "비밀번호를 조회해주세요." + "</td>";
				 err += "</tr>";
				 $("#myInfo").append(err);
				 return false;
			 }
			 else{
				 $("#myInfo").append(str);
			 }
		 }
	 })
 }
 
 //쿠키 가져오기
 var getCookie = function(name){
 	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
 	return value? value[2] : null;
 };
 function deleteId(){
	 if(!confirm("탈퇴하시겠습니까?")){
		 return false;
	 }
	 alert("탈퇴완료");
	 $("#checkForm").attr("action", "/sjy/deleteId.do").submit();
 }
</script>
<body>
 <div id="checkPos">
 <form id="checkForm" name="checkForm" method=post>
  <input type="hidden" name="id" id="아이디">
  <input type="password" name="pwd" id="비밀번호" placeholder="비밀번호">
  <button type="button" onclick="check(); return false;">조회</button>
 </form>
 </div>
 
 <div id="tablePos">
  <table border=1>
   <thead>
    <tr>
     <th colspan="6">내 정보</th>
    </tr>
    <tr>
     <td>ID</td>
     <td>NAME</td>
     <td>PASSWORD</td>
     <td>PHONE<br>NUMBER</td>
     <td>ADDRESS</td>
     <td>EMAIL</td>
    </tr>
   </thead>
   <tbody id="myInfo">
    <tr>
     <td colspan="6">비밀번호를 조회해주세요.</td>
    </tr>
   </tbody>
  </table>
 </div>
 
 <div id="buttonPos">
  <button type="button" onclick="deleteId(); return false;">탈퇴</button>
  <button type="button" onclick="location.replace('/sjy/index.do');">닫기</button>
 </div>
</body>
</html>