<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<script type="text/javascript">
		$(function(){
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#boardNoticeListBtn").click(function(){
				location.href="/board/notice/boardNoticeList";
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form name="n_data" id="n_data">
				<input type="hidden" id="n_num" name="n_num" value="${bnDetail.n_num}" />
				<input type="hidden" id="n_file" name="n_file" value="${bnDetail.n_file}" />
			</form>
		</div>
	
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="목록" id="boardNoticeListBtn" class="btn btn-success" />
		</div>
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-2">작성자</td>
						<td class="col-md-3 text-left">도로시케이크</td>
						<td class="col-md-2">작성일</td>
						<td class="col-md-3 text-left">${bnDetail.n_date}</td>
					</tr>
					<tr>
						<td class="col-md-2">제목</td>
						<td colspan="3" class="col-md-8 text-left">${bnDetail.n_title}
							(조회수 : ${bnDetail.n_readcnt})</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-2">내용</td>
						<td colspan="3" class="col-md-8 text-left">
							${bnDetail.n_content}
							<c:if test="${not empty bnDetail.n_file}">
								<br />
								<br />
								<img src="/dorothyUpload/notice/${bnDetail.n_file}" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</body>
</html>