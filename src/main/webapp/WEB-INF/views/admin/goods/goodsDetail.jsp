<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript">
		$(function(){
			
			/* 수정 버튼 클릭 시 수정 폼으로 이동 */
			$("#updateFormBtn").click(function(){
				// 나중에 사용자 제어 추가!
				$("#g_data").attr({
					"method":"post",
					"action":"/admin/goods/goodsUpdateForm"
				});
				$("#g_data").submit();
			});
			
			/* 삭제 버튼 클릭 시 삭제 */
			$("#goodsDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "/admin/goods/goodsDelete",
						type: "post",
						data: $("#g_data").serialize(),
						dataType: "text",
						error: function(){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							console.log(resultData);	
							alert("등록한 상품이 삭제되었습니다.");
							location.href="/admin/goods/goodsList";	
						}
					});
				}
			});
			
			/* 목록 버튼 클릭 시 목록으로 돌아가기 */
			$("#goodsListBtn").click(function(){
				location.href="/admin/goods/goodsList";
			});
		}); // $ 함수 종료
	</script>
		<div class="contentContainer container">
			<form name="g_data" id="g_data">
				<input type="hidden" id="g_code" name="g_code" value="${detail.g_code}" />
				<input type="hidden" id="g_file" name="g_file" value="${detail.g_file}" />
			</form>
		</div>

		<%-- 글 수정 삭제 목록 버튼 보여주기 시작 --%>
		<div class="btnArea text-right" style="margin-bottom: 5px">
			<input type="button" value="수정" id="updateFormBtn" class="btn btn-success" />
			<input type="button" value="삭제" id="goodsDeleteBtn" class="btn btn-success" />
			<input type="button" value="목록" id="goodsListBtn" class="btn btn-success" />
		</div>
		<%-- 글 수정 삭제 목록 버튼 보여주기 끝 --%>
	
		<%-- 글 상세 정보 보여주기 시작 --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-1">상품코드</td>
						<td class="col-md-3 text-left">${detail.g_code}</td>
					</tr>
					<tr>
						<td class="col-md-1">상품이름</td>
						<td class="col-md-3 text-left">${detail.g_name}</td>
					</tr>
					<tr>
						<td class="col-md-1">상품종류</td>
						<td class="col-md-3 text-left">${detail.g_type}</td>
					</tr>
					<tr>
						<td class="col-md-1">상품가격</td>
						<td class="col-md-3 text-left">${detail.g_price}</td>
					</tr>
					<tr>
						<td class="col-md-1">상품사진</td>
						<td class="col-md-3 text-left">
						<img src="/dorothyUpload/goods/${detail.g_file}" /><br />
						${detail.g_file}</td>
					</tr>
					<tr>
						<td class="col-md-1">추천상품태그</td>
						<td class="col-md-3 text-left">
						<c:choose>
							<c:when test="${detail.g_recommend eq '1'}">
								<span>있음</span>
							</c:when>
							<c:otherwise>
								<span>없음</span>
							</c:otherwise>
						</c:choose></td>
					</tr>
					<tr>
						<td class="col-md-1">신상품태그</td>
						<td class="col-md-3 text-left">
						<c:choose>
							<c:when test="${detail.g_new eq '1'}">
								<span>있음</span>
							</c:when>
							<c:otherwise>
								<span>없음</span>
							</c:otherwise>
						</c:choose></td>
					</tr>
					<tr>
						<td class="col-md-1">커스텀유무</td>
						<td class="col-md-3 text-left">
						<c:choose>
							<c:when test="${detail.g_custom eq '1'}">
								<span>기성품</span>
							</c:when>
							<c:otherwise>
								<span>커스텀제품</span>
							</c:otherwise>
						</c:choose></td>
					</tr>
				</tbody>
			</table>
		</div>
</body>