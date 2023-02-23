 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

       <div class="inner">
            <h1 class="logo" style="color: white; font-size:27px;"><a href="/main/index.do"><!-- <img src="../img/logo.png" alt="의왕시 교통정보"> -->NZERO_STUDY</a></h1>

            <!-- gnb -->
            <div class="gnb">
                <ul class="dep1_ul">
                    <li>
                        <a href="#" class="dep1">시나리오 관리</a>
                        <ul class="dep2_ul">
                            <li><a href="/main/index.do">시나리오 리스트</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="dep1">PSJ</a>
                        <ul class="dep2_ul">
                            <li><a href="/psj/index.do">메인화면</a></li>
                            <li><a href="/gnpsj/gn_index.do">강릉긴급차량</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="/bjw/index.do" class="dep1">BJW</a>
                        <ul class="dep2_ul">
                            <li><a href="/bjw/index.do">메인화면</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- //gnb -->

        </div><!-- //inner -->
