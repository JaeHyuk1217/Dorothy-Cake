<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<style type="text/css">
			#item-template{ display: none; }
			textarea { resize: none; }
			.upBtn > a { text-decoration: none; font-size: small; color: black; }
			.upBtn > a:hover{ text-decoration: none; font-size: small; color : red; }
			.delBtn > a { text-decoration: none; font-size: small; color: black; }
			.delBtn > a:hover{ text-decoration: none; font-size: small; color : red; }
			
			
		</style>
	
	<script type="text/javascript">
		$(function(){
			/* 기본 덧글 목록 불러오기 */
			let r_num = ${brDetail.r_num};
			listAll(r_num);
			
			/* 글입력을 위한 Ajax 연동 처리 */
			//$("#replyInsertBtn").click(function(){
			$(document).on("click", "#replyInsertBtn", function(){
				let insertUrl = "/admin/replies/review/replyReviewInsert";
				
				/* JSON.stringify() : JavaScript 값이나 객체를 JSON 문자열로 변환 */
				let value = JSON.stringify({
					r_num:r_num,
					
					/* m_id:$("#m_id").val(),
					m_id:"abc123", // 세션의 m_id 값으로 나중에 변경 */
					ad_id:$("#ad_id").val(),
					
					rr_content:$("#rr_content").val()
				});
				
				$.ajax({
					url : insertUrl, // 전송 url
					type : "post", // 전송 시 method 방식
					headers : {
						"Content-Type":"application/json"
					},
					dataType : "text",
					data : value,
					error : function(xhr, textStatus, errorThrown){ // 실행 시 오류가 발생하였을 경우
						/* alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")"); */
						//alert("시스템에 문제가 있어 잠시 후에 다시 진행해 주세요.");
					},
					beforeSend: function(){
						/* if(!checkForm("#rq_name", "작성자를")) return false;
						else if(!checkForm("#rq_pwd", "비밀번호를")) return false; */
						if(!checkForm("#rr_content", "댓글내용을")) return false;
					},
					success : function(result){
						if(result == "SUCCESS"){
							alert("댓글 등록이 완료되었습니다.");
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
			
			
			/* 댓글 수정 폼 함수 */
			function updateReplyForm(rr_num, panel){
				let content = panel.find(".panel-body").html();
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, "\r\n");
				$("#rr_content").val(content);
				
				$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");
				$("#replyForm button[type='button']").attr("data-num", rr_num);
			}
			
			/* 비밀번호 확인없이 수정버튼 제어 */
			/* $(document).on("click", "button[data-btn='upBtn']", function(){
				let panel = $(this).parents("div.panel")
				let rq_num = panel.attr("data-num");
				updateForm(rq_num, panel);
			}); */
			
			/* 댓글 수정을 위한 Ajax 연동 처리 */
			$(document).on("click", "#replyUpdateBtn", function(){
				let rr_num = $(this).attr("data-num");
				$.ajax({
					url: "/admin/replies/review/" + rr_num,
					type: "put",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "PUT"
					},
					data: JSON.stringify({
						rr_content: $("#rr_content").val(),
					}),
					
					dataType: 'text',
					error: function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						// alert("시스템에 문제가 있어 잠시 후에 다시 진행해 주세요.");
					},
					beforsend: function(){
						if(!checkForm("#rr_content", "댓글내용을")) return false;
					},
					success:function(result){
						console.log("result:" + result);
						if(result == "SUCCESS"){
							alert("댓글 수정이 완료되었습니다.")
							dataReset();
							listAll(r_num);
						}
					}
				});
			});
			
			
			/* 비밀번호 확인없이 삭제버튼 제어 */
			/* $(document).on("click", "button[data-btn='delBtn']", function(){
				let rq_num = $(this).parents("div.panel").attr("data-num");
				deleteBtn(q_num, rq_num);
			}); */
			
		}); // 최상위 종료
		
		/* 댓글 목록 보여주는 함수 */
		function listAll(r_num) {
			$(".reply").detach(); // detach(): 선택한 요소를 DOM 트리에서 삭제.
			
			 let url = "/admin/replies/review/all/" + r_num;
			 
			 $.getJSON(url, function(data){ // data = [{rq_num:1, rq_name:"홍길동"}, {}]
				$(data).each(function(){
					let rr_num = this.rr_num;
					let ad_id = this.ad_id;
					let rr_content = this.rr_content;
					let rr_date = this.rr_date;
					rr_content = rr_content.replace(/(\r\n|\r|\n)/g, "<br />");
					template(rr_num, ad_id, rr_content, rr_date);
				});
			 }).fail(function(){
				alert("덧글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요."); 
			 });
		}
		
		/* 새로운 글을 화면에 추가하기(보여주기) 위한 함수 */
		function template(rr_num, ad_id, rr_content, rr_date) {
			let $div = $("#replyList");
			
			let $element = $("#item-template").clone().removeAttr("id");
			$element.attr("data-num", rr_num);
			$element.addClass("reply");
			$element.find(".panel-heading > .panel-title > .name").html(ad_id + "님");
			$element.find(".panel-heading > .panel-title > .date").html(" / " + rr_date);
			// 로그인 한 사용자와 일치하다면 .panel-title에 수정, 삭제 추가.
			$element.find(".panel-body").html(rr_content);
			$div.append($element);
			
			
			/* 동적으로 사용
			$("#reviewList").append(r_num + " / " + r_name + " / " + r_content + " / " + r_date + "<br />");
			// 새로운 글이 추가될 div 태그 객체
			let wrapper_div = $("<div>");
			wrapper_div.attr("data-num", r_num);
			wrapper_div.addClass("panel panel-default");
			
			let new_div = $("<div>");
			new_div.addClass("panel-heading");
			
			// 작성자 정보의 이름
			let name_span = $("<span>");
			name_span.addClass("name");*/
		}
		
		/* 입력 폼 초기화*/
		function dataReset(){
			$("#replyForm").each(function(){
				this.reset();
			});
			
			/* $("#rq_name").prop("readonly", false); */
			$("#replyForm button[type='button']").removeAttr("data-num");
			$("#replyForm button[type='button']").attr("id", "replyInsertBtn");
		}
		
		/* 댓글 삭제를 위한 Ajax 연동 처리 */
		function deleteBtn(r_num, rr_num){
			if(confirm("정말 삭제하시겠습니까?")){
				$.ajax({
					//url : '/replies/' + q_num + '/' + rq_num,
					url : "/admin/replies/review/" + rr_num,
					type : "delete", // method - get/post/put/delete 존재
					headers : {
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : "text",
					error : function(xhr, textStatus, errorThrown){ // 실행 시 오류가 발생하였을 경우
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						//alert("시스템에 문제가 있어 잠시 후 다시 진행해 주세요.");
					},
					success : function(result){
						console.log("result: " + result);
						if(result == 'SUCCESS'){
							alert("댓글 삭제가 완료되었습니다.");
							listAll(r_num);
						}
					}
				});
			}
		}
		
		/* 수정 폼 화면 구현 함수 */
		 function updateForm(rr_num, panel){
			// $("#rq_name").val(panel.find(".panel-title .name").html());
			// $("#rq_name").prop("readonly", true); 
			
			let content = panel.find(".panel-body").html();
			content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n'); // <br><br/><br /> => \r\n으로 변경
			$("#rr_content").val(content);
			
			$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");
			$("#replyForm button[type='button']").attr("data-rnum", rr_num);
		} 
	</script>
	</head>
	<body>
		<div id="replyContainer">
			<%-- 댓글 입력 화면 --%>
			<form id="replyForm" name="replyForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">작성자</td>
								<td class="col-md-3 text-left">
									<input type="text" id="ad_id" name="ad_id" value="${adminLogin.ad_id}" />
									
									
								</td>
								<td class="col-md-4 text-right">
									<button type="button" id="replyInsertBtn" name="replyInsertBtn" class="btn btn-success">등록</button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="rq_content" id="rq_content" rows="3"></textarea>
								</td> 
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			
			<%-- 리스트 영역 --%>
			<div id="replyList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="name"></span>
							<span class="date"></span>
							<span class="upBtn"><a>수정</a></span>
							<span class="delBtn"><a>삭제</a></span>
						
							<!-- <button type="button" data-btn="upBtn" class="btn btn-default gap">수정</button>
							<button type="button" data-btn="delBtn" class="btn btn-default gap">삭제</button> -->
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
			<%-- 댓글 목록 영역 끝--%>
		</div>
	</body>
</html>