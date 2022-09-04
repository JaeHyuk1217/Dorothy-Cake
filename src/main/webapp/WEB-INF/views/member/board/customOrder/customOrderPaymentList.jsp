<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
	<script type="text/javascript">
		$(function() {
	
			/* 검색 후 검색 대상과 검색 단어 출력 */
			let word = "<c:out value='${data.keyword}' />";
			let value = "";
			if(word != ""){
				$("#keyword").val("<c:out value='${data.keyword}' />");
				$("#search").val("<c:out value='${data.search}' />");
				
				if($("#search").val() != 'f_content'){
					if($("#search").val() == 'f_title') value = "#list tr td.goDetail";
					else if($("search").val() == 'm_id') value = "#list tr td.name";
					
					$(value+":contains('"+word+"')").each(function(){
						let regex = new RegExp(word, 'gi');
						$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
					});
				}
			}
	
			/* 제목 클릭 시 상세 페이지 이동 */
			$(".goDetail").click(function() {
				let g_code = $(this).parents("li").attr("data-num");
				$("#g_code").val(g_code);
				$("#detailForm").attr({
					"method" : "get",
					"action" : "/admin/goods/goodsDetail"
				});
				$("#detailForm").submit();
			});
	
			/* 입력 양식 enter 제거 */
			$("#keyword").bind("keydown", function(event) {
				if (event.keyCode == 13) {
					event.preventDefault();
				}
			});
	
			/* 검색 대상 변경될 때마다 처리 이벤트 */
			$("#search").change(function() {
				$("#keyword").val("");
				$("#keyword").focus();
			});
	
			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchData").click(function() {
				if ($("#search").val() != "all") {
					if (!chkData("#keyword", "검색어를"))
						return;
				}
				$("#pageNum").val(1);
				goPage();
			});
	
			$(".paginate_button a").click(
					function(e) {
						e.preventDefault();
						$("#goodsSearch").find("input[name='pageNum']").val(
								$(this).attr("href"));
						goPage();
					});
		});
	
		/* 실질적으로 검색을 처리하는 함수 */
		function goPage() {
			if ($("#search").val() == "all") {
				$("#keyword").val("");
			}
			$("#goodsSearch").attr({
				"method" : "get",
				"action" : "/admin/goods/goodsList"
			});
			$("#goodsSearch").submit();
		}
	</script>

	<div class="contentContainer container">
		<%-- 상세페이지로 이동을 위한 폼 
			<form id="detailForm">
				<input type="hidden" id="f_num" name="f_num" />
			</form> --%>
	
		<%-- 커스텀 제품 결제 리스트 시작 --%>
		<div id="boardcustomOrderPaymentList">
			<c:choose>
				<c:when test="${not empty boardcustomOrderPaymentList}">
					<c:forEach var="boardcustomOrderPayment" items="${boardcustomOrderPaymentList}" varStatus="status">
					<ul>
						<li>
							<div class="item_cont">
								<div class="item_photo_box">
									<a> <img src="" width="450" alt="데이지 케이크" title="데이지 케이크"
										class="middle">
									</a>
		
								</div>
								<div class="item_tit_box">
									<a href="">
										<p class="item_name">데이지 케이크</p>
									</a>
								</div>
							</div>
						</li>
					</ul>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<li>
						<div class="item_cont">
							<div class="item_photo_box">
								<a> 
									<img src="" width="450" alt="데이지 케이크" title="데이지 케이크" class="middle">
								</a>
							</div>
							<div class="item_tit_box">
								<a href="">
									<p class="item_name">등록된 게시물이 존재하지 않습니다.</p>
								</a>
							</div>
						</div>
					</li>
				</c:otherwise>
			</c:choose>
		</div>
		<%-- 커스텀 제품 결제 리스트 종료 --%>
		
		<%-- 검색 기능 시작 --%>
		<div id="AdminGoodsSearch" class="text-center">
			<form id="goodsSearch" name="goodsSearch" class="form-inline">
				<%-- 페이징 처리를 위한 파라미터 --%>
				<input type="hidden" name="pageNum" id="pageNum"
					value="${pageMaker.cvo.pageNum}"> <input type="hidden"
					name="amount" id="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="g_code">상품코드</option>
						<option value="g_name">상품이름</option>
						<option value="g_type">상품종류</option>
					</select> <input type="text" id="keyword" name="keyword"
						placeholder="검색어를 입력하세요" class="form-control" /> <input
						type="button" value="검색" id="searchData" name="searchData"
						class="btn btn-success" />
				</div>
			</form>
		</div>
		<%-- 검색 기능 종료 --%>
		
		<%-- 페이징 처리 커스텀 태그 --%>
		<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
	</div>



	

	