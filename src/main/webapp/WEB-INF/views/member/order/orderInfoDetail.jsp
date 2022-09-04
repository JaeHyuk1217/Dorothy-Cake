<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
	body {
  font-family: "Helvetica Neue", Helvetica, Arial;
  font-size: 14px;
  line-height: 20px;
  font-weight: 400;
  color: #3b3b3b;
  -webkit-font-smoothing: antialiased;
  font-smoothing: antialiased;
  background: #F8F8F8;
}
@media screen and (max-width: 580px) {
  body {
    font-size: 16px;
    line-height: 22px;
  }
}

.wrapper {
  margin: 0 auto;
  padding: 40px;
  max-width: 800px;
  
}

.table {
  margin: 0 0 40px 0;
  width: 100%;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  display: table;
}
@media screen and (max-width: 580px) {
  .table {
    display: block;
  }
}

.row {
  display: table-row;
  background: #f6f6f6;
}
.row:nth-of-type(odd) {
  background: #e9e9e9;
}
.row.header {
  font-weight: 900;
  color: #ffffff;
  background: #CFCACB;
}
.row.green {
  background: #DFC5CD;
}
.row.blue {
  background: #CEC9D9;
}
@media screen and (max-width: 580px) {
  .row {
    padding: 14px 0 7px;
    display: block;
  }
  .row.header {
    padding: 0;
    height: 6px;
  }
  .row.header .cell {
    display: none;
  }
  .row .cell {
    margin-bottom: 10px;
  }
  .row .cell:before {
    margin-bottom: 3px;
    content: attr(data-title);
    min-width: 98px;
    font-size: 10px;
    line-height: 10px;
    font-weight: bold;
    text-transform: uppercase;
    color: #969696;
    display: block;
  }
}

.cell {
  padding: 6px 12px;
  display: table-cell;
}
@media screen and (max-width: 580px) {
  .cell {
    padding: 2px 16px;
    display: block;
  }
}
		</style>

		<script type="text/javascript">
			
		
			 $(function(){
				
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					location.href="/member/order/orderInfoBoardList"
				});
			}); // $ 함수 종료
			
			
		</script>
	</head>
	<body style="padding-top: 0px">
				
			
			<%-- 목록 버튼 보여주기 시작 --%>
			<!-- <div class="btnArea text-right" style="margin-bottom: 5px">
				<input type="button" value="목록" id="orderInfoListBtn" class="btn btn-success" />
			</div> -->
			<%--목록 버튼 보여주기 끝 --%>
			
			
			<%-- ========= 상세 정보 보여주기 시작 ========= --%>
		<div class="wrapper">
  
  <div class="table">
    <H3 >주문정보</H3>
    <div class="row header">
      <div class="cell">
        주문번호
      </div>
      <div class="cell">
        상품명
      </div>
      <div class="cell">
       상품금액
      </div>
      <div class="cell">
        주문상태
      </div>
    </div>
    
    
    
    <div class="row">
      <div class="cell" data-title="Name">
        ${detail.p_merchant_uid}
      </div>
      <div class="cell" data-title="Age">
        ${detail.p_name}
      </div>
      <div class="cell" data-title="Occupation">
        ${detail.p_price}
      </div>
      <div class="cell" data-title="Location">
        ${detail.p_state}
      </div>
    </div>
    
  </div>
  
  <div class="table">
    <H3>주문자정보</H3>
    <div class="row header green">
      <div class="cell">
        주문자성함
      </div>
      <div class="cell">
        휴대폰번호
      </div>
      <div class="cell">
        주소
      </div>
      <div class="cell">
        이메일
      </div>
      
    </div>
    
    <div class="row">
      <div class="cell" data-title="Product">
        ${detail.m_name}
      </div>
      <div class="cell" data-title="Unit Price">
        ${detail.m_pnb}
      </div>
      <div class="cell" data-title="Quantity">
        ${detail.m_addr}
      </div>
      <div class="cell" data-title="Date Sold">
        ${detail.m_mail}
      </div>
      
    </div>
    
  </div>
  
  <div class="table">
    <H3>결제정보</H3>
    <div class="row header blue">
      <div class="cell">
        결제일
      </div>
      <div class="cell">
        결제수단
      </div>
      <div class="cell">
        총결제금액
      </div>
     </div>
    
    <div class="row">
      <div class="cell" data-title="Username">
        ${detail.p_date}
      </div>
      <div class="cell" data-title="Email">
       ${detail.p_pay_method}
      </div>
      <div class="cell" data-title="Password">
       ${detail.p_price}
      </div>
      
    </div>
    
  </div>
  
</div>
		<%-- ========= 상세 정보 보여주기 종료 ========= --%>
		<%-- <jsp:include page="reply.jsp" /> --%>
		<%-- <jsp:include page="boardQnaReply.jsp"></jsp:include> --%>
	</body>
</html>