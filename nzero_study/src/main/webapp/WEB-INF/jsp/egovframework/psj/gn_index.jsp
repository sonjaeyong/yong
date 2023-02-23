<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="../psj/gn_index_header.jsp" />

<script type="text/javascript">
$(document).ready(function(){
    map_init();

    $('#serviceSelect').change(function () {
        getLocAndRouteAjax( $(this).val() );
    });

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
                <div style="background-color: white; position: absolute; top: 105px; right: 20px;
                    overflow: auto">
                        <div>
                            <select id="serviceSelect">
                                <option value="">선택없음</option>
                                <c:forEach var="item" items="${vehList}">
                                    <option value="${item.serviceId}"><c:out value="${item.serviceId}" />
                                        <c:out value="(${item.regDateStr})" /></option>
                                </c:forEach>
                            </select>
                        </div>
                </div>
                <div style="background-color: white; position: absolute; top: 150px; right: 20px;
                    overflow: auto; height: 73vh; width: 213px; border: 1px solid #b7b7b7;">
                    <table id="locTable">

                    </table>
                </div>
            </div><!-- //content_body -->

        </div><!-- //content -->
    </div><!-- //container -->

<jsp:include page="../main/sub_footer.jsp" />
