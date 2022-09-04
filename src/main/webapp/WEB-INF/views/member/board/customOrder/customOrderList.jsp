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
					
					if($("#search").val() != 'c_content'){
						if($("#search").val() == 'c_title') value = "#list tr td.goDetail";
						else if($("search").val() == 'm_id') value = "#list tr td.name";
						
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word, 'gi');
							$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
						});
					}
				}
				
				
				/* 제목 클릭 시 상세 페이지 이동 */
				$(".goDetail").click(function(){
					
					let m_nick = $(this).parents("tr").attr("data-name");
					if(${member != null}){
						
						let member_nick = "${member.m_nick}";
						
						//console.log(m_nick);
						//console.log(member_nick);
						
						if(m_nick == member_nick){

							let c_num = $(this).parents("tr").attr("data-num");
							$("#c_num").val(c_num);
							$("#detailForm").attr({
								"method":"get",
								"action":"/board/customOrder/customOrderDetail"
							});
							$("#detailForm").submit();
						} else{
							alert("본인글만 조회할 수 있습니다.");
							return;
						}
					} else {
						alert("본인글만 조회할 수 있습니다.");
						return;
					}
				});
				
				/* 글쓰기 버튼 클릭 시 글쓰기 폼으로 이동 */
				$("#insertFormBtn").click(function(){
					/* 로그인 유효성 체크 */
					if(${member == null}){
						alert("회원만 작성할 수 있습니다.");
						return;
					}else{
						location.href="/board/customOrder/customOrderWriteForm";
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
					$("#customOrderSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			}); // $ 함수 종료
			
			/* 실질적으로 검색을 처리하는 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#customOrderSearch").attr({
					"method":"get",
					"action":"/board/customOrder/customOrderList"
				});
				$("#customOrderSearch").submit();
			}
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<!-- 상세페이지로 이동을 위한 폼 -->
			<form id="detailForm">
				<input type="hidden" id="c_num" name="c_num" />
			</form>
			
			<!-- 커스텀 제품 주문 게시판 리스트 시작 -->
			<div id="customOrderList" class="table-height">
				<table summary="커스텀 제품 주문 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="f_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th class="text-center col-md-1">문의상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty customOrderList}">
								<c:forEach var="customOrderList" items="${customOrderList}" varStatus="status">
									<tr class="text-center" data-num="${customOrderList.c_num}" data-name="${customOrderList.m_nick}">
										<td>${customOrderList.c_num}</td> 
										<td class="goDetail text-left">
											${customOrderList.c_title}
											<c:if test="${customOrderList.c_replycnt > 0}">
												<span class="reply_count">&nbsp;[${customOrderList.c_replycnt}]</span>
											</c:if>
											<c:if test="${not empty customOrderList.c_file}">
												&nbsp;<img src="/resources/images/common/haveimg.png" style="margin-bottom: 0px; vertical-align: middle;"/>
											</c:if>
										</td>
										<td class="name">${customOrderList.m_nick}</td>
										<td class="text-center">${customOrderList.c_inquiry}</td>
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
			<%-- 커스텀 제품 주문 게시판 리스트 종료 --%>
			
			<%-- 검색 기능 시작 --%>
			 <div id="boardCustomOrderSearch" class="text-center">
				<form id="customOrderSearch" name="customOrderSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="c_title">제목</option>
							<option value="c_content">내용</option>
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