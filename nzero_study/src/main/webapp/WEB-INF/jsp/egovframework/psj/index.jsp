<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="../psj/olmap_header.jsp" />

<script type="text/javascript">
$(document).ready(function(){
    map_init();
    MapLayer_Traffic_Level_5.setVisible(true);
    setInterval(intervalStatusOfCam, 3000);
    setInterval(intervalStatusOfVms, 3000);
	
});



</script>

<div id="container" class="container">
        <div class="">
            <%--<div class="content_header">
                <h2>psj test page</h2>
                <ol class="breadcrumb">
                    <li class="home"><img src="../img/breadcrumb_home.png" alt="메인"></li>
                    <li>PSJ</li>
                    <li>메인화면</li>
                </ol>
            </div><!-- //content_header -->--%>

            <div class="content_body">
			    <div id="map" style="width: 100%; height: 84.1vh;"></div>
                <div style="background-color: white; position: absolute; top: 105px; right: 20px;">
                        <div>
                            <label for="camChk">CCTV</label>
                            <input class="infraChk" type="checkbox" id="camChk" name="cam" checked>
                            <label for="camChk1">정상</label>
                            <input class="infraChk" type="checkbox" id="camChk1" name="cam1" checked>
                            <label for="camChk0">장애</label>
                            <input class="infraChk" type="checkbox" id="camChk0" name="cam0" checked>
                            <label for="camChk2">알수없음</label>
                            <input class="infraChk" type="checkbox" id="camChk2" name="cam2" checked>
                        </div>
                        <div>
                            <label for="vmsChk">&nbsp;VMS</label>
                            <input class="infraChk" type="checkbox" id="vmsChk" name="vms" checked>
                            <label for="vmsChk1">정상</label>
                            <input class="infraChk" type="checkbox" id="vmsChk1" name="vms1" checked>
                            <label for="vmsChk0">장애</label>
                            <input class="infraChk" type="checkbox" id="vmsChk0" name="vms0" checked>
                            <label for="vmsChk2">알수없음</label>
                            <input class="infraChk" type="checkbox" id="vmsChk2" name="vms2" checked>
                        </div>
                </div>
            </div><!-- //content_body -->

        </div><!-- //content -->
    </div><!-- //container -->

<jsp:include page="../main/sub_footer.jsp" />
