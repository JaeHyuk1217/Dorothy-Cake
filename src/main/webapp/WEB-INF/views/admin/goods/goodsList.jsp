<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
		<script type="text/javascript">
			$(function(){
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word = "<c:out value='${data.keyword}' />";
				let value = "";
				if(word != ""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />");
					
					if($("#search").val() != 'g_type') value = "#list tr td.g_type";
					else if($("#search").val() == 'g_name') value = "#list tr td.goDetail";
					else if($("search").val() == 'g_code') value = "#list tr td.g_code";
						
/* 					$(value+":contains('"+word+"')").each(function(){
						let regex = new RegExp(word, 'gi');
						$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
					}); */
				}
				
				
				/* 제목 클릭 시 상세 페이지 이동 */
				$(".goDetail").click(function(){
					let g_code = $(this).parents("tr").attr("data-num");
					$("#g_code").val(g_code);
					$("#detailForm").attr({
						"method":"get",
						"action":"/admin/goods/goodsDetail"
					});
					$("#detailForm").submit();
				});
				
				
				/* 체크박스 전체 선택 / 전체 해제 */
				$("#allCheck").click(function(){
					if($("#allCheck").is(":checked")){
						$("input[name='deleteCheck']").prop("checked", true);
					}else{
						$("input[name='deleteCheck']").prop("checked", false);
					}
				});
				
				$("input[name='deleteCheck']").click(function(){
					let total = $("input[name='deleteCheck']").length;
					let checked = $("input[name='deleteCheck']:checked").length;
					
					if(total != checked){
						$("#allCheck").prop("checked", false);
					}else{
						$("#allCheck").prop("checked", true);
					}
					
				});
				
				/* 글쓰기 버튼 클릭 시 글쓰기 폼으로 이동 */
				$("#insertGoodsBtn").click(function(){
					/* 로그인 유효성 체크
					if(){
						alert("회원만 작성할 수 있습니다.");
					}
					*/
					
					location.href="/admin/goods/goodsInsertForm";
				});
				
				/* 삭제 버튼 클릭 시 선택한 글 삭제 */
				$("#deleteFormBtn").click(function(){
					let numArr = [];
					
					$("input:checkbox[name=deleteCheck]:checked").each(function(){
						numArr.push($(this).val());
					});
					
					if(numArr.length == 0) {
						alert("삭제를 원하시는 항목을 선택하여주십시오.");
						return;
					}
					
					if(confirm("정말 삭제하시겠습니까?")){
						
						$.ajax({
							url: "/admin/goods/deleteAll",
							type: "post",
							traditional : true,
							data: { "numArr" : numArr },
							error: function(request,status,error){
								alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
							},
							success: function(resultData){
								alert("선택한 게시글이 삭제되었습니다.");
								location.reload();
							}
						});
					}
				});
				
				$("#excelDown").click(function(){
					$("#goodsSearch").attr({
						"method" : "get",
						"action" : "/admin/goods/goodsExcel"
					})
					$("#goodsSearch").submit();
				});
				
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
					$("#goodsSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			}); // $ 함수 종료
			
			/* 실질적으로 검색을 처리하는 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#goodsSearch").attr({
					"method":"get",
					"action":"/admin/goods/goodsList"
				});
				$("#goodsSearch").submit();
			}
			
		</script>
		</head>
	<body style="padding-top: 0px">
		<div class="contentContainer container">
			<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="g_code" name="g_code" />
			</form>
			
			<%-- 상품 리스트 시작 --%>
			<div id="goodsList" class="table-height">
				<table summary="상품 리스트" class="table table-striped">
					<thead>
						<tr>
							<th class="text-center col-md-1"><input type="checkbox" id="allCheck"></th>
							<th data-value="g_code" class="text-center col-md-1">상품코드</th>
							<th class="text-center col-md-2">상품이름</th>
							<th class="text-center col-md-1">상품종류</th>
							<th class="text-center col-md-2">가격</th>
							<th data-value="g_file" class="text-center col-md-1">상품사진</th>
							<th class="text-center col-md-1">신상품 | 추천태그</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty goodsList}">
								<c:forEach var="goods" items="${goodsList}" varStatus="status">
									<tr class="text-center" data-num="${goods.g_code}">
										<td>
											<input type="checkbox" name="deleteCheck" value="${goods.g_code}">
										</td>
										<td class="g_code">${goods.g_code}</td>
										<td class="goDetail">${goods.g_name}</td>
										<td class="g_type">
											<c:if test="${goods.g_type eq 1 }">
											프리미엄 케이크
											</c:if>
											<c:if test="${goods.g_type eq 2 }">
											레터링 케이크
											</c:if>
											<c:if test="${goods.g_type eq 3 }">
											부가상품
											</c:if>
										</td>
										<td>${goods.g_price}</td>
										<td class="col-md-1">
											<c:if test="${not empty goods.g_file}">
												&nbsp;<img id="smallImg" src="/dorothyUpload/goods/${goods.g_file }" style="margin-bottom: 0px; vertical-align: middle; display: inline-block; width: 30px; height: 30px;"/>
											</c:if></td>
										<td class="text-center">
											<c:if test="${goods.g_new eq 1 }">
												O
											</c:if>
											<c:if test="${goods.g_new eq 2 }">
												X
											</c:if>
										 | 
											<c:if test="${goods.g_recommend eq 1 }">
												O
											</c:if>
											<c:if test="${goods.g_recommend eq 2 }">
												X
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>					
					</tbody>
				</table>
			</div>
			<%-- 상품 리스트 종료 --%>
			
			<%--  버튼 출력 --%>
			<div class="contentBtn text-right">
				<input type="button" value="등록" id="insertGoodsBtn" class="btn btn-success">
				<input type="button" value="삭제" id="deleteFormBtn" class="btn btn-success">
			</div>
			<%--  버튼 종료 --%>
			
			<%-- 검색 기능 시작 --%>
			<div id="AdminGoodsSearch" class="text-center">
				<form id="goodsSearch" name="goodsSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="g_code">상품코드</option>
							<option value="g_name">상품이름</option>
							<option value="g_type">상품종류</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" name="searchData" class="btn btn-success" />
						<input type="button" value="엑셀 다운로드" id="excelDown" name="excelDown" class="btn btn-success" />
					</div>
				</form>
			</div>
			<%-- 검색 기능 종료 --%>
			
			<%-- 페이징 처리 커스텀 태그 --%>
			<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
		</div>
		
	</body>
</html>