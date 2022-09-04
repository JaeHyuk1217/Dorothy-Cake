<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ page import="com.dorothy.member.login.vo.MemberVO" %>
	
		<style type="text/css">
			#item-template{ display: none; }
			textarea { resize: none; }
			.upBtn > a { text-decoration: none; font-size: small; color: black; }
			.upBtn > a:hover{ text-decoration: none; font-size: small; color : red; }
			.delBtn > img { margin-bottom: 0px; vertical-align: middle; height: 10px;}
			
		</style>	
		
		<script type="text/javascript">
			$(function(){
				
				/* 댓글 목록 불러오기 */
				let f_num = ${bfDetail.f_num};
				listAll(f_num);
				
				/* 댓글 등록 처리 */
				$(document).on("click", "#replyFreeInsertBtn", function(){
					let insertUrl = "/replies/free/replyFreeInsert";

					let value = JSON.stringify({
						f_num:f_num,
						m_id:$("#m_id").val(),
						rf_content:$("#rf_content").val()
					});
					
					$.ajax({
						url: insertUrl,
						type: "post",
						headers: {
							"Content-Type":"application/json"
						},
						dataType: "text",
						data: value,
						error: function(xhr, textStatus, errorThrown){
							
						},
						beforeSend: function(){
							if(${member == null}){
								alert("로그인 한 사용자만 작성할 수 있습니다."); 
								return false;
							}
							else if(!checkForm("#rf_content", "댓글 내용을")) return false;
						},
						success: function(result){
							if(result == "SUCCESS"){
								alert("댓글이 등록되었습니다.");
								dataReset();
								listAll(f_num);
							}
						}
					});
				});
				
				/* 댓글 삭제 */
				$(document).on("click", ".delBtn > img", function(){
					let rf_num = $(this).parents("div.panel").attr("data-num");
					deleteReply(f_num, rf_num);
				});
				
				/* 댓글 수정 폼 호출 */
				$(document).on("click", ".upBtn > a", function(){
					let panel = $(this).parents("div.panel");
					let rf_num = panel.attr("data-num");
					updateReplyForm(rf_num, panel);
				});
				
				/* 댓글 수정 */
				$(document).on("click", "#replyFreeUpdateBtn", function(){
					let rf_num = $(this).attr("data-num");
					
					$.ajax({
						url: "/replies/free/" + rf_num,
						type: "put",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "PUT"
						},
						data: JSON.stringify({rf_content: $("#rf_content").val()}),
						dataType: "text",
						error: function(xhr, textStatus, errorThrown){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						beforeSend: function(){
							if(!checkForm("#rf_content", "댓글 내용을")) return false;
						},
						success: function(result){
							if(result == "SUCCESS"){
								alert("댓글 수정이 완료되었습니다.");
								dataReset();
								listAll(f_num);
							}
						}
					});
				});
				
			}); // $ 함수 종료
			
			/* 댓글 목록 불러오는 함수 */
			function listAll(f_num){
				$(".reply").detach();
				
				let url = "/replies/free/all/" + f_num;
				
				$.getJSON(url, function(data){
					$(data).each(function(){
						let rf_num = this.rf_num;
						let m_id = this.m_id;
						let rf_content = this.rf_content;
						let rf_date = this.rf_date;
						rf_content = rf_content.replace(/(\r\n|\r|\n)/g, "<br />");
						template(rf_num, m_id, rf_content, rf_date);
					});
				}).fail(function(){
					alert("댓글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
				});
			}
			
			/* 새로운 글을 화면에 추가하기 위한 함수 */
			function template(rf_num, m_id, rf_content, rf_date) {
				let $div = $("#replyFreeList");
				<%
					MemberVO member = (MemberVO)session.getAttribute("member");
					String m_nick = null;
					if(member != null){
						 m_nick = member.getM_nick();	
					}
				%>
				let nickname = "<%= m_nick %>";
				
				let $element = $("#item-template").clone().removeAttr("id");
				$element.attr("data-num", rf_num);
				$element.addClass("reply");
				$element.find(".panel-heading > .panel-title > .nick").html(m_id + " 님");
				$element.find(".panel-heading > .panel-title > .date").html(" / " + rf_date);
				if(${member == null} || nickname != m_id){
					$element.find(".panel-heading > .panel-title > .upBtn").remove();
					$element.find(".panel-heading > .panel-title > .delBtn").remove();
				}
				$element.find(".panel-body").html(rf_content);
				$div.append($element);
			}
			
			/* 입력 폼 초기화 */
			function dataReset(){
				$("#replyFreeForm").each(function(){
					this.reset();
				});
				
				$("#replyFreeForm button[type='button']").removeAttr("data-num");
				$("#replyFreeForm button[type='button']").attr("id", "replyFreeInsertBtn");
			}
			
			/* 댓글 삭제를 위한 함수 */
			function deleteReply(f_num, rf_num){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url : "/replies/free/" + rf_num,
						type : "delete",
						headers : {
							"X-HTTP-Method-Override" : "DELETE"
						},
						dataType : "text",
						error : function(xhr, textStatus, errorThrown){
							alert("문제가 발생하였습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success : function(result){
							if(result == "SUCCESS"){
								alert("댓글이 삭제되었습니다.");
								listAll(f_num);
							}
						}
					});
				}
			}
			
			/* 댓글 수정 폼 함수 */
			function updateReplyForm(rf_num, panel){
				let content = panel.find(".panel-body").html();
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, "\r\n");
				$("#rf_content").val(content);
				
				$("#replyFreeForm button[type='button']").attr("id", "replyFreeUpdateBtn");
				$("#replyFreeForm button[type='button']").attr("data-num", rf_num);
			}
		</script>
	</head>
	<body>
		<div id="replyContainer">
			<%-- 댓글 입력 화면 --%>
			<form id="replyFreeForm" name="replyFreeForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">작성자</td>
								<td class="col-md-3 text-left">
									<input type="hidden" id="m_id" name="m_id" value="${member.m_id}" />
									<c:if test="${member == null}">
										로그인 후 작성할 수 있습니다.
									</c:if>
									<c:if test="${member != null}">
										${member.m_nick}
									</c:if>
								</td>
								<td class="col-md-4 text-right">
									<button type="button" id="replyFreeInsertBtn" name="replyFreeInsertBtn" class="btn btn-success">등록</button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea id="rf_content" name="rf_content" rows="3" class="form-control"></textarea>
								</td> 
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<%-- 댓글 입력 화면 끝--%>
			
			<%-- 댓글 목록 영역 --%>
			<div id="replyFreeList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="nick"></span>
							<span class="date"></span>
							<span class="upBtn"><a>수정</a></span>
							<span class="delBtn"><img src="/resources/images/common/delete.png" /></span>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
			<%-- 댓글 목록 영역 끝--%>
		</div>
	</body>
</html>