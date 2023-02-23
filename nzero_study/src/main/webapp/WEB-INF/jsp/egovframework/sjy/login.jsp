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
<title>로그인</title>
<style>
 #loginForm {
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
$(document).ready(function(){
	console.log(getCookie("loginId"));
});
var id;
var pwd;
function login(){
	id = $("#아이디").val();
	pwd = $("#비밀번호").val();
	console.log(id,pwd);
	//$("#loginForm").attr("action", "/sjy/userLogin.do").submit();
	
	var data = {
			id : id,
			pwd : pwd
	}
	var resultNm;
	var resultId;
	var resultPw;
	$.ajax({
		url : "/sjy/userLogin.do",
		dataType : "json",
		type : "POST",
		data : JSON.stringify(data),
		contentType : "application/json",
		success : function(result){
			$.each(result, function(i){
				resultId = result[0].userId;
				resultNm = result[0].userNm;
				resultPw = result[0].userPw;
			})
			if(id != resultId || pwd != resultPw){
				alert("회원정보가 일치하지 않습니다!");
				return false;
			}
			else{
				setCookie("loginId", resultId, 1);
				alert(resultNm+"님 환영합니다!");
				location.replace("/sjy/index.do");
			}
		}
	})
}
//쿠키 생성
var setCookie = function(name, value, exp){
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*365);
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};
//쿠키 가져오기
var getCookie = function(name){
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
};
function regist(){
	if(!confirm("회원가입창으로 이동합니다!")){
		return false;
	}
	location.replace("/sjy/userRegist.do");
}
</script>
<body>
 <div class="wrapper">
  <form id="loginForm" name="loginForm" method="post">
   <input type="text" id="아이디" name="id" placeholder="아이디">
   <input type="password" id="비밀번호" name="pwd" placeholder="비밀번호">
   <button type="button" onclick="login(); return false;">로그인</button>
   <button type="button" onclick="regist(); return false;">회원가입</button>
  </form>
 </div>
</body>
</html>