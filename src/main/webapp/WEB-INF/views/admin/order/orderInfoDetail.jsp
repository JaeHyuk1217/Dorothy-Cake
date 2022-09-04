<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
			table.type10 {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  margin: 20px 10px;
}
table.type10 thead th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #fff;
  background: #e7708d;
  margin: 20px 10px;
}
table.type10 tbody th {
  width: 150px;
  padding: 10px;
}
table.type10 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
}
table.type10 .even {
  background: #fdf3f5;
}
		</style>

		<script type="text/javascript">
			
		
			 $(function(){
				
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				/* $("#boardListBtn").click(function(){
					location.href="/admin/order/orderInfoBoardList"
				});
			});  */// $ 함수 종료
			
			
		</script>
	</head>
	<body style="padding-top: 0px">
				
			
			<%-- 목록 버튼 보여주기 시작 --%>
			<!-- <div class="btnArea text-right" style="margin-bottom: 5px">
				<input type="button" value="목록" id="orderInfoListBtn" class="btn btn-success" />
			</div> -->
			<%--목록 버튼 보여주기 끝 --%>
			
			
			<%-- ========= 상세 정보 보여주기 시작 ========= --%>
		<table class="type10" style="text-align: center">
  
  <tr>
    <th scope="cols" style="text-align: right">주문정보</th>
 
  </tr>
 
  
  <tr>
    <th scope="row">주문번호</th>
    <td>${detail.p_merchant_uid}</td>
  </tr>
  <tr>
    <th scope="row" class="even">상품명</th>
    <td class="even">${detail.p_name}</td>
  </tr>
  <tr>
    <th scope="row">상품금액</th>
    <td>${detail.p_price}</td>
  </tr>
  <tr>
    <th scope="row" class="even">주문상태</th>
    <td class="even">${detail.p_state}</td>
  </tr>
  <br />
 
  <tr>
    <th scope="cols" style="text-align: right">주문자정보</th>
    
  </tr>
  
  
  <tr>
    <th scope="row">주문자성함</th>
    <td> ${detail.m_name}</td>
  </tr>
  <tr>
    <th scope="row" class="even">휴대폰번호</th>
    <td class="even"> ${detail.m_pnb}</td>
  </tr>
  <tr>
    <th scope="row">주소</th>
    <td>${detail.m_addr}</td>
  </tr>
  <tr>
    <th scope="row" class="even">이메일</th>
    <td class="even">${detail.m_mail}</td>
  </tr>
  <br />
 
  <tr>
    <th scope="cols" style="text-align: right">결제정보</th>
    
  </tr>
 
  
  <tr>
    <th scope="row">결제일</th>
    <td> ${detail.p_date}</td>
  </tr>
  <tr>
    <th scope="row" class="even">결제수단</th>
    <td class="even"> ${detail.p_pay_method}</td>
  </tr>
  <tr>
    <th scope="row">총결제금액</th>
    <td>${detail.p_price}</td>
  </tr>
  
</table>
		<%-- ========= 상세 정보 보여주기 종료 ========= --%>
		<%-- <jsp:include page="reply.jsp" /> --%>
		<%-- <jsp:include page="boardQnaReply.jsp"></jsp:include> --%>
	</body>
</html>