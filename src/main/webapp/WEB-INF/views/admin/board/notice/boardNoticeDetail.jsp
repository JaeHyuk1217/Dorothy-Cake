<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style type="text/css">
			textarea { resize: none; }
			.reply_count { color: red; font-size: small; }
			.required { font-weight: bold; }
		</style>
		
		<script type="text/javascript">
		$(function(){
		
			/* 삭제 버튼 클릭 시 삭제 */
			$("#boardNoticeDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "/admin/board/notice/boardNoticeDelete",
						type: "post",
						data: $("#n_data").serialize(),
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							console.log(resultData);	
							alert("등록한 게시글이 삭제되었습니다.");
							location.href="/admin/board/notice/boardNoticeList";	
						}
					});
				}
			});
			
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#boardNoticeListBtn").click(function(){
				location.href="/admin/board/notice/boardNoticeList";
			});
			
			/* 수정 버튼 클릭 시 수정 폼으로 이동 */
			$("#boardNoticeUpdateBtn").click(function(){
				// 나중에 사용자 제어 추가!
				$("#n_data").attr({
					"method":"post",
					"action":"/admin/board/notice/noticeUpdateForm"
				});
				$("#n_data").submit();
			});
		}); // $ 함수 종료
	</script>
	</head>
	<body style="padding-top: 0px">
		<div class="contentContainer container">
			<form name="n_data" id="n_data">
				<input type="hidden" id="n_num" name="n_num" value="${bnDetail.n_num}" />
				<input type="hidden" id="n_file" name="n_file" value="${bnDetail.n_file}" />
			</form>
		</div>

		<%-- 글 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="boardNoticeUpdateBtn" class="btn btn-success" />
			<input type="button" value="삭제" id="boardNoticeDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="boardNoticeListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-2">작성자</td>
						<td class="col-md-3 text-left">${bnDetail.ad_id}</td>
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