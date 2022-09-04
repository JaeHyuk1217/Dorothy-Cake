<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	 
	<script type="text/javascript">
		$(function(){
			
			/* 수정 버튼 클릭 시 수정 폼으로 이동 */
			$("#customOrderupdateFormBtn").click(function(){
				$("#c_data").attr({
					"method":"post",
					"action":"/board/customOrder/customOrderUpdateForm"
				});
				$("#c_data").submit();
			});
			
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
				location.href="/board/customOrder/customOrderList";
			});
			
			/* 주문 버튼 클릭 시 결제 페이지 출력하기 */
			$("#orderBtn").click(function(){
				$("#frmCart").attr({
					"method":"post",
					"action":"/member/cart/goPayment"
				});
				let g_code = $("#frmCart").find("input[name=g_code]").val();
				console.log(g_code);
				$("#frmCart").submit();
				
			});
			
			/* 취소 버튼 클릭 시 목록으로 돌아가기 */
			$("#cancelBtn").click(function(){
				location.href="/board/customOrder/customOrderList";
			});
			
		}); // $ 함수 종료
	</script>
	</head>
	<body>
	
		<div id="goodsFormData">
					<form id="frmCart" name="frmCart">
						<input type="hidden" name="g_code" value="${g_code }" />
						<input type="hidden" name="gc_amount" value="${customOrderDetail.c_amount }" />
						<input type="hidden" name="g_price" value="${customOrderDetail.c_price}" />
						<input type="hidden" name="m_id" value="${member.m_id }" />
						<input type="hidden" name="g_size" value="${customOrderDetail.c_size }" />
					</form>
				</div>
		<div class="contentContainer container">
			<form name="c_data" id="c_data">
				<input type="hidden" id="c_num" name="c_num" value="${customOrderDetail.c_num}" />
				<%-- <input type="hidden" id="c_file" name="f_file" value="${customOrderDetail.f_file}" />
				<input type="hidden" id="c_replycnt" name="f_replycnt" value="${customOrderDetail.f_replycnt}" /> --%>
			</form>
		</div>

		<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="customOrderupdateFormBtn" class="btn btn-success" />
			<input type="button" value="삭제" id="customOrderDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="customOrderListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${customOrderDetail.m_id}</td>
					</tr>
					<tr>
						<td class="col-md-4">제목</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_title}</td>
					</tr>
					<tr>
						<td class="col-md-4">원하는 수령일</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_receiptdate}</td>
					</tr>
					<tr>
						<td class="col-md-4">수량</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_amount}</td>
					</tr>
					<tr>
						<td class="col-md-4">사이즈옵션</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_size}</td>
					</tr>
					<tr>
						<td class="col-md-4">추가구성품</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_etc}</td>
					</tr>
					<tr>
						<td class="col-md-4">디저트종류</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_dessert}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">주문사항</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_content}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">첨부파일</td>
						<td colspan="3" class="col-md-8 text-left">
							<c:if test="${not empty customOrderDetail.c_file}">
								<img src="/dorothyUpload/customOrder/${customOrderDetail.c_file}" />
							</c:if>
						</td>
					</tr>
					<c:if test="${customOrderDetail.c_price > 0}">
					<tr class="table-tr-height">
						<td class="col-md-4">가격</td>
						<td colspan="3" class="col-md-8 text-left">${customOrderDetail.c_price}</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			<%-- 관리자가 가격 등록 했을 때 나타나는 주문/취소 버튼 --%>
			<c:if test="${customOrderDetail.c_price > 0}">
				<input type="button" value="주문" id="orderBtn" name="orderBtn" class="btn btn-success" />
				<input type="button" value="취소" id="cancelBtn" name="cancelBtn" class="btn btn-success" />
			</c:if>
			<%-- 버튼 종료 --%>
		</div>
		<br />
		<br />
		<%-- 글 상세 정보 보여주기 종료 --%>
		<jsp:include page="reply.jsp"></jsp:include>
		
		
</body>
</html>