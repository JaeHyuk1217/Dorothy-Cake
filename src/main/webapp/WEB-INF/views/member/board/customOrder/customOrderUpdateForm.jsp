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
						if($("#mfile").val()!="") {
							if (!chkFile($("#mfile"))) return;
						}
						$("#customOrderUpdate").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/board/customOrder/CustomOrderUpdate"
						});
						$("#customOrderUpdate").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 처리 이벤트 */
				$("#customOrderCancelBtn").click(function(){
					$("#customOrderUpdate").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#customOrderListBtn").click(function(){
					if(confirm("목록으로 이동하시겠습니까?")){
						location.href="/board/customOrder/customOrderList";
					}
				});
				
			});
		</script>
	</head>
	<body>
	<div class="contentContainer container">
		<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 글수정</h3></div> -->

		<div class="contentTB text-center">
			<form id="customOrderUpdate" name="customOrderUpdate">
				<input type="hidden" id="c_num" name="c_num" value="${updateData.c_num}" />
				<input type="hidden" id="c_file" name="c_file" value="${updateData.c_file}" />
				
				<table class="table table-bordered">
					<colgroup>
							<col width="20%" />
							<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<td>글번호</td>
							<td colspan="3" class="text-left">${updateData.c_num}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="3" class="text-left">${updateData.m_id}</td>
						</tr>
						<tr>
							<td>제목</td>
							<td colspan="3" class="text-left">
								<input type="text" class="form-control" id="c_title" name="c_title" value="${updateData.c_title}" />
							</td>
						</tr>
						<tr>
							<td>원하는 수령일</td>
							<td colspan="3" class="text-left">
								<input type="date" class="form-control" id="c_receiptdate" name="c_receiptdate" value="${updateData.c_receiptdate}" />
							</td>
						</tr>
						<tr>
							<td>수량</td>
							<td colspan="3" class="text-left">
								<input type="number" id="c_amount" name="c_amount" class="col-md-3 text-left" min="1" value="${updateData.c_amount}"/>
							</td>
						</tr>
						<tr>
							<td>사이즈옵션</td>
							<td colspan="3" class="text-left">
								<select id="c_size" name="c_size" class="form-control">
									<option value="1">1호</option>
									<option value="2">2호</option>
									<option value="3">3호</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>추가구성품</td>
							<td colspan="3" class="text-left">
								<select id="c_etc" name="c_etc">
									<option value="일반초" >일반초</option>
									<option value="숫자초" >숫자초</option>
									<option value="캐릭터초" >캐릭터초</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>디저트종류</td>
							<td colspan="3" class="text-left">
								<select id="c_dessert" name="c_dessert">
									<option value="쿠키">쿠키</option>
									<option value="마카롱">마카롱</option>
									<option value="초콜릿">초콜릿</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>주문사항</td>
							<td colspan="3" class="text-left">
								<textarea rows="8" id="c_content" name="c_content" class="form-control">${updateData.c_content}</textarea>
							</td>
						</tr>
						<tr>
							<td>파일첨부</td>
							<td colspan="3" class="text-left">
								<input type="file" name="mfile" id="mfile" value="${updateData.c_file}" />
							</td>
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