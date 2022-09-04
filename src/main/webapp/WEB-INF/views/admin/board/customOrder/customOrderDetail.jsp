<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	 
	<script type="text/javascript">
		$(function(){
			
			/* 삭제 버튼 클릭 시 삭제 */
			$("#customOrderDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "/board/customOrder/customOrderDelete",
						type: "post",
						data: $("#c_data").serialize(),
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							console.log(resultData);	
							alert("등록한 게시글이 삭제되었습니다.");
							location.href="/board/customOrder/customOrderList";	
						}
					});
				}
			});
			
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#customOrderListBtn").click(function(){
				location.href="/admin/board/customOrder/customOrderList";
			});
			
			/* 가격 등록 버튼 클릭 시 가격 업데이트 */
			$("#customOrderupdateFormBtn").click(function(){
				$("#priceForm").attr({
					"method":"post",
					"action":"/admin/board/customOrder/customOrderPriceupdate"
				});
				$("#priceForm").submit();
			});
			
			/* 상품 등록 버튼 클릭 시 상품 등록 */
			$("#customOrderInsertBtn").click(function(){
				$("#goodsInsertForm").attr({
					"method":"post",
					"enctype":"multipart/form-data",
					"action":"/admin/board/customOrder/customOrderGoodsInsert"
				});
				$("#goodsInsertForm").submit();
			});
			
		}); // $ 함수 종료
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form name="c_data" id="c_data">
				<input type="hidden" id="c_num" name="c_num" value="${customOrderDetail.c_num}" />
				<%-- <input type="hidden" id="c_file" name="f_file" value="${bfDetail.f_file}" />
				<input type="hidden" id="c_replycnt" name="f_replycnt" value="${bfDetail.f_replycnt}" /> --%>
			</form>
		</div>

		<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="삭제" id="customOrderDeleteBtn" name="customOrderDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="customOrderListBtn" name="customOrderListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
		<%-- 가격 입력 폼 --%>
			<form id="priceForm">
				<input type="hidden" id="c_num" name="c_num" value="${customOrderDetail.c_num}" />
				<table class="table table-bordered">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<td>글번호</td>
							<td class="text-left">${customOrderDetail.c_num}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td class="text-left">${customOrderDetail.m_id}</td>
						</tr>
						<tr>
							<td>제목</td>
							<td class="text-left">${customOrderDetail.c_title}</td>
						</tr>
						<tr>
							<td>원하는 수령일</td>
							<td class="text-left">${customOrderDetail.c_receiptdate}</td>
						</tr>
						<tr>
							<td>수량</td>
							<td class="text-left">${customOrderDetail.c_amount}</td>
						</tr>
						<tr>
							<td>사이즈옵션</td>
							<td class="text-left">${customOrderDetail.c_size}</td>
						</tr>
						<tr>
							<td>추가구성품</td>
							<td class="text-left">${customOrderDetail.c_etc}</td>
						</tr>
						<tr>
							<td>디저트종류</td>
							<td class="text-left">${customOrderDetail.c_dessert}</td>
						</tr>
						<tr class="table-tr-height">
							<td>주문사항</td>
							<td class="col-md-8 text-left">${customOrderDetail.c_content}</td>
						</tr>
						<tr class="table-tr-height">
							<td>첨부파일</td>
							<td class="text-left">
							<c:if test="${not empty customOrderDetail.c_file}">
								<img src="/dorothyUpload/customOrder/${customOrderDetail.c_file}" />
							</c:if>
							</td>
						</tr>
						<tr>
							<td>상품이름</td>
							<td class="text-left">
								<input type="text" id="g_name" name="g_name" class="form-control" value="${customOrderDetail.g_name}" />
							</td>
						</tr>
						<tr>
							<td>가격</td>
							<td class="text-left">
								<div class="col-md-6">
									<input class="form-control" type="text" id="c_price" name="c_price" value="${customOrderDetail.c_price}">
								</div> 
								<input type="button" value="등록" id="customOrderupdateFormBtn" name="customOrderupdateFormBtn" class="btn btn-success" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>		
		<%-- 가격 입력 폼 종료 --%>	
		
		<%-- 상품 등록 입력 폼 --%>
			<form id="goodsInsertForm">
				<table class="table table-bordered">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<td>상품이름</td>
							<td class="text-left">
								<input type="text" id="g_name" name="g_name" class="form-control" />
							</td>
						</tr>
						<tr>
							<td>상품종류</td>
							<td class="text-left">
								<input type="text" id="g_type" name="g_type" class="form-control" placeholder="1 : 프리미엄 케이크, 2 : 레터링 케이크, 3 : 추가상품" />
							</td>
						</tr>
						<tr>
							<td>상품가격</td>
							<td class="text-left">
								<input type="text" id="g_price" name="g_price" class="form-control" />
							</td>
						</tr>
						<tr>
							<td>상품사진</td>
							<td class="text-left"><input type="file" id="file" name="file" /></td>
						</tr>
						<tr>
							<td>사이즈옵션</td>
							<td class="text-left">
								<input type="text" id="g_size" name="g_size" class="form-control" placeholder="1 : 미니 호수만, 2 : 미니 + 1호"/>
							</td>
						</tr>
						<tr>
							<td>추천상품태그</td>
							<td class="text-left">
								<div class="col-md-6">
									<input type="text" id="g_recommend" name="g_recommend" class="form-control" placeholder="1 : 태그 있음, 2 : 없음" />
								</div>
							</td>
						</tr>
						<tr>
							<td>신상품태그</td>
							<td class="text-left">
								<div class="col-md-6">
									<input type="text" id="g_new" name="g_new" class="form-control" placeholder="1 : 태그 있음, 2 : 없음" />
								</div>
							</td>
						</tr>
						<tr>
							<td>커스텀유무</td>
							<td class="text-left">
								<div class="col-md-6">
									<input type="text" id="g_custom" name="g_custom" class="form-control" placeholder="1 : 커스텀 아님, 2 : 커스텀 맞음" />
								</div>
								<input type="button" value="상품등록" id="customOrderInsertBtn" name="customOrderInsertBtn" class="btn btn-success" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<%-- 상품 등록 입력 폼 종료 --%>
		</div>
		<%-- 글 상세 정보 보여주기 종료 --%>
		
		<%-- 관리자 댓글 목록 --%>
		<jsp:include page="reply.jsp"></jsp:include> 
</body>
</html>