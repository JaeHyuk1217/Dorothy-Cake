<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
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
				let c_num = ${customOrderDetail.c_num};
				listAll(c_num);
				
				/* 댓글 등록 처리 */
				$(document).on("click", "#replyCustomOrderInsertBtn", function(){
					let insertUrl = "/admin/replies/customOrder/replyCustomOrderInsert";

					let value = JSON.stringify({
						c_num:c_num,
						ad_id:$("#ad_id").val(),
						rc_content:$("#rc_content").val()
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
							if(${adminLogin == null}){
								alert("로그인 한 관리자만 작성할 수 있습니다."); 
								return false;
							}
							else if(!checkForm("#rc_content", "댓글 내용을")) return false;
						},
						success: function(result){
							if(result == "SUCCESS"){
								alert("댓글이 등록되었습니다.");
								dataReset();
								listAll(c_num);
							}
						}
					});
				});
				
				/* 댓글 삭제 */
				$(document).on("click", ".delBtn > img", function(){
					let rc_num = $(this).parents("div.panel").attr("data-num");
					deleteReply(c_num, rc_num);
				});
				
				/* 댓글 수정 폼 호출 */
				$(document).on("click", ".upBtn > a", function(){
					let panel = $(this).parents("div.panel");
					let rc_num = panel.attr("data-num");
					updateReplyForm(rc_num, panel);
				});
				
				/* 댓글 수정 */
				$(document).on("click", "#replyCustomOrderUpdateBtn", function(){
					let rc_num = $(this).attr("data-num");
					
					$.ajax({
						url: "/replies/customOrder/" + rc_num,
						type: "put",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "PUT"
						},
						data: JSON.stringify({rc_content: $("#rc_content").val()}),
						dataType: "text",
						error: function(xhr, textStatus, errorThrown){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						beforeSend: function(){
							if(!checkForm("#rc_content", "댓글 내용을")) return false;
						},
						success: function(result){
							if(result == "SUCCESS"){
								alert("댓글 수정이 완료되었습니다.");
								dataReset();
								listAll(c_num);
							}
						}
					});
				});
				
			}); // $ 함수 종료
			
			/* 댓글 목록 불러오는 함수 */
			function listAll(c_num){
				$(".reply").detach();
				
				let url = "/admin/replies/customOrder/all/" + c_num;
				
				$.getJSON(url, function(data){
					$(data).each(function(){
						let rc_num = this.rc_num;
						let ad_id = this.ad_id;
						let rc_content = this.rc_content;
						let rc_date = this.rc_date;
						rc_content = rc_content.replace(/(\r\n|\r|\n)/g, "<br />");
						/* console.log(rc_content); */
						template(rc_num, ad_id, rc_content, rc_date);
						
					});
				}).fail(function(){
					alert("댓글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
				});
			}
			
			/* 새로운 글을 화면에 추가하기 위한 함수 */
			function template(rc_num, ad_id, rc_content, rc_date) {
				let $div = $("#replyCustomOrderList");
				
				let $element = $("#item-template").clone().removeAttr("id");
				$element.attr("data-num", rc_num);
				$element.addClass("reply");
				$element.find(".panel-heading > .panel-title > .id").html(ad_id + " 님");
				$element.find(".panel-heading > .panel-title > .date").html(" / " + rc_date);
				
				$element.find(".panel-body").html(rc_content);
				$div.append($element);
			}
			
			/* 입력 폼 초기화 */
			function dataReset(){
				$("#replyCustomOrderForm").each(function(){
					this.reset();
				});
				
				$("#replyCustomOrderForm button[type='button']").removeAttr("data-num");
				$("#replyCustomOrderForm button[type='button']").attr("id", "replyCustomOrderInsertBtn");
			}
			
			/* 댓글 삭제를 위한 함수 */
			function deleteReply(c_num, rc_num){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url : "/replies/customOrder/" + rc_num,
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
								listAll(c_num);
							}
						}
					});
				}
			}
			
			/* 댓글 수정 폼 함수 */
			function updateReplyForm(rc_num, panel){
				let content = panel.find(".panel-body").html();
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, "\r\n");
				$("#rc_content").val(content);
				
				$("#replyCustomOrderForm button[type='button']").attr("id", "replyCustomOrderUpdateBtn");
				$("#replyCustomOrderForm button[type='button']").attr("data-num", rc_num);
			}
			
		</script>
	</head>
	<body>
		<div id="replyContainer">
			<%-- 댓글 입력 화면 --%>
			<form id="replyCustomOrderForm" name="replyCustomOrderForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">작성자</td>
								<td class="col-md-3 text-left">
									<input type="hidden" id="ad_id" name="ad_id" value="${adminLogin.ad_id}" />
									<c:if test="${adminLogin == null}">
										로그인 후 작성할 수 있습니다.
									</c:if>
									<c:if test="${adminLogin != null}">
										${adminLogin.ad_id}
									</c:if>
								</td>
								<td class="col-md-4 text-right">
									<button type="button" id="replyCustomOrderInsertBtn" name="replyCustomOrderInsertBtn" class="btn btn-success">등록</button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea id="rc_content" name="rc_content" rows="3" class="form-control"></textarea>
								</td> 
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<%-- 댓글 입력 화면 끝--%>
			
			<%-- 댓글 목록 영역 --%>
			<div id="replyCustomOrderList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="id"></span>
							<span class="date"></span>
							<span class="upBtn"><a>수정</a></span>
							<span class="delBtn"><img src="/resources/images/common/delete.png" style="display: inline;"/></span>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
			<%-- 댓글 목록 영역 끝--%>
		</div>
	</body>
</html>