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
$(document).ready(function(){
	if("${params.searchCombo}"){
		$("#searchCombo option[value='"+"${params.searchCombo}"+"']").prop("selected", true);
	}
	console.log("${files}");
	var tagStr = "";
	<c:forEach items="${files}" var="fs" varStatus="status">
		tagStr += "<tr>";
		tagStr += "<td>${fs}</td>";
		tagStr += '<td><button type="button" class="btn blue" onclick="goDetail(this)">지도</button></td>';
		tagStr += "</tr>";
	</c:forEach>
	
	$("tbody").html(tagStr);
	/* var headArr = "${result[0]}".replace("[","").replace("]","").split(",");
	$(headArr).each(function(i){
		$("colgroup").append("<col width=110>");
		$("#thead").append("<th>"+headArr[i]+"</th>");
	});
	$("colgroup").append("<col width=100>");
	$("#thead").append("<th>지도</th>");
	
	var dataArr = "${result}".replaceAll("[","").split("]");
	$(dataArr).each(function(i){
		if(i != 0 && dataArr[i]){
			var tagStr = "<tr>";
			var dataRowArr = dataArr[i].split(",");
			$(dataRowArr).each(function(j){
				if(j != 0){
					tagStr += "<td>"+ dataRowArr[j].replace(" ","");
				}
				//console.log(dataRowArr[j]);
			});
			tagStr += '<td>'+'<button type="button" class="btn blue" onclick="goDetail(this)">지도</button>'+'</td>';
			tagStr += "</tr>";
			$("tbody").append(tagStr);
		}
	}); */
	
});

function goSearch(){
	$("#frm").attr("action", "/main/index.do").submit();
}

function goDetail(t){
	var $row = $(t).parents("tr");
	$("input[name='fileNm']").val($row.find('td:eq(0)').text());
	
	$("#frm").attr("action", "/main/detail.do").submit();
}

</script>

<div id="container" class="container">
        <div class="content inner">
            <div class="content_header">
                <h2>실증 시나리오</h2>
                <ol class="breadcrumb">
                    <li class="home"><img src="../img/breadcrumb_home.png" alt="메인"></li>
                    <li>시나리오</li>
                    <li>시나리오 리스트</li>
                </ol>
            </div><!-- //content_header -->

            <div class="content_body">
			<form id="frm" name="frm" method="post">
				<input type="hidden" name="fileNm" />
                <!-- <div class="search_sel mt15">
                    <ul>
		                        <li class="first">
		                            <span>시나리오</span>
		                            <div class="select_wrap">
		                            	<select id="searchCombo" name="searchCombo" class="w150px">
		                            		<option value="">선택</option>
		                            		<option value="1">정상주행</option>
		                            		<option value="2">차로이탈</option>
		                            		<option value="3">차량충돌경고</option>
		                            		<option value="4">장애물감지</option>
		                            		<option value="5">차량이상상황발생</option>
		                            	</select>
		                            	
		                            </div>
		                        </li>
		                        <li class="search_btn">
		                            <button type="button" class="btn blue" onclick="goSearch()">검색</button>
		                        </li>
		                    </ul>
                </div> -->

                <div class="page_btn tar mt40 mb10">
                    
                </div><!-- //page_btn -->

                <div class="list_table tal" style="overflow: scroll;height: 658px;">
                    <table>
                        <colgroup>
                        	<col>
                        	<col width="100">
                        </colgroup>
                        <thead>
                            <tr id="thead">
                            	<th>파일명</th>
                            	<th>지도이동</th>
                            </tr>
                        </thead>
                        <tbody>
                           
                        </tbody>
                    </table>
                </div><!-- //list_table -->
			</form>
            </div><!-- //content_body -->

        </div><!-- //content -->
    </div><!-- //container -->

<jsp:include page="../main/sub_footer.jsp" />
