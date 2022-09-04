<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ page import="com.dorothy.member.login.vo.MemberVO" %>
		
	
		<style type="text/css">
			textarea { resize: none; }
			.reply_count { color: red; font-size: small; }
			.required { font-weight: bold; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				
				/* 입력 양식 enter 제거 */
				$("#keyword").bind("keydown", function(event){
					if(event.keyCode == 13){
						event.preventDefault();
					}
				});
				
		
				/* 주문번호 클릭 시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					let o_num = $(this).parents("tr").attr("data-num");
					$("#o_num").val(o_num);
					console.log("글번호 : " + o_num);
					// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
					$("#detailForm").attr({
						"method":"get",
						"action":"/member/order/orderInfoDetail"
					});
					$("#detailForm").submit();
					
				});
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#pageParam").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
			}); // $ 함수 종료문
			
			/* 페이지 이동 처리 함수 */
			function goPage(){
				$("#pageParam").attr({
					"method":"get",
					"action":"/member/order/orderInfoList"
				});
				$("#pageParam").submit();
			}
		</script>
	</head>
	<body>
		<div class="contentContainer container">
<!-- 			<div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div> -->
			<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="o_num" name="o_num" />
			</form>
			
			<%-- ============ 리스트 시작 ============ --%>
			<div id="orderInfoList" class="table-height">
				<table summary="ORDER LIST" class="table table-striped">
					<thead>
						<tr>
							<th class="text-center col-md-1">주문번호</th>
							<th class="text-center col-md-2">결제번호</th>
							<th class="text-center col-md-1">주문자</th>
							<th class="text-center col-md-2">주문상품</th>
							<th class="text-center col-md-1">선택옵션</th>
							<th class="text-center col-md-1">주문수량</th>
							<th class="text-center col-md-1">주문금액</th>
							
							<th class="text-center col-md-2">주문상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty orderInfoList}">
							<c:forEach var="order" items="${orderInfoList}" varStatus="status">
								<tr class="text-center" data-nick="${order.m_id}" data-num="${order.o_num }"> 
									<td class="num">${order.o_num}</td> 
									<td class="goDetail text-center">
										${order.p_merchant_uid}
									</td>
									<td class="text-center">${order.m_id}</td>
									<td class="name">${order.g_name}</td> 
									<td class="text-center">${order.g_size}</td>	
									<td class="text-center">${order.gc_amount}</td>	
									<td class="text-center">${order.g_price}</td>
									<td class="text-center">${order.o_status}</td>								
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="tac text-center">주문내역이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
			</div>
			<%-- ============ 리스트 종료 ============ --%>
				
			<%-- 페이징 처리 커스텀 태그 --%>
			<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
			 
			<%-- 페이징 처리를 위한 파라미터 --%>
			<form id="pageParam" name="pageParam">
				<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
			</form> 
		</div>
	</body>
</html>