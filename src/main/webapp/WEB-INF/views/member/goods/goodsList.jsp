<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		#goodsList ul{float: left; width : 100%}
		#goodsList ul li{display : inline-block; position: relative; margin : 15px 30px; }
		.goodsImg {width: 300px; height: 300px;}
	</style>
	<script type="text/javascript">
		$(function(){
			//상품 div 클릭 시 상세 페이지 이동
			$(".goods").click(function(){
				let g_code = $(this).parents("li").attr("data-num");
				$("#g_code").val(g_code);
				
				$("#detailForm").attr({
					"method" : "get",
					"action" : "/member/goods/goodsDetail"
				});
				$("#detailForm").submit();
			});
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form id="detailForm">
				<input type="hidden" id="g_code" name="g_code" />
			</form>
		
			<div id="goodsList">
				<%-- --------------리스트 시작------------- --%>
				<ul>
					<c:choose>
						<c:when test="${not empty goodsList }">
							<c:forEach var="goods" items="${goodsList }">
								<li class="form-inline" data-num="${goods.g_code }">
									<div class="goods">
										<img class="goodsImg" src="/dorothyUpload/goods/${goods.g_file }" />
										<p class="text-center">
											${goods.g_name }<br />
											${goods.g_price }원<br />
											&nbsp;
											<c:if test="${goods.g_recommend eq '1'}">
												<img src="/resources/images/goods/icon/recommend.gif" />
											</c:if>
											<c:if test="${goods.g_new eq '1' }">
												<img src="/resources/images/goods/icon/new.gif" />
											</c:if>
										</p>
										
									</div>
								</li>
							</c:forEach>
						</c:when>
					</c:choose>
				</ul>
			</div>
		</div>
	</body>
</html>