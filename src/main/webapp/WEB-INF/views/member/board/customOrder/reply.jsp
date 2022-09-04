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
				$element.find(".panel-heading > .panel-title > .nick").html(ad_id + " 님");
				$element.find(".panel-heading > .panel-title > .date").html(" / " + rc_date);
				
				$element.find(".panel-body").html(rc_content);
				$div.append($element);
			}
			
		</script>
	</head>
	<body>
		<div id="replyContainer">			
			<%-- 댓글 목록 영역 --%>
			<div id="replyCustomOrderList">
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