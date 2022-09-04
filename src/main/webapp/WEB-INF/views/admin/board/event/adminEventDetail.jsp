<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		
		<script type="text/javascript">
		$(function(){	
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#adminEventListBtn").click(function(){
				location.href="/admin/board/event/adminEventList";
			});
			/* 수정폼 출력 */
			$("#adminEventUpdateBtn").click(function(){
				location.href="/admin/board/event/adminEventUpdate?e_num="+${Detail.e_num};
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body style="padding-top: 0px">
		<div class="contentContainer container">
			<form name="e_data" id="e_data">
				<input type="hidden" id="e_num" name="e_num" value="${Detail.e_num}" />
				<input type="hidden" id="e_file" name="e_file" value="${Detail.e_file}" />
			</form>
		</div>

		<%-- 글 수정 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="adminEventUpdateBtn" class="btn btn-success" />
			<input type="button" value="목록" id="adminEventListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${Detail.ad_id}</td>
						<td class="col-md-3">작성일</td>
						<td class="col-md-3 text-left">${Detail.e_date}</td>
					</tr>
					<tr>
						<td class="col-md-4">제목</td>
						<td colspan="3" class="col-md-8 text-left">${Detail.e_title}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">내용</td>
						<td colspan="3" class="col-md-8 text-left">
							${Detail.e_content}
							<c:if test="${not empty Detail.e_file}">
								<br />
								<br />
								<img src="/dorothyUpload/event/${Detail.e_file}" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- 글 상세 정보 보여주기 종료 --%>
	</body>
</html>