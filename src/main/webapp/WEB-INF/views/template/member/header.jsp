<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>	
	<script type="text/javascript">
		$(function(){
			$(".needLogin").click(function(){
				alert("로그인이 필요한 메뉴입니다.");
			});
		});
	</script>
	<div id="header">
			<ul class="navi">
				<li>
					<a href="#" >&nbsp;</a>
				</li>
				<li><a href="#">CAKE</a>
					<ul class="depth_1 sub">
						<li>
							<a href="/member/goods/goodsList" >프리미엄 케이크</a>
						</li>
						<li>
							<a href="/member/goods/goodsListLetter" >레터링 케이크</a>
						</li>
						<li>
							<a href="/member/goods/goodsListAddition" >추가상품</a>
						</li>
					</ul>
				<li><a href="#">CUSTOM</a>
					<ul class="sub">
						<li>
							<a href="/board/customOrder/customOrderList">주문서 확인</a>
						</li>
						<li>
							<a href="/board/customOrder/customOrderWriteForm" >주문서 작성</a>
						</li>
					</ul>
				</li>
				<li><a href="#">COMMUNITY</a>
					<ul class="sub">
						<li>
							<a href="/board/notice/boardNoticeList">NOTICE</a>
						</li>
						<li>
							<a href="http://localhost:8080/member/event/eventList">EVENT</a>
						</li>
						<li>
							<a href="/board/qna/boardList">Q&amp;A</a>
						</li>
						<li>
							<a href="/board/review/boardReviewList">REVIEW</a>
						</li>
						<li>
							<a href="/board/free/boardFreeList">FREE</a>
						</li>
					</ul>
				</li>
			</ul>
	  
			<div class="logo">
				<span><a href="/" >
					<img src="/resources/images/common/logo.png"  alt="로고(기본)" title="로고(기본)"   />
				</a></span>
			</div>
			<div class="section_right">
				<div class="member">
					<ul class="menu_mem">
						<li><c:if test="${member == null }">
								<a href="/member/login">LOGIN</a>
							</c:if></li>
						<li><c:if test="${member != null }">
								<a href="/member/logout">LOGOUT</a>
							</c:if></li>
						<li><a href="/member/register">JOIN</a></li>
						<li><c:if test="${member == null }">
								<a class="needLogin" href="#">CART</a>
							</c:if></li>
								<li><c:if test="${member != null }">
								<a href="/member/cart/cartList">CART</a>
							</c:if></li>
							
							<li><c:if test="${member == null }">
								<a class="needLogin" href="#">ORDER</a>
							</c:if></li>
								<li><c:if test="${member != null }">
								<a href="/member/order/orderInfoList">ORDER</a>
							</c:if></li>
							
						<li><c:if test="${member == null }">
								<a class="needLogin" href="#">MYPAGE</a>
							</c:if></li>
								<li><c:if test="${member != null }">
								<a href="/member/MyPage">MYPAGE</a>
							</c:if></li>
					</ul>
				</div>
			</div>
		</div>