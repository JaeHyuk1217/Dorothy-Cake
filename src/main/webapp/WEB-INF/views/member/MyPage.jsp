<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
		#mypage ul{float: left; width : 100%; position: relative; margin : 0 200px;}
		#mypage ul li{display : inline-block; position: relative; margin : 15px 50px; }
		h1 {float : center;}
	</style>
	<script type="text/javascript">
		$(function(){
			$(".needLogin").click(function(){
				alert("로그인이 필요한 메뉴입니다.")
			});
		});
	</script>

<h1 class= "text-center">MY PAGE</h1>
<br/><br/><br/><br/>
<div id = "mypage">
	<ul class="mypage-list">
	  <li>
	    <c:if test="${member == null }">
	    <a class="needLogin" href ="#">
	    </c:if>
	  	<c:if test="${member != null }">
	    <a href ="/member/order/orderInfoList">
	    </c:if>
	    <img
	      class="mypage-img" 
	      src="/resources/images/mypage/order.png"
	      width= 80px; height= 80px;></a>
	      <p class="text-center">ORDER<br /><br /><br /></p>
	  </li>
	  <li>
	  
	  <c:if test="${member == null }">
	    <a class="needLogin" href ="#">
	    </c:if>
	  	<c:if test="${member != null }">
	    <a href ="/member/profileUpdate">
	    </c:if>
	    <img
	      class="mypage-img"
	      src="/resources/images/mypage/profile.png"
	      width= 70px; height= 70px;></a>
	      <p class="text-center">PROFILE<br />UPDATE<br /><br /><br /></p>
	  </li>
	  <li>
	    <a href ="/board/qna/myList"><img
	      class="mypage-img" 
	      src="/resources/images/mypage/qnareview.png"
	      width= 100px; height= 100px;></a>
	      <p class="text-center">Q&amp;A / REIVEW<br /><br /><br /></p>
	      
	  </li>
	  <li>
	  	<c:if test="${member == null }">
	    <a class="needLogin" href ="#">
	    </c:if>
	  	<c:if test="${member != null }">
	    <a href ="/member/cart/cartList">
	    </c:if>

	    <img
	      class="mypage-img" 
	      src="/resources/images/mypage/cart.png"
	      width= 70px; height= 70px;></a>
	      <p class="text-center">CART<br /><br /><br /></p>
	  </li>
	</ul>
</div>