<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ page import="com.dorothy.member.login.vo.MemberVO" %>
		
		<!-- <style type="text/css">
			.reply_count{
				color : red;
				font-size: small;
			}
		</style> -->
		<style type="text/css">
			textarea { resize: none; }
			.reply_count { color: red; font-size: small; }
			.required { font-weight: bold; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word = "<c:out value='${data.keyword}' />";  // Controller의 @ModelAttribute 값 지정 X 시에는 ${boardVO.keyword}
				let value = "";
				if(word != ""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />");
					
					if($("#search").val() != 'q_content'){
						//:contains()는 특정 텍스트를 포함한 요소 반환
						if($("#search").val() == 'q_title') value = "#list tr td.goDetail";
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
				
				/* 검색 대상이 변경될 때마다 처리 이벤트 */
				/* $("#search").change(function(){
					if($("#search").val() == "all"){
						$("#keyword").val("전체 데이터 조회합니다.");
					}else if($("#search").val() != "all"){
						$("#keyword").val("");
						$("#keyword").focus();
					}
				}); */
				
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
				
				/* 글쓰기 버튼 클릭 시 처리 이벤트 */
				/*  $("#insertFormBtn").click(function(){
					 if(member != null){
							
						 location.href = "/board/qna/writeForm";
					}
					
				});  */
				
				/* 글쓰기 버튼 클릭 시 글쓰기 폼으로 이동 */
				 $("#insertFormBtn").click(function(){
					/* 로그인 유효성 체크 */
					if(${member == null}){
						alert("회원만 작성할 수 있습니다.");
						return;
					}else{
						location.href = "/board/qna/writeForm";
					}
				}); 
				
				/* 나의문의찾기 버튼 클릭 시 처리 이벤트 */
				/* $("#mySearchBtn").click(function(){
					location.href = "/board/qna/writeForm";
				}); */
				
				/* 제목 클릭 시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					let writer = $(this).parents("tr").attr("data-nick");
					<%
						MemberVO member = (MemberVO)session.getAttribute("member");
						String m_nick = null;
						if(member != null){
							 m_nick = member.getM_nick();	
						}
					%>
					let nick = "<%= m_nick %>";
					
					console.log(nick);
					console.log(writer);
					
					if (writer != nick){
						alert("작성자만 조회할 수 있습니다.");
					}else{
						let q_num = $(this).parents("tr").attr("data-num");
						$("#q_num").val(q_num);
						console.log("글번호 : " + q_num);
						// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
						$("#detailForm").attr({
							"method":"get",
							"action":"/board/qna/boardDetail"
						});
						$("#detailForm").submit();
					}
					
					
					
					// form 생성하지 않았을 때
// 					location.href="/board/boardDetail?b_num=" + b_num;
				});
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
			}); // $ 함수 종료문
			
			/* 검색을 위한 실질적인 처리 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#f_search").attr({
					"method":"get",
					"action":"/board/qna/boardList"
				});
				$("#f_search").submit();
			}
		</script>
	</head>
	<body>
		<div class="contentContainer container">
<!-- 			<div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div> -->
			<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="q_num" name="q_num" />
			</form>
			
			<%-- ============ 리스트 시작 ============ --%>
			<div id="boardList" class="table-height">
				<table summary="QNA 게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="q_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-1">카테고리</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="b_date" class="text-left col-md-1">작성일</th>
							<!-- <th class="text-center col-md-1">조회수</th> -->
							
							<th class="text-center col-md-2">문의상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty boardList}">
							<c:forEach var="board" items="${boardList}" varStatus="status">
								<tr class="text-center" data-num="${board.q_num}" data-nick="${board.m_id}"> 
									<td>${board.q_num}</td>
									<td class="text-center">${board.q_category}
										
									</td> 
									<td class="goDetail text-center">
										${board.q_title}
										<c:if test="${board.q_replycnt > 0}">
											<span class="reply_count"> [${board.q_replycnt}]</span> <!-- q_replycnt -->
										</c:if>
									</td>
									
									<td class="name">${board.m_id}</td> 
									<td class="text-left">${board.q_date}</td>
									<td class="text-center">${board.q_status}
									
									</td>
									<%-- <td class="text-center">${board.q_readcnt}</td> --%>
									<%-- <c:if test="${not empty boardFree.f_file}">
										&nbsp;<img src="/resources/images/common/haveimg.png" style="margin-bottom: 0px; vertical-align: middle;"/>
									</c:if> --%>
										
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
			</div>
			<%-- ============ 리스트 종료 ============ --%>
			
			<%-- ============ 글쓰기 버튼 출력 시작 ============ --%>
			<div class="contentBtn text-right">
				<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success">
				<!-- <input type="button" value="나의 문의 찾기" id="mySearchBtn" class="btn btn-success"> -->
			</div>
			<%-- ============ 글쓰기 버튼 출력 종료 ============ --%>
			
			<%-- ============ 검색기능 시작(수정예정) ============ --%>
			<div id="boardSearch" class="text-center">
				<form id="f_search" name="f_search" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="q_title">제목</option>
							<option value="q_content">내용</option>
							<option value="m_id">작성자</option>
						</select>
						
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" class="btn btn-success">
						
					</div>
				</form>
			</div>
		
			<%-- ============ 검색기능 종료 ============ --%>
			
			
			
			<%-- ============ 페이징 출력 시작 ============ 
			<div class="text-center">
				<ul class="pagination">
					<!--이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1}">Previous</a>
						</li>
					</c:if>
					
					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage + 1}">Next</a>
						</li>
					</c:if>
				</ul>
			</div> --%>
			
			
			<!-- 페이징 처리를 커스텀태그(pagination)를 정의  -->
			<tag:pagination pageNum="${pageMaker.cvo.pageNum}" amount="${pageMaker.cvo.amount}"
			startPage="${pageMaker.startPage}" endPage="${pageMaker.endPage}"
			prev="${pageMaker.prev}" next="${pageMaker.next}" />
			 
			 
			
			
		</div>
	</body>
</html>