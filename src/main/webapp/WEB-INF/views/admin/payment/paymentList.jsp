<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	<script type="text/javascript">
		$(function(){
			/* 입력 양식 enter 제거 */
			$("#keyword").bind("keydown", function(event){
				if(event.keyCode == 13){
					event.preventDefault();
				}
			});
			
			/* 검색 대상 변경될 때마다 처리 이벤트 */
			$("#search").change(function(){
				$("#keyword").val("");
				$("#keyword").focus();		
			});
			
			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchData").click(function(){
				if($("#search").val() != "all"){
					if(!chkData("#keyword", "검색어를")) return;
				}
				$("#pageNum").val(1);
				goPage();
			});
			
			$(".paginate_button a").click(function(e){
				e.preventDefault();
				$("#paymentSearch").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
			
			/* 결제 취소 */
			$(".cancelBtn").click(function(){
				let merchant_uid = $(this).parents("tr").attr("data-uid");
				console.log(merchant_uid);
				$("#merchant_uid").val(merchant_uid);
				$.ajax({
						url: "/admin/payment/paymentCancel",
						type: "post",
						data: {"merchant_uid":merchant_uid},
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							alert("해당 결제가 취소되었습니다.");
							location.reload();
						}
					});
			});
			
			$("#excelDown").click(function(){
				$("#paymentSearch").attr({
					"method":"get",
					"action":"/admin/payment/paymentExcel"
				});
				$("#paymentSearch").submit();
			});
		}); // $ 함수 종료
		
		function goPage(){
			if($("#search").val() == "all"){
				$("#keyword").val("");
			}
			$("#paymentSearch").attr({
				"method":"get",
				"action":"/admin/payment/paymentList"
			});
			$("#paymentSearch").submit();
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- 검색 기능 시작 --%>
			<div id="searchList" class="text-left">
				<form id="paymentSearch" name="paymentSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="p_merchant_uid">주문번호</option>
							<option value="m_id">구매자명</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" name="searchData" class="btn btn-success" />
						<input type="button" value="Excel Download" id="excelDown" name="excelDown" class="btn btn-success" />
					</div>
				</form>
			</div>
			<%-- 검색 기능 종료 --%>
			<br />
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="text-center col-md-2">주문번호</th>
						<th class="text-center col-md-4">주문내용</th>
						<th class="text-center col-md-1">구매자명</th>
						<th class="text-center col-md-1">결제금액</th>
						<th class="text-center col-md-2">결제날짜</th>
						<th class="text-center col-md-1">결제상태</th>
						<th class="text-center col-md-1"></th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty paymentList}">
							<c:forEach var="payment" items="${paymentList}" varStatus="status">
								<tr class="text-center" data-uid="${payment.p_merchant_uid}">
									<td class="text-center">${payment.p_merchant_uid}</td>
									<td class="text-center">${payment.p_name}</td>
									<td class="text-center">${payment.m_id}</td>
									<td class="text-center">${payment.p_price}</td>
									<td class="text-center">${payment.p_date}</td>
									<td class="text-center">${payment.p_state}</td>
									<td class="text-center">
										<c:if test="${payment.p_state eq '결제완료'}">
											<input type="button" class="cancelBtn btn btn-danger" value="결제취소" />
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="text-center">결제내역이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<form id="cancelForm">
				<input type="hidden" id="merchant_uid" name="merchant_uid" />
			</form>
			
			<%-- 페이징 처리 커스텀 태그 --%>
			<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
		</div>
	</body>
</html>