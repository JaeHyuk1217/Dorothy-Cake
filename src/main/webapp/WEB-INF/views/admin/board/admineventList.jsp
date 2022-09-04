<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<!-- <script type="text/javascript">
			$(function(){
				
				/* 검색 후 검색 대상과 검색 단어 출력 */
				let word="<c:out value='${data.keyword}'/>";
				let value = "";
				if(word!=""){
					$("#keyword").val("<c:out value='${data.keyword}' />");
					$("#search").val("<c:out value='${data.search}' />")
					
					if($("#search").val()!='b_content'){
						//:contains()는 특정 텍스트를 포함한 요소반환
						if($("#search").val()=='b_title') value ="#list tr td.goDetail";
						else if($("#search").val()=='b_name') value ="#list tr td.name";
						console.log($(value+":contains('"+word+"')").html());
						
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word, 'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
						});		
					}
				}
				
				/* 입력 양식 enter 제거*/
				$("#keyword").bind("keydown", function(event){
					if(event.keyCode == 13) {
						event.preventDefault();
					}
				});
				
				/* 검색 대상이 변경될 때 마다 처리 이벤트 */
				$("#search").change(function(){
					if($("#search").val() == "all"){
						$("#keyword").val("전체 데이터 조회합니다.");
					}else if($("#search").val()!="all"){
						$("#keyword").val("");
						$("#keyword").focus();
					}
				});
				
				/* 검색 버튼 클릭시 처리 이벤트 */
				$("#searchData").click(function(){
					if($("#search").val()!="all"){
						if(!chkData("#keyword", "검색어를")) return;
					}
					goPage();
				});
				
				/* 글쓰기 버튼 클릭시 처리 이벤트 */
				$("#insertFormBtn").click(function(){
					location.href = "/board/writeForm";
				});
				
				/* 제목 콜릭시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".goDetail").click(function(){
					let b_num = $(this).parents("tr").attr("data-num");
					$("#b_num").val(b_num);
					console.log("글번호 : "+b_num);
					//상세 페이지로 이동하기위해 form추가 (id : detailForm)
					$("#detailForm").attr({
						"method":"get",
						"action":"/board/boardDetail"
					});
					$("#detailForm").submit();
				});
				
				/* 엑셀 다운로드 버튼 클릭시 처리 이벤트 */
				$("#excelDownBtn").click(function(){
					$("#f_search").attr({
						"method":"get",
						"action":"/admin/board/boardExcel"
					});
					$("#f_search").submit();
				});
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
			});
			
			/* 검색을 위한 실질적인 처리 함수 */
			function goPage(){
				$("#f_search").attr({
					"method":"get",
					"action":"/board/boardList"
				});
				$("#f_search").submit();
			}
		</script> -->
	
		<h2 class="sub-header">게시판 리스트</h2>
			
			<%-- ============검색부분 정의=============== --%>
			<div class="well">
				<form class="form-inline" id = "f_search">
					<input type="hidden" name="pageNum" value = "${pageMaker.cvo.pageNum}" />
					<input type="hidden" name="amount" value = "${pageMaker.cvo.amount }" />
						
						<h3><span class= "label label-success">검색조건</span></h3>
						<div class="form-group">
							<select id="search" name="search" class="form-control">
								<option value="b_title">제목</option>
								<option value="b_name">작성자</option>
								<option value="b_content">내용</option>
								<option value="b_date">작성일자</option>
							</select>
						</div>
						<div class="form-group" id="textCheck">
							<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						</div>
						<div class="form-group" id="DataCheck">
							<input type="date" name="start_date" id="start_date" placeholder="시작일자" class="form-control" />
							<input type="date" name="end_date" id="end_date" placeholder="종료일자" class="form-control" />
						</div>
						<button type="button" class="btn btn-success" id="searchBtn">Search</button>
						<button type="button" class="btn btn-success" id="allSearchBtn">All Search</button>
						<button type="button" class="btn btn-success" id="excelDownBtn">Excel Down</button>
				</form>
			</div>
			<%--=============== 검색기능 종료==================  --%>
			<h2 class="sub-header">게시판 리스트</h2>
			
			<%-- ==================== 리스트 시작 ================= --%>
			<div class="table-responsive table-height">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="text-center">글번호</th>
							<th class="text-center">글제목</th>
							<th class="text-center">작성일</th>
							<th class="text-center">작성자</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty boardList}">
								<c:forEach var= "board" items="${boardList}" varStatus="status">
									<tr class="text-center" data-num="${board.b_num}">
										<td>${count - status.index}</td>
										<%--<td>${board.b_num}</td> --%>
										<td class = "goDetail tal">${board.b_title}</td>
										<td>${board.b_date}</td>
										<td class="name">${board.b_name}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<%--==================== 글쓰기 버튼 출력 시작 ==================== --%>
				<div class="contentBtn text-right">
					<input type= "button" value="글쓰기" id="insertFormBtn" class="btn btn-success">
				</div>
				<%--==================== 글쓰기 버튼 출력 종료 ==================== --%>
			</div>
			<%--==================== 리스트 종료 ==================== --%>