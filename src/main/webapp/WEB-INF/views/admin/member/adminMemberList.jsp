<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
	<script type="text/javascript">
		$(function(){
			/* 검색 후 검색 대상과 검색 단어 출력 */
			let word = "<c:out value='${data.keyword}' />";
			let value = "";
			if(word != ""){
				$("#keyword").val("<c:out value='${data.keyword}' />");
				$("#search").val("<c:out value='${data.search}' />");
				
				if($("#search").val() != 'm_name'){
					if($("#search").val() == 'm_id') value = "#list tr td.goDetail";
					
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
				$("#memberSearch").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
			$("#adminMemberUpdateBtn").click(function(){
				let m_id = $(this).parents("tr").attr("data-id");
				console.log("m_id : " +m_id);
				$("#m_id").val(m_id);
				if(confirm("정말 탈퇴 하시겠습니까?")){
					/* 							
					$.ajax({
						url: "/admin/member/adminMemberUpdate",
						type: "POST",
						traditional : true,
						error: function(request,status,error){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							alert("회원이 탈퇴되었습니다.");
							location.reload();
						}
					}); */
					$("#m_data").attr({
						"method":"post",
						"action":"/admin/member/adminMemberUpdate"
					});
					$("#m_data").submit();
				}
			});
		}); //$함수 종료
		/* 실질적으로 검색을 처리하는 함수 */
		function goPage(){
			if($("#search").val() == "all"){
				$("#keyword").val("");
			}
			$("#memberSearch").attr({
				"method":"get",
				"action":"/admin/member/adminMemberList"
			});
			$("#memberSearch").submit();
		}

	</script>


		<%-- 리스트 시작 --%>
		<!-- <form action="/admin/member/adminMemberUpdate" method="get"> -->
			<div id="adminMemberList" class="table-height">
				<div class="contentContainer container">
					<form name="m_data" id="m_data">
						<input type="hidden" id="m_id" name="m_id" />
					</form>
				</div>
			
				<table summary="회원 리스트" class="table table-striped">
					<thead>
						<tr>
							<th class="text-center col-md-1">아이디</th>
							<th class="text-center col-md-2">이름</th>
							<th class="text-center col-md-2">주소</th>
							<th class="text-center col-md-2">상세주소</th>
							<th class="text-center col-md-2">이메일</th>
							<th class="text-center col-md-2">휴대폰번호</th>
							<th class="text-center col-md-3">가입일</th>
							<th class="text-center col-md-1">관리</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty adminMemberList}">
								<c:forEach var="adminMember" items="${adminMemberList}" varStatus="status">
									<tr class="text-center" data-id="${adminMember.m_id}">
										<td class="m_id text-center">${adminMember.m_id}</td>
										<td class="goDetail text-center">${adminMember.m_name}</td>
										<td class="text-center">${adminMember.m_addr2}</td>
										<td class="text-center">${adminMember.m_addr3}</td>
										<td class="text-center">${adminMember.m_mail}</td>
										<td class="text-center">${adminMember.m_pnb}</td>
										<td class="text-center">${adminMember.m_date}</td>
										<td class="text-center">
   											<c:if test="${adminMember.m_state==0}">
       											<input type="button" value="탈퇴" id="adminMemberUpdateBtn" class="btn btn-danger">
       											<!-- <button class="btn btn-success" type="submit" id="submit">탈퇴.</button> -->
   											</c:if>
   											<c:if test="${adminMember.m_state==1}">
       											<span>탈퇴회원</span>
   											</c:if>	
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>					
					</tbody>
				</table>
				<%-- 검색 기능 시작 --%>
				<div id="adminMemberSearch" class="text-center">
					<form id="memberSearch" name="memberSearch" class="form-inline">
						<%-- 페이징 처리를 위한 파라미터 --%>
						<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" id="amount" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="m_name">이름</option>
								<option value="m_id">아이디</option>
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
		</form>
