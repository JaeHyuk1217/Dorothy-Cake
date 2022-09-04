<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<script type="text/javascript">
			$(function(){
				/* 수정 버튼 클릭시 처리 이벤트 */
				$("#adminEventUpdateBtn").click(function(){
					//입력값 체크
					if(!chkData("#e_title", "제목을"))return;
					else if(!chkData("#e_content", "작성할 내용을")) return;
					else{
						if($("#file").val()!=""){
							if(!chkFile($("#file"))) return;
						}
						$("#eventUpdate").attr({
							"method":"post",
							"enctype":"multipart/form-data",// 이부분빠지면 파일첨부 불가.
							"action":"/admin/board/event/eventUpdate"
						});
						$("#eventUpdate").submit();
					}
				});
				
				/* 취소 버튼 클릭시 처리 이벤트 */
				$("#eventCancelBtn").click(function(){
					$("#eventUpdate").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭시 처리 이벤트 */
				$("#adminEventListBtn").click(function(){
					location.href = "/admin/board/event/adminEventList";
				});
			});
		</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
			<form id= "eventUpdate" name = "eventUpdate" class="form-horizontal">
					<input type = "hidden" name = "e_num" id="e_num" value ="${updateData.e_num}" />
					<input type = "hidden" name = "e_file" id="e_file" value ="${updateData.e_file}" />
					<input type = "hidden" name = "e_thumb" id="e_thumb" value ="${updateData.e_thumb}" />
					
					<table class = "table table-bordered">
						<tbody>
							<tr>
								<td class="col-md-3">글번호</td>
								<td class="text-left col-md-3">${updateData.e_num}</td>
								<td class="col-md-3">작성일</td>
								<td class="text-left col-md-3">${updateData.e_date}</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3" class=text-left>${updateData.ad_id}</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td colspan="3" class="text-left">
									<input type = "text" name="e_title" id="e_title" value="${updateData.e_title}" class="form-control"/>
								</td>
							</tr>
							<tr class="table-tr-height">
								<td>글내용</td>
								<td colspan="3">
									<textarea name = "e_content" id = "e_content" class="form-control" rows="8">${updateData.e_content}</textarea>
								</td>
							</tr>
							<tr>
								<td>이미지파일첨부</td>
								<td colspan="3" class="text-left"><input type="file" id="file" name="file"/></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="text-right">
						<input type="button" value="수정" id="adminEventUpdateBtn" class="btn btn-success" />
						<input type="button" value="취소" id="eventCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="adminEventListBtn" class="btn btn-success" />
					</div>
		</div>
	</body>
</html>