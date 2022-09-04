<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		
		<title>Insert title here</title>
		
		<!-- 모바일 웹 페이지 설정 -->
		<link rel="shortcut icon" href="/resources/images/common/icon.png" />
		<link rel="apple-touch-icon" href="/resources/images/common/icon.png" />
		<!-- 모바일 웹 페이지 설정 끝 -->
		
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
						 else if($("#search").val() == 'm_id') value = "#list tr td.name"; 
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
				
				/* 검색 대상이 변경될 때마다 처리 이벤트 */
				/* $("#search").change(function(){
					if($("#search").val() == "all"){
						$("#keyword").val("전체 데이터 조회합니다.");
					}else if($("#search").val() != "all"){
						$("#keyword").val("");
						$("#keyword").focus();
					}
				}); */
				
				/* 검색 버튼 클릭 시 처리 이벤트 */
				$("#searchData").click(function(){
					if($("#search").val() != "all"){
						if(!chkData("#keyword", "검색어를")) return;
					}
					$("#pageNum").val(1);
					goPage();
				});
				
				/* 글쓰기 버튼 클릭 시 처리 이벤트
				$("#insertFormBtn").click(function(){
					location.href = "/board/writeForm";
				}); */
				
				/* 제목 클릭 시 상세 페이지 이동을 위한 처리 이벤트 
				$(".goDetail").click(function(){
					let b_num = $(this).parents("tr").attr("data-num");
					$("#b_num").val(b_num);
					console.log("글번호 : " + b_num);
					// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
					$("#detailForm").attr({
						"method":"get",
						"action":"/board/boardDetail"
					});
					$("#detailForm").submit(); 
					
					// form 생성하지 않았을 때
 					//location.href="/board/boardDetail?b_num=" + b_num;
				}); */
				
				/* 제목 클릭 시 상세 페이지 이동 */
				$(".goDetail").click(function(){
					let q_num = $(this).parents("tr").attr("data-num");
					$("#q_num").val(q_num);
					$("#detailForm").attr({
						"method":"get",
						"action":"/admin/board/qna/boardDetail"
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
							url: "/admin/board/qna/deleteAll",
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
				
				/* 검색 대상이 변경될 때마다 처리 이벤트 */
				/* $("#search").change(function(){
					if($("#search").val()!="q_date"){
						$("dateCheck").hide();
						$("textCheck").show();
						
					}if($("#search").val()=="q_date"){
						$("dateCheck").show();
						$("textCheck").hide();
					}
				}); */
				
				/* 검색 대상 변경될 때마다 처리 이벤트 */
				$("#search").change(function(){
					$("#keyword").val("");
					$("#keyword").focus();		
				});
				
				
				 /* 엑셀다운로드 버튼 클릭 시 처리 이벤트 */
	          /*  $("#excelDownBtn").click(function(){
	            	$("#f_search").attr({
	            		"method":"get",
	            		"action":"/admin/board/boardExcel"
	            	});
	            	$("#f_search").submit();
	            }); */
				
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
					"action":"/admin/board/qna/boardList"
				});
				$("#f_search").submit();
			}
		</script>
	</head>
	<body style="padding-top: 0px">
		
		
			
	<!-- 검색기능 정의 -->
         <div id="boardSearch" class="text-right">
         	<form id="f_search" name="f_search" class="form-inline">
         		<%--페이징 처리를 위한 파라미터 --%>
         		<input type = "hidden" name="pageNum" value="${pageMaker.cvo.pageNum }">
         		<input type = "hidden" name="amount" value="${pageMaker.cvo.amount }">
         		
         		
         		
         		<div class="form-group">
         		     <select id="search" name="search" class="form-control">
         			    <option value="q_title">제목</option>
         				<option value="q_name">작성자</option>
         				<option value="q_content">내용</option>
         				<!-- <option value="q_date">작성일자</option> -->
         			</select>
         		</div>
         		<div class = "form-group" id="textCheck">
         			<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를입력하세요" />
					<input type="button" value="검색" id="searchData" name="searchData" class="btn btn-success" />        		
         		</div>
         		
         		<!-- <div class="form-group" id="dateCheck">
         			<input type="date" name="start_date" id="start_date" placeholder="시작일자" class="form-control">
         			<input type="date" name="end_date" id="end_date" placeholder="종료일자" class="form-control">
         		</div> -->
         			
         			
         			<!-- <button type="button" class="btn-success" id ="allSearchBtn">All Search</button>  -->
         			<!-- <button type="button" class="btn-success" id ="excelDownBtn">Excel Down</button> -->         		
         		
         	</form>
         </div>
         <!-- 검색 기능 종료 -->
         
		
		
		<%-- 상세페이지로 이동을 위한 폼 --%>
			<form id="detailForm">
				<input type="hidden" id="q_num" name="q_num" />
			</form>
<!-- 게시판 리스트 -->
<div id="boardList" class=" table-height">
   <table summary="QNA게시판 리스트" class="table table-striped">
      <thead>
         <tr>
         	<th class="text-center col-md-1"><input type="checkbox" id="allCheck"></th>
			<th class="text-center col-md-1">글번호</th>
			<!-- <th data-value="f_num" class="order text-center col-md-1">글번호</th> -->
			<th class="text-center">카테고리</th>
			<th class="text-center col-md-4">글제목</th>
			<th class="text-center col-md-2">작성자</th>
			<th data-value="f_date" class="order col-md-1">작성일</th>
			<th class="text-center">문의상태</th>
          </tr>
      </thead>
      <tbody id="list" class="table-striped">
         <!-- 데이터 출력 -->
         <c:choose>
            <c:when test="${not empty boardList}">
               <c:forEach var= "board" items="${boardList}" varStatus="status">
                  <tr class="text-center" data-num="${board.q_num}">
                  	<td>
						<input type="checkbox" name="deleteCheck" value="${board.q_num}">
					</td>
                     <td>${count - status.index}</td>
                     <%-- <td>${board.q_num}</td> --%>
                     <td class="text-center">${board.q_category}</td> 
                     <td class="goDetail text-center">
                     	 ${board.q_title}
	                     <c:if test="${board.q_replycnt > 0}">
							<span class="reply_count">&nbsp;[${board.q_replycnt}]</span>
						</c:if>
                     <td class="name">${board.m_id}</td> 
                     <td >${board.q_date}</td>
                     <td class="text-center">${board.q_status}</td>
                   </tr>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <tr>
                  <td colspan="10" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
               </tr>
            </c:otherwise>
         </c:choose>
      </tbody>
   </table>
</div>
<%--==================== 리스트 종료 ==================== --%>

<%-- 삭제 버튼 출력 --%>
			<div class="contentBtn text-left">
				<input type="button" value="선택삭제" id="deleteFormBtn" class="btn btn-success">
			</div>

<%-- 페이징 처리를 커스텀태그(pagination)를 정의 --%>
			<tag:pagination pageNum="${pageMaker.cvo.pageNum}" amount="${pageMaker.cvo.amount}"
			startPage="${pageMaker.startPage}" endPage="${pageMaker.endPage}"
			prev="${pageMaker.prev}" next="${pageMaker.next}" />
	</body>
</html>