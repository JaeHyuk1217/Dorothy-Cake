<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<script type="text/javascript">
			$(function(){
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word = "<c:out value='${data.keyword}' />";
				let value = "";
				if(word != ""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />");
					
					if($("#search").val() != 'e_content'){
					if($("#search").val() == 'e_title') value = "#list tr td.goDetail";
						
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word, 'gi');
							$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
						});
					}
				}
				
				
				/* 제목 클릭 시 상세 페이지 이동 */
				$(".goDetail").click(function(){
					let e_num = $(this).parents("tr").attr("data-num");
					$("#e_num").val(e_num);
					$("#detailForm").attr({
						"method":"get",
						"action":"/admin/board/event/adminEventDetail"
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
							url: "/admin/board/event/deleteAll",
							type: "get",
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
				
				/* 글쓰기 버튼 클릭 시 글쓰기 폼으로 이동 */
				$("#insertFormBtn").click(function(){
					/* 로그인 유효성 체크
					if(){
						alert("회원만 작성할 수 있습니다.");
					}
					*/
					
					location.href="/admin/board/event/adminEventWrite";
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
					$("#eventSearch").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			}); // $ 함수 종료
			
			/* 실질적으로 검색을 처리하는 함수 */
			function goPage(){
				if($("#search").val() == "all"){
					$("#keyword").val("");
				}
				$("#eventSearch").attr({
					"method":"get",
					"action":"/admin/board/event/adminEventList"
				});
				$("#eventSearch").submit();
			}
		</script>
	<body style="padding-top: 0px">
		<div class="contentContainer container">
			<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="e_num" name="e_num" />
			</form>
			
			<%-- ==================== 리스트 시작 ================= --%>
			<div class="table-responsive table-height">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="text-center col-md-1"><input type="checkbox" id="allCheck"></th>	
							<th class="text-center col-md-1">글번호</th>
							<th class="text-center col-md-2">글제목</th>
							<th class="text-center col-md-1">작성일</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty adminEventList}">
								<c:forEach var= "adminEventList" items="${adminEventList}" varStatus="status">
									<tr class="text-center" data-num="${adminEventList.e_num}">
										<td>
											<input type="checkbox" name="deleteCheck" value="${adminEventList.e_num}">
										</td>
										<td>${adminEventList.e_num}</td>
										<td class = "goDetail tal">${adminEventList.e_title}</td>
										<td>${adminEventList.e_date}</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
				<%--==================== 글쓰기 버튼 출력 시작 ==================== --%>
				<div class="contentBtn text-right">
					<input type= "button" value="글쓰기" id="insertFormBtn" class="btn btn-success">
					<input type= "button" value="삭제" id="deleteFormBtn" class="btn btn-success">
				</div>
				<%--==================== 글쓰기 버튼 출력 종료 ==================== --%>
				
				<%-- 검색 기능 시작 --%>
				<div id="adminEventSearch" class="text-center">
					<form id="eventSearch" name="memberSearch" class="form-inline">
						<%-- 페이징 처리를 위한 파라미터 --%>
						<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="e_title">제목</option>
								<option value="e_content">내용</option>
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
		</div>
	</body>
			
			
			<%--==================== 리스트 종료 ==================== --%>