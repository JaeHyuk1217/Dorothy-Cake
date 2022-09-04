<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 등록 버튼 클릭 시 글 등록 */
				$("#eventInsertBtn").click(function(){
					// 입력값 유효성 체크
					if(!chkData("#e_title", "제목을")) return;
					else if(!chkData("#e_content", "내용을")) return;
					else {
						if($("#file").val() != null){
							if(!chkFile("#file")) return;
						}
						
						$("#eventWrite").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/admin/board/eventInsert"
						});
						
						$("#eventWrite").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 폼 리셋 */
				$("#eventCancelBtn").click(function(){
					$("#eventWrite").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 글 목록으로 이동*/
				$("#adminEventListBtn").click(function(){
					if(confirm("목록으로 이동하시겠습니까?")){
						location.href="/admin/board/event/adminEventList";
					}
				});
			}); // $ 함수 종료
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="eventWrite" name="eventWrite" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>작성자</td>
								<td class="text-left">
									<!-- 로그인 한 사용자의 닉네임 받아오기 -->
									<input type="text" id="ad_id" name="ad_id" value="${adminLogin.ad_id}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td class="text-left">
									<input type="text" id="e_title" name="e_title" class="form-control" />
								</td>
							</tr>
							<tr>
								<td>글내용</td>
								<td class="text-left">
									<textarea rows="8" id="e_content" name="e_content" class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<td>이미지파일첨부</td>
								<td class="text-left"><input type="file" id="file" name="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="등록" id="eventInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="eventCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="adminEventListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>