<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 수정 버튼 클릭 시 처리 이벤트 */
				$("#boardUpdateBtn").click(function(){
					// 입력값 체크
					if(!chkData("#q_title", "제목을")) return;
					else if(!chkData("#q_content", "작성할 내용을")) return;
					else {
						if($("#file").val() != ""){
							if(!chkFile("#file")) return;
						}
						
						$("#f_updateForm").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/board/qna/boardUpdate"
						});
						
						$("#f_updateForm").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 처리 이벤트 */
				$("#boardCancelBtn").click(function(){
					$("#f_updateForm").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					location.href="/board/qna/boardList";
				});
			}); // $ 함수 종료
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="f_updateForm" name="f_updateForm" class="form-horizontal">
					<input type="hidden" id="q_num" name="q_num" value="${updateData.q_num}" />
					<input type="hidden" id="q_file" name="q_file" value="${updateData.q_file}" />
					
					
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="col-md-3">글번호</td>
								<td class="text-left">${updateData.q_num}</td>
								<td class="col-md-3">작성일</td>
								<td class="text-left">${updateData.q_date}</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3" class="text-left">${updateData.m_id}</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td colspan="3" class="text-left">
									<input type="text" name="q_title" id="q_title" value="${updateData.q_title}" class="form-control" />
								</td>
							</tr>
							<tr class="table-tr-height">
								<td>내용</td>
								<td colspan="3" class="text-left">
									<textarea name="q_content" id="q_content" class="form-control" rows="8">${updateData.q_content}</textarea>
								</td>
							</tr>
							<!-- <tr class="form-inline">
								<td>비밀번호</td>
								<td colspan="3" class="text-left">
									<input type="password" name="q_pwd" id="q_pwd" class="form-control" maxlength="18" />
									<label>수정할 비밀번호를 입력해 주세요.</label>
								</td>
							</tr> -->
							<tr>
								<td>이미지파일첨부</td>
								<td colspan="3" class="text-left"><input type="file" name="file" id="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="수정" id="boardUpdateBtn" class="btn btn-success" />
						<input type="button" value="취소" id="boardCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="boardListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>