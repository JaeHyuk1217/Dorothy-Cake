<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript">
		$(function(){
			
			/* 수정 버튼 클릭 시 수정 폼으로 이동 */
			$("#updateFormBtn").click(function(){
				$("#r_data").attr({
					"method":"post",
					"action":"/board/review/reviewUpdateForm"
				});
				$("#r_data").submit();
			});
			
			/* 삭제 버튼 클릭 시 삭제 */
			$("#boardReviewDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "/board/review/boardReviewDelete",
						type: "post",
						data: $("#r_data").serialize(),
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							alert("등록한 게시글이 삭제되었습니다.");
							location.href="/board/review/boardReviewList";	
						}
					});
				}
			});
			
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#boardReviewListBtn").click(function(){
				location.href="/board/review/boardReviewList";
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form name="r_data" id="r_data">
				<input type="hidden" id="r_num" name="r_num" value="${brDetail.r_num}" />
				<input type="hidden" id="r_file" name="r_file" value="${brDetail.r_file}" />
				<input type="hidden" id="r_thumbnail" name="r_thumbnail" value="${brDetail.r_thumbnail}" />
				<input type="hidden" id="r_replycnt" name="r_replycnt" value="${brDetail.r_replycnt}" />
			</form>
		</div>

		<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="updateFormBtn" class="btn btn-success" />
			<input type="button" value="삭제" id="boardReviewDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="boardReviewListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${brDetail.m_id}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">내용</td>
						<td colspan="3" class="col-md-8 text-left">
							${brDetail.r_content}
							<c:if test="${not empty brDetail.r_file}">
								<br />
								<br />
								<img src="/dorothyUpload/review/${brDetail.r_file}" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- 글 상세 정보 보여주기 종료 --%>
		<jsp:include page="boardReviewReply.jsp"></jsp:include>
</body>
</html>