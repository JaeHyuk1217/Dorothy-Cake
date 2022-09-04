<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript">
		$(function(){
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#eventListBtn").click(function(){
				location.href="/member/event/eventList";
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form name="e_data" id="e_data">
				<input type="hidden" id="e_num" name="e_num" value="${detail.e_num}" />
				<input type="hidden" id="e_file" name="e_file" value="${detail.e_file}" />
				<input type="hidden" id="e_thumb" name="e_thumb" value="${detail.e_thumb}" />

			</form>
		</div>
		<%--목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="목록" id="eventListBtn" class="btn btn-success" />
		</div>
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">도로시케이크</td>
						<td class="col-md-3">작성일</td>
						<td class="col-md-3 text-left">${detail.e_date}</td>
					</tr>
					<tr>
						<td class="col-md-4">제목</td>
						<td colspan="3" class="col-md-8 text-left">${detail.e_title}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">내용</td>
						<td colspan="3" class="col-md-8 text-left">
							${detail.e_content} 
							<c:if test="${not empty detail.e_file}">
								<br />
								<br />
								<img src="/dorothyUpload/event/${detail.e_file}" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</body>
</html>