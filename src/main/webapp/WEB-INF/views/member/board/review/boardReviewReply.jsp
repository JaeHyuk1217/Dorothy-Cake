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
				let r_num = ${brDetail.r_num};
				listAll(r_num);
				
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
				$element.find(".panel-heading > .panel-title > .nick").html(ad_id + " 님");
				$element.find(".panel-heading > .panel-title > .date").html(" / " + rr_date);
				
				$element.find(".panel-body").html(rr_content);
				$div.append($element);
			}
			
		</script>
	</head>
	<body>
		<div id="replyContainer">
		<%-- 댓글 목록 영역 --%>
			<div id="replyReviewList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="nick"></span>
							<span class="date"></span>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
			<%-- 댓글 목록 영역 끝--%>
			
		</div>
	</body>
</html>