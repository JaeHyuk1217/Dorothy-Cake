<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

		<script type="text/javascript">
			/* let buttonCheck = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수 */
		
			$(function(){
				
				/* 수정 버튼 클릭 시 수정 폼으로 이동 */
				$("#updateFormBtn").click(function(){
					
					$("#f_data").attr({
						"method":"post",
						"action":"/board/qna/updateForm"
					});
					$("#f_data").submit();
				});
				
				/* 삭제 버튼 클릭 시 삭제 */
				$("#boardDeleteBtn").click(function(){
					if(confirm("정말 삭제하시겠습니까?")){
						$.ajax({
							url: "/board/qna/boardDelete",
							type: "post",
							data: $("#f_data").serialize(),
							dataType: "text",
							error: function(){
								alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
							},
							success: function(resultData){
								console.log(resultData);	
								alert("등록한 게시글이 삭제되었습니다.");
								location.href="/board/qna/boardList";	
							}
						});
					}
				});
				/* $("#pwdChk").css("visibility", "hidden");
				
				/* 수정 버튼 클릭 시 처리 이벤트 */
				/* $("#updateFormBtn").click(function(){
					$("#pwdChk").css("visibility", "visible");
					$("#msg").text("작성 시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
					buttonCheck = 1;
				});  */
				
// 				/* 삭제 버튼 클릭 시 처리 이벤트 */
// 				$("#boardDeleteBtn").click(function(){
// 					$("#pwdChk").css("visibility", "visible");
// 					$("#msg").text("작성 시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
// 					buttonCheck = 2;
// 				});
				
				/* 삭제 버튼 클릭 시 댓글 확인 후 처리 이벤트 */
				/* $("#boardDeleteBtn").click(function(){
					if(confirm("정말 삭제하시겠습니까?")){
						$.ajax({
							url: "/board/replyCnt",
							type : "post",
							data : "q_num="+$("#q_num").val(),
							dataType : "text",
							error : function(){
								alert("시스템 오류. 관리자에게 문의 하세요.");
							},
							success : function(resultData){
								if(resultData == 0){ // 댓글이 존재하지 않을 경우
									$("#pwdChk").css("visibility", "visible");
				 					$("#msg").text("작성 시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
				 					buttonCheck = 2;
								}else { // 댓글이 존재하는 경우
									alert("댓글 존재 시 게시물을 삭제할 수 없습니다.\n댓글 삭제 후 다시 확인해 주세요.");
									return;
							}
						}
					});
				}); */
						
				/* 비밀번호 입력 양식 enter 제거 */
				/* $("#q_pwd").bind("keydown", function(event){
					if(event.keyCode === 13){ // 0 == "0"(값만 비교)  0 === "0"(자료형도 비교)
						event.preventDefault();
					}
				}); */
				
				/* 비밀번호 확인 버튼 클릭 시 처리 이벤트 */
				/* $("#pwdBtn").click(function(){
					boardPwdConfirm();
				});
				 */
				/* 글쓰기 버튼 클릭 시 처리 이벤트 */
				/* $("#insertFormBtn").click(function(){
					location.href="/member/board/qna/writeForm"
				}); */
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					location.href="/board/qna/boardList"
				});
			}); // $ 함수 종료
			
			/* 비밀번호 확인 버튼 클릭 시 실질적인 처리 함수 */
			/* function boardPwdConfirm(){
				//if(!chkData("#b_pwd", "비밀번호를")) return;
				if(!formCheck("#q_pwd", "#msg", "비밀번호를")) return;
				else{
					$.ajax({
						url : "/board/pwdConfirm", // 전송 url
						type : "post", // 전송 시 method 방식
						data : $("#f_pwd").serialize(), // 폼 전체 데이터 전송
						dataType : "text",
						error : function(){ // 실행 시 오류가 발생하였을 경우
							alert("시스템 오류입니다. 관리자에게 문의 하세요.");
						},
						success : function(resultData){
							let goUrl = ""; // 이동할 경로를 저장할 변수
							if(resultData == "실패"){ // 일치하지 않는 경우
								$("#msg").text("작성 시 입력한 비밀번호가 일치하지 않습니다.").css("color", "red");
								$("#b_pwd").select();
							}else if(resultData == "성공"){ // 일치할 경우
								$("#msg").text("");
								if(buttonCheck == 1){ // 수정버튼 클릭 시 
									goUrl = "/board/updateForm";
									$("#f_data").attr("action", goUrl);
									$("#f_data").submit();
								}else if(buttonCheck == 2){ // 삭제버튼 클릭 시
									if(confirm("정말 삭제하시겠습니까?")){
										goUrl = "/board/boardDelete";
										$("#f_data").attr("action", goUrl);
										$("#f_data").submit();
									}
								}
							}
						}
					});
				}
			} */
		</script>
	</head>
	<body>
		<div class="contentContainer container">
 			<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 상세보기</h3></div> -->

			<form name="f_data" id="f_data" method="post">
				<input type="hidden" id="q_num" name="q_num" value="${detail.q_num}" />
				<input type="hidden" id= "q_file"name="q_file" value="${detail.q_file}" />
				<input type="hidden" id="q_replycnt" name="q_replycnt" value="${detail.q_replycnt}" />
			</form>
		</div>
		
		<%-- ========= 비밀번호 확인 버튼 및 버튼 추가 시작 ========= --%>
		<%-- <div id="boardPwdBut" class="row text-center">
			<div id="pwdChk" class="authArea col-md-8 text-left">
				<form name="f_pwd" id="f_pwd" class="form-inline">
					<input type="hidden" name="q_num" id="q_num" value="${detail.q_num}" />
					<label for="q_pwd" id="q_pwd">비밀번호 : </label>
					<input type="password" name="q_pwd" id="q_pwd" class="form-control" />
					
					<button type="button" id="pwdBtn" class="btn btn-default">확인</button>
					<span id="msg"></span>
				</form>
			</div> --%>
			<%-- ========= 비밀번호 확인 버튼 및 버튼 추가 종료 ========= --%>
			
			<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
			<div class="btnArea text-right" style="margin-bottom: 5px">
				
				<input type="button" value="수정" id="updateFormBtn" class="btn btn-success" />
				<input type="button" value="삭제" id="boardDeleteBtn" class="btn btn-success" />
				<input type="button" value="목록" id="boardListBtn" class="btn btn-success" />
			</div>
		
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
			
			
			<%-- ========= 상세 정보 보여주기 시작 ========= --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${detail.m_id}</td>
						<td class="col-md-3">작성일</td>
						<td class="col-md-3 text-left">${detail.q_date}</td>
					</tr>
					<tr>
						<td class="col-md-4">제목</td>
						<td colspan="3" class="col-md-8 text-left">${detail.q_title} 
						(조회수 : ${detail.q_readcnt})</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">내용</td>
						<td colspan="3" class="col-md-8 text-left">
						${detail.q_content}
						<c:if test="${not empty detail.q_file}">
							<br />
							<br />
							<img src="/dorothyUpload/qna/${detail.q_file}" />
						</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- ========= 상세 정보 보여주기 종료 ========= --%>
		<jsp:include page="reply.jsp" />
		<%-- <jsp:include page="boardQnaReply.jsp"></jsp:include> --%>
	</body>
</html>