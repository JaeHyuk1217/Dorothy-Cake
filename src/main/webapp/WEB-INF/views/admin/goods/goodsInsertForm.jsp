<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
		<script type="text/javascript">
			$(function(){
				/* 등록 버튼 클릭 시 글 등록 */
				$("#goodsInsertBtn").click(function(){
					// 입력값 유효성 체크
					if(!chkData("#g_name", "상품이름을")) return;
					else if(!chkData("#g_type", "상품종류를")) return;
					else if(!chkData("#g_price", "상품가격을")) return;
					else if(!chkData("#g_size", "사이즈옵션을")) return;
					else if(!chkData("#g_recommend", "추천상품태그를")) return;
					else if(!chkData("#g_new", "신상품태그를")) return;
					else if(!chkData("#g_custom", "커스텀유무를")) return;
					else {
						if($("#file").val() != null){
							if(!chkFile("#file")) return;
						}
						
						$("#goodsInsert").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/admin/goods/goodsInsert"
						});
						
						$("#goodsInsert").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 폼 리셋 */
				$("#goodsCancelBtn").click(function(){
					$("#goodsInsert").each(function(){
						this.reset();
					});
				});
				
				/* 목록 버튼 클릭 시 글 목록으로 이동*/
				$("#goodsListBtn").click(function(){
					if(confirm("목록으로 이동하시겠습니까?")){
						location.href="/admin/goods/goodsList";
					}
				});
			}); // $ 함수 종료
		</script>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="goodsInsert" name="goodsInsert" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>상품이름</td>
								<td class="text-left">
									<!-- 로그인 한 사용자의 닉네임 받아오기 -->
									<input type="text" id="g_name" name="g_name" class="form-control"/>
								</td>
							</tr>
							<tr>
								<td>상품종류</td>
								<td class="text-left">
									<input type="text" id="g_type" name="g_type" class="form-control" placeholder="1 : 프리미엄 케이크, 2 : 레터링 케이크, 3 : 부가상품"/>
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
									<input type="text" id="g_size" name="g_size" class="form-control" placeholder="0: 부가상품, 1 : 미니 호수만, 2 : 미니 + 1호"/>
								</td>
							</tr>
							<tr>
								<td>추천상품태그</td>
								<td class="text-left">
									<input type="text" id="g_recommend" name="g_recommend" class="form-control" placeholder="1 : 태그 있음, 2 : 없음"/>
								</td>
							</tr>
							<tr>
								<td>신상품태그</td>
								<td class="text-left">
									<input type="text" id="g_new" name="g_new" class="form-control" placeholder="1 : 태그 있음, 2 : 없음"/>
								</td>
							</tr>
							<tr>
								<td>커스텀유무</td>
								<td class="text-left">
									<input type="text" id="g_custom" name="g_custom" class="form-control" placeholder="1 : 커스텀 아님, 2 : 커스텀 맞음"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="등록" id="goodsInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="goodsCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="goodsListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>