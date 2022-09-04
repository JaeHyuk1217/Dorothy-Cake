<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
	
		<script type="text/javascript">
			$(function(){
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word = "<c:out value='${data.keyword}' />";  // Controller의 @ModelAttribute 값 지정 X 시에는 ${boardVO.keyword}
				let value = "";
				if(word != ""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />");
					
					if($("#search").val() != 'm_pnb'){
						//:contains()는 특정 텍스트를 포함한 요소 반환
						if($("#search").val() == 'p_merchant_uid') value = "#list tr td.goDetail";
						else if($("#search").val() == 'm_id') value = "#list tr td.name";  // m_id
						
						
						console.log($(value+":contains('"+word+"')").html());
						
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word, 'gi'); // g : gobal, i : 대소문자 관계 없이
							$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
						});
					}
				}
				
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
		
				/* 주문번호 클릭 시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
															
						let o_num = $(this).parents("tr").attr("data-num");
						$("#o_num").val(o_num);
						console.log("글번호 : " + o_num);
						// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
						$("#detailForm").attr({
							"method":"get",
							"action":"/admin/order/orderInfoDetail"
						});
						$("#detailForm").submit();
				});
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#orderSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
				$("#excelDown").click(function(){
					$("#orderSearch").attr({
						"method":"get",
						"action":"/admin/order/orderExcel"
					});
					$("#orderSearch").submit();
				});
				
			}); // $ 함수 종료문
			
			/* 검색을 위한 실질적인 처리 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#orderSearch").attr({
					"method":"get",
					"action":"/admin/order/orderInfoList"
				});
				$("#orderSearch").submit();
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
			
			<%-- ============ 검색기능 시작 ============ --%>
			<div id="orderInfoSearch" class="text-left">
				<form id="orderSearch" name="orderSearch" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="m_id">주문자</option>
							<option value="p_merchant_uid">주문번호</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" class="btn btn-success">
						<input type="button" value="Excel Download" id="excelDown" name="excelDown" class="btn btn-success" />
					</div>
				</form>
			</div>
			<%-- ============ 검색기능 종료 ============ --%>
			<br />
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