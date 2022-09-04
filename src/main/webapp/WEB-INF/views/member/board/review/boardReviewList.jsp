<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
			textarea { resize: none; }
			.reply_count { color: red; font-size: small; }
			.required { font-weight: bold; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word="<c:out value='${data.keyword}' />";
				let value="";
				if(word!=""){
					$("#keyword").val("<c:out value='${data.keyword}' />"); // 검색한 후 검색창에 단어가 그대로 남아있음
					$("#search").val("<c:out value='${data.search}' />"); // controller에서 @ModelAttribute에 주어진 이름 확인
					
					if($("#search").val()!='r_content'){
						//:contains()는 특정 텍스트를 포함한 요소반환
						if($("#search").val()=='r_title') value = "#list tr td.goDetail";
						else if($("#search").val()=='m_id') value = "#list tr td.name";
						console.log($(value+":contains('"+word+"')").html());
						
						$(value+":contains('"+word+"')").each(function () {
							let regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
						});
					}
				}
				
				/* 입력 양식 enter 제거 */
				$("#keyword").bind("keydown", function(event){
					if (event.keyCode == 13) {
						event.preventDefault();
					}
				});
				
				/* 검색 대상이 변경될 때마다 처리 이벤트 */
				$("#search").change(function(){
					if($("#search").val()=="all"){
						$("#keyword").val("전체 데이터 조회합니다.");
					}else if($("#search").val()!="all"){
						$("#keyword").val("");
						$("#keyword").focus();
					}
				});
				
				/* 검색 버튼 클릭 시 처리 이벤트 */
				$("#searchData").click(function(){
					if($("#search").val()!="all"){
						if(!chkData("#keyword", "검색어를")) return;
					}
					goPage();
				});
				
				/* 글쓰기 버튼 클릭 시 처리 이벤트 */
				$("#insertFormBtn").click(function(){
					location.href = "/board/review/reviewWriteForm";
				});
				
				/* 제목 클릭 시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					let r_num = $(this).parents("tr").attr("data-num");
					$("#r_num").val(r_num);
					console.log("글번호 : "+r_num);
					// 상세 페이지로 이동하기 위해 form 추가(id : detailForm)
					$("#detailForm").attr({
						"method":"get",
						"action":"/board/review/boardReviewDetail"
					});
					$("#detailForm").submit();
				});
				
				$(".paginate_button a").click(function(e) {
					e.preventDefault();
					$("#reviewSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});		

			}); // $ 함수 종료문
			
			/* 검색을 위한 실질적인 처리 함수 */
			function goPage(){
				if($("#search").val()=="all"){
					$("#keyword").val("");
				}
				$("#reviewSearch").attr({
					"method":"get",
					"action":"/board/review/boardReviewList"
				});
				$("#reviewSearch").submit();
			}
		</script>
		
	</head>
	<body>
		<div class="container">
			<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div> -->
			
			<form id="detailForm">
				<input type="hidden" id="r_num" name="r_num" />
			</form>
			
			<%-- ======================= 검색기능 시작 ======================= --%>
			<div id="boardReviewSearch" class="text-center">
				<form id="reviewSearch" name="reviewSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="r_title">제목</option>
							<option value="r_content">내용</option>
							<option value="m_id">작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" /> <!-- placeholder는 화면에만 보이는 안내문구이고, value는 초기값 -->
						<button type="button" id="searchData" class="btn btn-success">검색</button>
					</div>
				</form>
			</div>
			<%-- ======================= 검색기능 종료 ======================= --%>
			
			<%-- ======================= 리스트 시작 ======================= --%>
			<div id="boardReviewList" class="table-height">
				<table summary="리뷰게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="r_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th class="text-center col-md-4">이미지</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty boardReviewList}">
								<c:forEach var="boardReview" items="${boardReviewList}" varStatus="status">
									<tr class="text-center" data-num="${boardReview.r_num}">
										<td>${boardReview.r_num}</td>
										<td class="goDetail text-center">
											${boardReview.r_title}
											<c:if test="${boardReview.r_replycnt > 0}">
												<span class="reply_count">&nbsp;[${boardReview.r_replycnt}]</span>
											</c:if>
										</td>
										<td class="name">${boardReview.m_id}</td>
										<td>
											<c:if test="${not empty boardReview.r_thumbnail}">
												<img src="/dorothyUpload/review/thumbnail/${boardReview.r_thumbnail}" />
											</c:if>
											<c:if test="${empty boardReview.r_thumbnail}">
												<img src="/resources/images/review/noimage.png" />
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
			<%-- ======================= 리스트 종료 ======================= --%>
			
			<%-- ======================= 리뷰쓰기 버튼 출력 시작 ======================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="insertFormBtn" class="btn btn-success">리뷰쓰기</button>
			</div>
			<%-- ======================= 글쓰기 버튼 출력 종료 ======================= --%>
			
			
			
			<%-- 페이징 처리를 커스텀태그(pagination)를 정의 --%>
			<tag:pagination pageNum="${pageMaker.cvo.pageNum}" amount="${pageMaker.cvo.amount}" startPage="${pageMaker.startPage}" endPage="${pageMaker.endPage}" prev="${pageMaker.prev}" next="${pageMaker.next}" />
			
			
		</div>
	</body>
</html>