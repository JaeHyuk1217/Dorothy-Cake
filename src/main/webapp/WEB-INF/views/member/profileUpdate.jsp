<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			});
		
			$("#submit").on("click", function(){
				if($("#m_pwd").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#m_pwd").focus();
					return false;
				}
				if($("#m_name").val()==""){
					alert("성명을 입력해주세요.");
					$("#m_name").focus();
					return false;
				}
			});					
		});
		// 주소 api
		function execPostCode() {
	         new daum.Postcode({
	             oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	 
	                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	 
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	                if(fullRoadAddr !== ''){
	                    fullRoadAddr += extraRoadAddr;
	                }
	 
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                console.log(data.zonecode);
	                console.log(fullRoadAddr);
	                
	                
	                $("[name=m_addr]").val(data.zonecode);
	                $("[name=m_addr2]").val(fullRoadAddr);
	                
	                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
	                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
	            }
	         }).open();
	     }
	</script>
	<body>
		<section id="container">
			<form action="/member/memberUpdate" method="post" style="width: 50%; margin: auto;">
				<div class="form-group has-feedback">
					<label class="control-label" for="m_id">아이디</label>
					<input class="form-control" type="text" id="m_id" name="m_id" value="${member.m_id}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="m_pwd">비밀번호</label>
					<input class="form-control" type="text" id="m_pwd" name="m_pwd" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="m_name">이름</label>
					<input class="form-control" type="text" id="m_name" name="m_name" value="${member.m_name}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="m_nick">닉네임</label>
					<input class="form-control" type="text" id="m_nick" name="m_nick" value="${member.m_nick}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="m_mail">이메일</label>
					<input class="form-control" type="text" id="m_mail" name="m_mail" value="${member.m_mail}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="m_pnb">휴대폰번호</label>
					<input class="form-control" type="text" id="m_pnb" name="m_pnb" value="${member.m_pnb}"/>
				</div>
				<div class="form-group">
				<label class="control-label" for="m_addr">주소</label><br />                  
				<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="m_addr" id="m_addr" type="text" readonly="readonly" >
			    	<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
				</div>
				<div class="form-group">
				    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="m_addr2" id="m_addr2" type="text" readonly="readonly" />
				</div>
				<div class="form-group">
				    <input class="form-control" type="text" placeholder="상세주소" name="m_addr3" id="m_addr3" value="${member.m_addr3}" />
				</div>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit">회원정보수정</button>
					<button class="cencle btn btn-danger" type="button">취소</button>
				</div>
			</form>
		</section>
		
	</body>
	
</html>