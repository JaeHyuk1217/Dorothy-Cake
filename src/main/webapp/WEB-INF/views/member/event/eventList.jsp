<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		#eventList ul{float: left; width : 100%}
		#eventList ul li{display : inline-block; position: relative; margin : 15px 30px; }
		.eventImg {width: 300px; height: 300px;}
	</style>
	<script type="text/javascript">
		$(function(){
			/* 검색 후 검색 대상과 검색 단어 출력 */
			let word = "<c:out value='${data.keyword}' />";
			let value = "";
			if(word != ""){
				$("#keyword").val("<c:out value='${data.keyword}' />");
				$("#search").val("<c:out value='${data.search}' />");
				
				if($("#search").val() != 'e_content'){
					if($("#search").val() == 'e_title') value = "#eventlist ul li p.goDetail";
					
					$(value+":contains('"+word+"')").each(function(){
						let regex = new RegExp(word, 'gi');
						$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
					});
				}
			}
			/* 검색 대상 변경될 때마다 처리 이벤트 */
			$("#search").change(function(){
				$("#keyword").val("");
				$("#keyword").focus();		
			});
			
			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchData").click(function(){
				if($("#search").val() != "all"){
					if(!chkData("#keyword", "검색어를")) return;
				}
				$("#pageNum").val(1);
				goPage();
			});
			
			$(".paginate_button a").click(function(e){
				e.preventDefault();
				$("#freeSearch").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
			//상품 div 클릭 시 상세 페이지 이동
			$(".event").click(function(){
				let event = $(this).parents("li").attr("data-num");
				$("#event").val(event);
				
				$("#detailForm").attr({
					"method" : "get",
					"action" : "/member/event/eventDetail"
				});
				$("#detailForm").submit();
			});
		}); //$함수 종료
		
		/* 실질적으로 검색을 처리하는 함수 */
		function goPage(){
			if($("#search").val() == "all"){
				$("#keyword").val("");
			}
			$("#eventSearch").attr({
				"method":"get",
				"action":"/member/event/eventList"
			});
			$("#eventSearch").submit();
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form id="detailForm">
				<input type="hidden" id="event" name="e_num" />
			</form>
			<br />
			<div id="eventList">
				<%-- --------------리스트 시작------------- --%>
				<ul>
					<c:choose>
						<c:when test="${not empty eventList }">
							<c:forEach var="event" items="${eventList }">
								<li class="form-inline" data-num="${event.e_num }">
									<div class="event">
										<!-- <img class="eventImg" src="/resources/images/event/${event.e_file}"/> -->
										<c:if test="${not empty event.e_thumb}">
												<img class="eventImg" src="/dorothyUpload/event/thumbnail/${event.e_thumb}" />
											</c:if>
											<c:if test="${empty event.e_thumb}">
												<img class="eventImg" src="/resources/images/common/gojunoimage.JPG"/>
											</c:if>
										<p class="goDetail text-center">
											${event.e_title }<br /><br /><br />
										</p>
									</div>
								</li>
							</c:forEach>
						</c:when>
					</c:choose>
				</ul>
			</div>
			<%-- 검색 기능 시작 --%>
			<div id="boardeventSearch" class="text-center">
				<form id="eventSearch" name="eventSearch" class="form-inline">
					<%-- 페이징 처리를 위한 파라미터 --%>
					<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="e_title">제목</option>
							<option value="e_content">내용</option>
						</select>
						<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" class="form-control" />
						<input type="button" value="검색" id="searchData" name="searchData" class="btn btn-success" />
					</div>
				</form>
			</div>
			<%-- 검색 기능 종료 --%>
			
			<%-- 페이징 처리 커스텀 태그 --%>
			<tag:pagination endPage="${pageMaker.endPage}" startPage="${pageMaker.startPage}" amount="${pageMaker.cvo.amount}" next="${pageMaker.next}" prev="${pageMaker.prev}" pageNum="${pageMaker.cvo.pageNum}" />
		</div>
	</body>
</html>