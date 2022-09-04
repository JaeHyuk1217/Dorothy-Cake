<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		
		<script type="text/javascript">
			$(function(){
				
				/* 저장 버튼 클릭 시 처리 이벤트 */
				$("#boardInsertBtn").click(function(){
					// 입력값 체크
					
					if(!chkData("#q_title", "제목을")) return;
					else if(!chkData("#q_content", "작성할 내용을")) return;
					
					else {
						if($("#file").val() != ""){
							if(!chkFile("#file")) return;
						}
						
						// 작성자 아이디 할당
						/* $("#m_id").val("abc123");  */
						
						$("#f_writeForm").attr({
							"method":"post",
							"enctype":"multipart/form-data", // enctype 속성의 기본값은 "application/x-www-form-urlcencoded". POST 방식 폼 전송에 기본값으로 사용
							"action":"/board/qna/boardInsert" 
						});
						$("#f_writeForm").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 처리 이벤트 */
				$("#boardCancelBtn").click(function(){
					$("#f_writeForm").each(function(){
						this.reset();
					});
// 					$("#f_writeForm")[0].reset();
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					location.href = "/board/qna/boardList"
				});
			}); // $ 함수 종료
		</script>
	</head>
	<body>
		<div class="contentContainer container">
<!-- 			<div class="contentTit page-header"><h3 class="text-center">게시판 글작성</h3></div> -->
			
			<div class="contentTB text-center">
				<form id="f_writeForm" name="f_writeForm" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							
							
							<tr>
								<td>카테고리</td>
								<td class="text-left">
									<div class="category_select">
										<select class="tune" id="q_category" name="q_category" >
											<option value="상품"  >상품</option
											><option value="배송"  >배송</option>
											<option value="반품/환불"  >반품/환불</option>
											<option value="교환/변경"  >교환/변경</option>
											<option value="기타"  >기타</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td class="text-left">
									<!-- 로그인 한 사용자의 닉네임 받아오기 -->
									${member.m_nick}
									<input type="hidden" id="m_id" name="m_id" value = "${member.m_id}" />
								</td>
							</tr>
							<!-- <tr>
								<td>상품선택</td>
								<td>
									<div class="board_goods_select">
										<span class="js_selected_info_text">선택된 상품이 없습니다.</span>
										<a href="#addGoodsLayer" title="상품선택" class="btn_goods_select btn_open_layer"> 상품선택 </a>
										<div id="selectGoodsBox">
										</div>
										//goods_select_item
									</div>
									//board_goods_select
								</td>
							</tr> -->
							<tr>
								<td>글제목</td>
								<td class="text-left">
									<input type="text" id="q_title" name="q_title" class="form-control" />
								</td>
							</tr>
							<tr>
								<td>글내용</td>
								<td class="text-left">
									<textarea rows="8" id="q_content" name="q_content" class="form-control"></textarea>
								</td>
							</tr>
							<tr>	
								<td>이미지파일첨부</td>
								<td class="text-left"><input type="file" id="file" name="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="저장" id="boardInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="boardCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="boardListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>