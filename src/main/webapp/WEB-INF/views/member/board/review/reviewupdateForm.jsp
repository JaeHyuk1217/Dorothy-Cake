<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<script type="text/javascript">
			$(function(){
				/* 수정 버튼 클릭 시 처리 이벤트 */
				$("#customOrderUpdateBtn").click(function(){
					// 입력값 체크
					if (!chkData("#c_title", "제목을")) return;
					else if (!chkData("#c_content", "작성할 내용을")) return;
					else {
						if($("#file").val()!="") {
							if (!chkFile($("#file"))) return;
						}
						$("#c_updateForm").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/board/customOrder/CustomOrderUpdate"
						});
						$("#c_updateForm").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 처리 이벤트 */
				$("#customOrderCancelBtn").click(function(){
					$("#c_updateForm").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#customOrderListBtn").click(function(){
					location.href="/board/customOrder/customOrderList";
				});
				
			});
		</script>
	</head>
	<body>
	<div class="contentContainer container">
		<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 글수정</h3></div> -->

		<div class="contentTB text-center">
			<form id="c_updateForm" name="c_updateForm">
				<input type="hidden" id="c_num" name="c_num" value="${updateData.c_num}" />
				<input type="hidden" id="c_file" name="c_file" value="${updateData.c_file}" />
				
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td class="col-md-3">글번호</td>
							<td class="col-md-3 text-left">${updateData.c_num}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="3" class="text-left">${updateData.m_id}</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td colspan="3" class="text-left"><input type="text" class="form-control" id="c_title" name="c_title" value="${updateData.c_title}" class="form-control" /></td>
						</tr>
						<tr>
							<td>원하는 수령일</td>
							<td colspan="3" class="text-left"><input type="text" class="form-control" id="c_receiptdate" name="c_receiptdate" value="${updateData.c_receiptdate}" class="form-control" /></td>
						</tr>
						<tr>
							<td>사이즈옵션</td>
							<td colspan="3" class="text-left"><input type="text" class="form-control" id="c_size" name="c_size" value="${updateData.c_size}" class="form-control" /></td>
						</tr>
						<tr>
							<td>추가구성품</td>
							<td colspan="3" class="text-left"><input type="text" class="form-control" id="c_etc" name="c_etc" value="${updateData.c_etc}" class="form-control" /></td>
						</tr>
						<tr>
							<td>디저트종류</td>
							<td colspan="3" class="text-left"><input type="text" class="form-control" id="c_dessert" name="c_dessert" value="${updateData.c_dessert}" class="form-control" /></td>
						</tr>
						<tr class="table-tr-height">
							<td>주문사항</td>
							<td colspan="3" class="col-md-8 text-left"><textarea name="c_content" id="c_content" class="form-control" rows="8">${updateData.c_content}</textarea>
							</td>
						</tr>
						<tr>
							<td>이미지파일첨부</td>
							<td colspan="3" class="text-left"><input type="file" name="file" id="file" /></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

			<div class="contentBtn text-right">
				<input type="button" value="수정" id="customOrderUpdateBtn" class="btn btn-success" /> 
				<input type="button" value="취소" id="customOrderCancelBtn" class="btn btn-success" /> 
				<input type="button" value="목록" id="customOrderListBtn" class="btn btn-success" />
			</div>
		</div>
	</body>
</html>