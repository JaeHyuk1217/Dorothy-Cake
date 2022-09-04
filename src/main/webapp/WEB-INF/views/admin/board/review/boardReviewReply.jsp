<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<style type="text/css">
		#item-template{ display: none; }
		textarea { resize: none; }
		.upBtn > a { text-decoration: none; font-size: small; color: black; }
		.upBtn > a:hover{ text-decoration: none; font-size: small; color : red; }
		/* .delBtn > a { text-decoration: none; font-size: small; color: black; }
		.delBtn > a:hover{ text-decoration: none; font-size: small; color : red; } */
		.delBtn > img { margin-bottom: 0px; vertical-align: middle; height: 10px;}
	</style>
	
	<script type="text/javascript">
	$(function(){
		
		/* 댓글 목록 불러오기 */
		let r_num = ${brDetail.r_num};
		listAll(r_num); 
		
		/* 댓글 등록 처리 */
		$(document).on("click", "#replyReviewInsertBtn", function(){
			let insertUrl = "/admin/replies/review/replyReviewInsert";

			let value = JSON.stringify({
				r_num:r_num,
				ad_id:$("#ad_id").val(),
				rr_content:$("#rr_content").val()
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
					else if(!checkForm("#rr_content", "댓글 내용을")) return false;
				},
				success: function(result){
					if(result == "SUCCESS"){
						alert("댓글이 등록되었습니다.");
						dataReset();
						listAll(r_num);
					}
				}
			});
		});
		
		/* 댓글 삭제 */
		$(document).on("click", ".delBtn > img", function(){
			let rr_num = $(this).parents("div.panel").attr("data-num");
			deleteReply(r_num, rr_num);
		});
		
		/* 댓글 수정 폼 호출 */
		$(document).on("click", ".upBtn > a", function(){
			let panel = $(this).parents("div.panel");
			let rr_num = panel.attr("data-num");
			updateReplyForm(rr_num, panel);
		});
		
		/* 댓글 수정 */
		$(document).on("click", "#replyReviewUpdateBtn", function(){
			let rr_num = $(this).attr("data-num");
			
			$.ajax({
				url: "/admin/replies/review/" + rr_num,
				type: "put",
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				data: JSON.stringify({rr_content: $("#rr_content").val()}),
				dataType: "text",
				error: function(xhr, textStatus, errorThrown){
					alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
				},
				beforeSend: function(){
					if(!checkForm("#rr_content", "댓글 내용을")) return false;
				},
				success: function(result){
					if(result == "SUCCESS"){
						alert("댓글 수정이 완료되었습니다.");
						dataReset();
						listAll(r_num);
					}
				}
			});
		});
		
	}); // $ 함수 종료
	
	/* 댓글 목록 불러오는 함수 */
	function listAll(r_num){
		$(".reply").detach();
		
		let url = "/admin/replies/review/all/" + r_num;
		
		$.getJSON(url, function(data){
			$(data).each(function(){
				let rr_num = this.rr_num;
				let ad_id = this.ad_id;
				let rr_content = this.rr_content;
				let rr_date = this.rr_date;
				rr_content = rr_content.replace(/(\r\n|\r|\n)/g, "<br />");
				/* console.log(rr_content); */
				template(rr_num, ad_id, rr_content, rr_date);
				
			});
		}).fail(function(){
			alert("댓글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
		});
	}
	
	/* 새로운 글을 화면에 추가하기 위한 함수 */
	function template(rr_num, ad_id, rr_content, rr_date) {
		let $div = $("#replyReviewList");
		
		let $element = $("#item-template").clone().removeAttr("id");
		$element.attr("data-num", rr_num);
		$element.addClass("reply");
		$element.find(".panel-heading > .panel-title > .id").html(ad_id + " 님");
		$element.find(".panel-heading > .panel-title > .date").html(" / " + rr_date);
		
		$element.find(".panel-body").html(rr_content);
		$div.append($element);
	}
	
	/* 입력 폼 초기화 */
	function dataReset(){
		$("#replyReviewForm").each(function(){
			this.reset();
		});
		
		$("#replyReviewForm button[type='button']").removeAttr("data-num");
		$("#replyReviewForm button[type='button']").attr("id", "replyReviewInsertBtn");
	}
	
	/* 댓글 삭제를 위한 함수 */
	function deleteReply(r_num, rr_num){
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				url : "/admin/replies/review/" + rr_num,
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
						listAll(r_num);
					}
				}
			});
		}
	}
	
	/* 댓글 수정 폼 함수 */
	function updateReplyForm(rr_num, panel){
		let content = panel.find(".panel-body").html();
		content = content.replace(/(<br>|<br\/>|<br \/>)/g, "\r\n");
		$("#rr_content").val(content);
		
		$("#replyReviewForm button[type='button']").attr("id", "replyReviewUpdateBtn");
		$("#replyReviewForm button[type='button']").attr("data-num", rr_num);
	}
	
	</script>
	</head>
	<body>
		<div id="replyContainer">
			<%-- 댓글 입력 화면 --%>
			<form id="replyReviewForm" name="replyReviewForm">
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
									<button type="button" id="replyReviewInsertBtn" name="replyReviewInsertBtn" class="btn btn-success">등록</button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="rr_content" id="rr_content" rows="3" class="form-control"></textarea>
								</td> 
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			
			<%-- 리스트 영역 --%>
			<div id="replyReviewList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="id"></span>
							<span class="date"></span>
							<span class="upBtn"><a>수정</a></span>
							<span class="delBtn"><img src="/resources/images/common/delete.png" style="display: inline;" /></span>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
			<%-- 댓글 목록 영역 끝--%>
		</div>
	</body>
</html>