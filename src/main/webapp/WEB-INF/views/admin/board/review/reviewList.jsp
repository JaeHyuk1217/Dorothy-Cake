<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
			textarea { resize: none; }
			.reply_count { color: red; font-size: small; }
			.required { font-weight: bold; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word = "<c:out value='${data.keyword}' />";
				let value = "";
				if(word != ""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />");
					
					if($("#search").val() != 'r_content'){
						if($("#search").val() == 'r_title') value = "#list tr td.goDetail";
						else if($("search").val() == 'm_id') value = "#list tr td.name";
						
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word, 'gi');
							$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
						});
					}
				}
				
				
				/* 제목 클릭 시 상세 페이지 이동 */
				$(".goDetail").click(function(){
					let r_num = $(this).parents("tr").attr("data-num");
					$("#r_num").val(r_num);
					$("#detailForm").attr({
						"method":"get",
						"action":"/admin/board/review/reviewDetail"
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
				
				/* 삭제 버튼 클릭 시 선택한 글 삭제 */
				$("#deleteFormBtn").click(function(){
					if(confirm("정말 삭제하시겠습니까?")){
						let numArr = [];
						
						$("input:checkbox[name=deleteCheck]:checked").each(function(){
							numArr.push($(this).val());
						});
						
						
						$.ajax({
							url: "/admin/board/review/deleteAll",
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
					$("#reviewSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			}); // $ 함수 종료
			
			/* 실질적으로 검색을 처리하는 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#reviewSearch").attr({
					"method":"get",
					"action":"/admin/board/review/reviewList"
				});
				$("#reviewSearch").submit();
			}
			
		</script>
	</head>
	<body style="padding-top: 0px">
		<div class="contentContainer container">
			<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="r_num" name="r_num" />
			</form>
			
			<div id="boardReviewList" class="table-height">
				<table summary="리뷰게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th class="text-center col-md-1"><input type="checkbox" id="allCheck"></th>
							<th class="text-center col-md-1">목록번호</th>
							<th data-value="r_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="r_date" class="order col-md-1">작성일</th>
							<th class="text-center col-md-1">조회수</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty boardReviewList}">
								<c:forEach var="review" items="${boardReviewList}" varStatus="status">
									<tr class="text-center" data-num="${review.r_num}">
										<td>
											<input type="checkbox" name="deleteCheck" value="${review.r_num}">
										</td>
										<td>${count - status.index}</td>
										<td>${review.r_num}</td>
										<td class="goDetail text-left">
											${review.r_title}
											<c:if test="${review.r_replycnt > 0}">
												<span class="reply_count">&nbsp;[${review.r_replycnt}]</span>
											</c:if>
											<c:if test="${not empty review.r_file}">
												&nbsp;<img src="/resources/images/common/haveimg.png" style="margin-bottom: 0px; vertical-align: middle; display: inline-block;"/>
											</c:if>
										</td>
										<td class="name">${review.m_id}</td>
										<td class="text-left col-md-1">${review.r_date}</td>
										<td class="text-center">${review.r_readcnt}</td>
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
			<%-- 리뷰게시판 리스트 종료 --%>
			
			<%-- 삭제 버튼 출력 --%>
			<div class="contentBtn text-right">
				<input type="button" value="삭제" id="deleteFormBtn" class="btn btn-success">
			</div>
			<%-- 삭제 버튼 종료 --%>
			
			<%-- 검색 기능 시작 --%>
			<div id="boardReviewSearch" class="text-center">
				<form id="reviewSearch" name="reviewSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="r_title">제목</option>
							<option value="r_content">내용</option>
							<option value="m_id">작성자</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" name="searchData" class="btn btn-success" />
					</div>
				</form>
			</div>
			<%-- 검색 기능 종료 --%>
			
			<%-- 페이징 처리 커스텀 태그 --%>
			<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
		</div>
		
	</body>
</html>