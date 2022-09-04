<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>	

<div id = "top">
	<div class="section_right">
		<c:if test="${member != null }">
			<div>
				<p>${member.m_name}님환영 합니다.</p>
				<a href="/member/logout" class="btn btn-primary btn-sm active"
					role="button">로그아웃</a>
			</div>
		</c:if>
		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>
	</div>
</div>