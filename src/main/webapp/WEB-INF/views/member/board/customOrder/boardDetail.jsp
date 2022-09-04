<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript">
		$(function(){
			
			/* 수정 버튼 클릭 시 수정 폼으로 이동 */
			$("#customOrderupdateFormBtn").click(function(){
				// 나중에 사용자 제어 추가!
				$("#c_data").attr({
					"method":"post",
					"action":"/board/customOrder/updateForm"
				});
				$("#c_data").submit();
			});
			
			/* 삭제 버튼 클릭 시 삭제 */
			$("#customOrderDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "/board/customOrder/customOrderDelete",
						type: "post",
						data: $("#c_data").serialize(),
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							console.log(resultData);	
							alert("등록한 게시글이 삭제되었습니다.");
							location.href="/board/customOrder/boardList";	
						}
					});
				}
			});
			
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#customOrderListBtn").click(function(){
				location.href="/board/customOrder/boardList";
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form name="c_data" id="c_data">
				<input type="hidden" id="c_num" name="f_num" value="${coDetail.c_num}" />
				<%-- <input type="hidden" id="c_file" name="f_file" value="${bfDetail.f_file}" />
				<input type="hidden" id="c_replycnt" name="f_replycnt" value="${bfDetail.f_replycnt}" /> --%>
			</form>
		</div>

		<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="customOrderupdateFormBtn" class="btn btn-success" />
			<input type="button" value="삭제" id="customOrderDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="customOrderListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${coDetail.m_id}</td>
					</tr>
					<tr>
						<td class="col-md-4">제목</td>
						<td colspan="3" class="col-md-8 text-left">${coDetail.c_title}
							<%-- (조회수 : ${bfDetail.f_readcnt}) --%></td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">내용</td>
						<td colspan="3" class="col-md-8 text-left">
							${coDetail.c_content}
							<%-- <c:if test="${not empty bfDetail.f_file}">
								<br />
								<br />
								<img src="/dorothyUpload/board/free/${bfDetail.f_file}" />
							</c:if> --%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- 글 상세 정보 보여주기 종료 --%>
		<jsp:include page="reply.jsp"></jsp:include> 
</body>
</html>