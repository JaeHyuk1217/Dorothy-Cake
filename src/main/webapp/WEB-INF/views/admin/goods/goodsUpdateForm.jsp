<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style type="text/css">
			textarea { resize: none; }
		</style>
		
		<script type="text/javascript">
			$(function(){
				/* 수정 버튼 클릭 시 글 수정 */
				$("#goodsUpdateBtn").click(function(){
					// 입력값 유효성 체크
					if(!chkData("#g_name", "상품이름을")) return;
					else if(!chkData("#g_price", "상품가격을")) return;
					else if(!chkData("#g_recommend", "추천상품태그를")) return;
					else if(!chkData("#g_new", "신상품태그를")) return;
					else {
						if($("#file").val() != ""){
							if(!chkFile("#file")) return;
						}
						
						$("#goodsUpdate").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/admin/goods/goodsUpdate"
						});
						
						$("#goodsUpdate").submit();
					}
				});
				
				/* 취소 버튼 클릭 시 폼 리셋 */
				$("#goodsCancelBtn").click(function(){
					$("#goodsUpdate").each(function(){
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
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
				<form id="goodsUpdate" name="goodsUpdate" class="form-horizontal">
					<input type="hidden" id="g_code" name="g_code" value="${updateData.g_code}" />
					<input type="hidden" id="g_file" name="g_file" value="${updateData.g_file}" />
					
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="col-md=3">상품코드</td>
								<td class="text-left">${updateData.g_code}</td>
							</tr>
							<tr>
								<td class="col-md=3">상품종류</td>
								<td class="text-left">${updateData.g_type}</td>
							</tr>
							<tr>
								<td>상품이름</td>
								<td class="text-left">
									<input type="text" id="g_name" name="g_name" value="${updateData.g_name}" class="form-control" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>상품가격</td>
								<td class="text-left">
									<input type="text" id="g_price" name="g_price" value="${updateData.g_price}" class="form-control" readonly="readonly"/>
								</td>
							</tr>	
							<tr>
								<td>이미지파일첨부</td>
								<td class="text-left"><input type="file" id="file" name="file" /></td>
							</tr>
							<tr>
								<td>추천상품태그</td>
								<td class="text-left">
									<input type="text" id="g_recommend" name="g_recommend" value="${updateData.g_recommend}" class="form-control" />
								</td>
							</tr>	
							<tr>
								<td>신상품태그</td>
								<td class="text-left">
									<input type="text" id="g_new" name="g_new" value="${updateData.g_new}" class="form-control" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<input type="button" value="수정" id="goodsUpdateBtn" class="btn btn-success" />
						<input type="button" value="취소" id="goodsCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="goodsListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>