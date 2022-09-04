<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ page import="com.dorothy.member.login.vo.MemberVO" %>

	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	<script type="text/javascript">
	  	$(function(){
	  		
	  		makeUid();
	  		
	  		<%
				MemberVO member = (MemberVO)session.getAttribute("member");
				String name = member.getM_name();
				String phone = member.getM_pnb();
			%>
			
			let loginName = "<%= name %>";
			let loginPhone = "<%= phone %>";
			
	  		/* 주문자와 정보가 같을 때 */
	  		$("#sameInfo").click(function(){
	  			
	  			
	  			$("#m_name").val("");
	  			$("#m_name").val(loginName);
	  			$("#m_pnb").val("");
	  			$("#m_pnb").val(loginPhone);
	  		});
	  		
	  		$("#goPaymentBtn").click(function(){
	  			if(!chkData("#m_name", "수령인을")) return;
	  			else if(!chkData("#m_pnb", "연락처를")) return;
	  			
	  			let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	  			
	  			if(!regPhone.test($("#m_pnb").val())){
	  				alert("연락처는 01*-****-**** 형태로 입력해 주세요.");
	  				return false;
	  			}
	  			
	  			let merchant_uid = $("#p_merchant_uid").val();
	  			let phone = $("#m_pnb").val();
	  			let amount = $("#p_price").val();
	  			let length = $("#list > tr").length - 1;
	  			let g_name;
	  			if(length == 0){
	  				g_name = $("#list > tr:eq(0)").attr("data-name");
	  			}else{
	  				g_name = $("#list > tr:eq(0)").attr("data-name") + " 외 " + length + "건" ;
	  			}
	  			$("#p_name").val(g_name);
	  			
	  			var IMP = window.IMP;
	  		    IMP.init("imp23123052");
	  		    IMP.request_pay({
	  		    	pg : "nice",
	  		    	pay_method : "card",
	  		    	merchant_uid : merchant_uid,
	  		    	name : g_name,
	  		    	amount : amount,
	  		    	buyer_tel : phone
	  		    }, function(rsp){
	  		    	if (rsp.success){
	  		    		alert("결제가 완료되었습니다.");
	  		    		$("#paymentSuccess").attr({
	  		    			"method":"post",
	  		    			"action":"/payment/paymentSuccess"
	  		    		});
	  		    		$("#paymentSuccess").submit();
	  		    	}else {
	  		    		alert("결제가 취소되었습니다.");
	  		    	}
	  		    });
	  		});
	  	}); // $ 함수 종료
	
	    function makeUid(){
	  		$.ajax({
	  			url: "/payment/makeUid",
	  			type: "post",
	  			dataType: "text",
	  			async: false,
	  			error : function(){
	  				alert("시스템 오류입니다. 관리자에게 문의 하세요.");
	  			},
	  			success : function(resultData){
	  				console.log(resultData);
	  				$("#p_merchant_uid").val(resultData);
	  			}
	  		});
	  	}
	    
	</script>
	</head>
	<body>
			<div class="contentContainer container">
			<%-- 구매할 상품 리스트 시작 --%>
			<div id="" class="table-height">
				<table summary="상품 리스트" class="table table-striped">
					<thead>
						<tr>
							<th class="text-center col-md-1"></th>
							<th class="text-center col-md-5">상품정보</th>
							<th class="text-center col-md-1">수량</th>
							<th class="text-center col-md-1">상품금액</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
							<c:set var="allPrice" value="0" />
							<c:forEach var="cart" items="${cartList}" varStatus="status">
								<tr class="text-center" data-name="${cart.g_name}">
									<td>
										<img src="/dorothyUpload/goods/${cart.g_file}" style="height: 50px" />
									</td>
									<td class="text-center">${cart.g_name}</td>
									<td class="text-center">${cart.gc_amount}</td>
									<td class="text-center">${cart.gc_amount * cart.g_price}</td>
								</tr>
								<c:set var="allPrice" value="${allPrice + cart.gc_amount * cart.g_price}" />
								<c:if test="${status.first}">
									<c:set var="gc_num" value="${cart.gc_num}" />
								</c:if>
								<c:if test="${not status.first}">
									<c:set var="gc_num" value="${gc_num},${cart.gc_num}" />
								</c:if>
							</c:forEach>				
					</tbody>
				</table>
			</div>
			<%-- 상품 리스트 종료 --%>
			
			<hr />
			
			<%-- 주문자 정보 시작 --%>
			<div id="" class="table-height">
				<table class="table table-condensed">
					<tr>
						<th colspan="2">
							수령인 정보&nbsp;
							<button type="button" id="sameInfo" name="sameInfo">주문자정보와동일</button>
						</th>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" id="m_name" name="m_name" /></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" id="m_pnb" name="m_pnb" /></td>
					</tr>
				</table>
				
					<table class="table table-condensed">
					<tr>
						<th colspan="2">
							주문자 정보
						</th>
					</tr>
					<tr>
						<td>이름</td>
						<td>${member.m_name}</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>${member.m_pnb}</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>${member.m_mail}</td>
					</tr>
				</table>	
			</div>
			<%-- 배송지 / 주문인 정보 시작 종료 --%>
			
			<%-- 결제 버튼 출력 --%>
			<div class="contentBtn text-right">
				결제 금액 : ${allPrice}&nbsp;
				<input type="button" value="결제하기" id="goPaymentBtn" class="btn btn-success">
			</div>
			<%-- 결제 버튼 종료 --%>
			
			<form id="paymentSuccess">
				<input type="hidden" id="p_merchant_uid" name="p_merchant_uid" />
				<input type="hidden" id="m_id" name="m_id" value="${member.m_id}" />
				<input type="hidden" id="p_price" name="p_price" value="${allPrice}" />
				<input type="hidden" id="p_name" name="p_name" />
				<input type="hidden" id="p_status" name="p_state" value="결제완료" />
				<input type="hidden" id="gc_num" name="gc_num" value="${gc_num}" />
			</form>
		</div>
	</body>
</html>