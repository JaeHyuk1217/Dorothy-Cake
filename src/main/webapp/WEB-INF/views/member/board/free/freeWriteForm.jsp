<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 등록 버튼 클릭 시 글 등록 */
				$("#freeInsertBtn").click(function(){
					// 입력값 유효성 체크
					if(!chkData("#f_title", "제목을")) return;
					else if(!chkData("#f_content", "내용을")) return;
					else {
						if($("#f_file").val() != null){
							if(!chkFile("#f_file")) return;
						}
						
						$("#freeWrite").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/board/free/boardFreeInsert"
						});
						
						$("#freeWrite").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 폼 리셋 */
				$("#freeCancelBtn").click(function(){
					$("#freeWrite").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 글 목록으로 이동*/
				$("#boardFreeListBtn").click(function(){
					if(confirm("목록으로 이동하시겠습니까?")){
						location.href="/board/free/boardFreeList";
					}
				});
			}); // $ 함수 종료
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="freeWrite" name="freeWrite" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>작성자</td>
								<td class="text-left">
									${member.m_nick}
									<input type="hidden" id="m_id" name="m_id" value = "${member.m_id}" />
								</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td class="text-left">
									<input type="text" id="f_title" name="f_title" class="form-control" />
								</td>
							</tr>
							<tr>
								<td>글내용</td>
								<td class="text-left">
									<textarea rows="8" id="f_content" name="f_content" class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<td>이미지파일첨부</td>
								<td class="text-left"><input type="file" id="file" name="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="등록" id="freeInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="freeCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="boardFreeListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>