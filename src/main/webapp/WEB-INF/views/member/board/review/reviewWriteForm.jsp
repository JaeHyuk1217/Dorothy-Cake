<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 등록 버튼 클릭 시 글 등록 */
				$("#reviewInsertBtn").click(function(){
					// 입력값 유효성 체크
					if(!chkData("#r_title", "제목을")) return;
					else if(!chkData("#r_content", "내용을")) return;
					else {
						if($("#r_file").val() != null){
							if(!chkFile("#r_file")) return;
						}
						
						$("#reviewWrite").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/board/review/boardReviewInsert"
						});
						
						$("#reviewWrite").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 폼 리셋 */
				$("#reviewCancelBtn").click(function(){
					$("#reviewWrite").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 글 목록으로 이동*/
				$("#reviewListBtn").click(function(){
					if(confirm("목록으로 이동하시겠습니까?")){
						location.href="/board/review/boardReviewList";
					}
				});
			}); // $ 함수 종료
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="reviewWrite" name="reviewWrite" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>작성자</td>
								<td class="text-left">
									${member.m_name}
									<!-- 로그인 한 사용자의 아이디 받아오기 -->
									<input type="hidden" id="m_id" name="m_id" value = "${member.m_id}" />
								</td>
							</tr>
							<tr>
								<td>제목</td>
								<td class="text-left">
									<input type="text" id="r_title" name="r_title" class="form-control" />
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td class="text-left">
									<textarea rows="8" id="r_content" name="r_content" class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<td>이미지파일첨부</td>
								<td class="text-left"><input type="file" id="file" name="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="등록" id="reviewInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="reviewCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="reviewListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>