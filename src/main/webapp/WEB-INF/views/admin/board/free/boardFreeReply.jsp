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
				let f_num = ${bfDetail.f_num};
				listAll(f_num);
				
				/* 댓글 삭제 */
				$(document).on("click", ".delBtn > img", function(){
					let rf_num = $(this).parents("div.panel").attr("data-num");
					deleteReply(f_num, rf_num);
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
				
				let $element = $("#item-template").clone().removeAttr("id");
				$element.attr("data-num", rf_num);
				$element.addClass("reply");
				$element.find(".panel-heading > .panel-title > .nick").html(m_id + " 님");
				$element.find(".panel-heading > .panel-title > .date").html(" / " + rf_date);
				
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
			
		</script>
	</head>
	<body>
		<div id="replyContainer">			
			<%-- 댓글 목록 영역 --%>
			<div id="replyFreeList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="nick"></span>
							<span class="date"></span>
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