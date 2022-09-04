<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>    
		<div class="logo-box hei-70 bg-white flex items-center border">
			<!--로고-->
			<div class="img-box img-profile-box ml-5">
				<a href="/" ><img src="/resources/images/common/adminLogo.png"  alt="로고(기본)" title="로고(기본)"   /></a>
			</div>
			<!--중앙.빈공간-->
			<div class="flex-1"></div>
			<!--관리자-->
			<div>
				<a class="nav-link dropdown-toggle flex items-center c-686868 mr-5"
					href="#" id="userDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> <span
					class="text-2xl mr-1"> <i class="fas fa-user-circle"></i>
				</span> <span class="d-none d-lg-inline small text-xs font-bold">${adminLogin.ad_name} 관리자님 환영합니다.</span>
				<c:if test="${adminLogin != null }">
				<a href="/admin/login" class="btn btn-primary btn-sm active" role="button">로그아웃</a>
				</c:if>
				</a>
			</div>
		</div>
