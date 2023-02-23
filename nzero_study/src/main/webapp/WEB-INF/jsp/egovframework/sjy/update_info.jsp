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
<title>정보수정</title>
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
 #updateFormPos{
 	width: 300px;
 	margin-right: auto;
 	margin-left: auto;
 	padding: 20px;
 	background-color: #FFD1B7;
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
 function check(){
	 var pwd = $("input[name='pwd']").val();
	 console.log(pwd);
	 loginId = getCookie("loginId");
	 $("input[name='id']").val(loginId);
	 var id = $("input[name='id']").val();
	 console.log(id);
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
			 var resArr = [];
			 $("#myInfo").empty();
			 $("input[name='fixId']").val('');
			 $("input[name='name']").val('');
			 $("input[name='pwd']").val('');
			 $("input[name='phonenum']").val('');
			 $("input[name='address']").val('');
			 $("input[name='email']").val('');
			 $.each(result, function(i){
				str += "<tr>";
				str += "<td>" + result[i].userId + " </td>";
				str += "<td>" + result[i].userNm + " </td>";
				str += "<td>" + result[i].userPw + " </td>";
				str += "<td>" + result[i].userPn + " </td>";
				str += "<td>" + result[i].userAdr + " </td>";
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
			 resArr.push($("#myInfo td").text().split(' '));
			 console.log(resArr);
			 $("#updateForm input[type='text']").each(function(i){
				//resArr배열에 들어있긴 하지만 바로 값이 있는게 아니라 한번 더 배열로 쌓여있음
				$(this).val(resArr[0][i]);
			 });
		 }
	 })
 }
//쿠키 가져오기
 var getCookie = function(name){
 	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
 	return value? value[2] : null;
 };
 function updateId(){
	 if(!confirm("수정하시겠습니까?")){
		 return false;
	 }
	 alert("수정완료!");
	 $("#updateForm").attr("action", "/sjy/updateId.do").submit();
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
 
 <div id="updateFormPos">
  <form id="updateForm" name="updateForm" method="post">
   <h3>정보변경하기(아이디제외)</h3>
   <input type="text" id="아이디" name="fixId" placeholder="아이디" readonly>
   <input type="text" id="이름" name="name" placeholder="이름">
   <input type="text" id="비밀번호" name="pwd" placeholder="비밀번호">
   <input type="text" id="전화번호" name="phonenum" placeholder="전화번호">
   <input type="text" id="주소" name="address" placeholder="주소">
   <input type="text" id="이메일" name="email" placeholder="이메일">
   <button type="button" onclick="updateId(); return false;">수정</button>
   <button type="button" onclick="location.replace('/sjy/index.do');">닫기</button>
  </form>
 </div>
</body>
</html>