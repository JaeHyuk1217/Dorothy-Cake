<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(function(){
		//idck 버튼을 클릭했을 때 
	    $("#idck").click(function() {
	        //userid 를 param.
	        var m_id =  $("#m_id").val(); 
	        
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : m_id,
	            url : "idcheck",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	                if (data.cnt > 0) {
	                    
	                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
	                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
	                    $("#divInputId").addClass("has-error")
	                    $("#divInputId").removeClass("has-success")
	                    $("#m_id").focus();
	                    
	                
	                } else {
	                    alert("사용가능한 아이디입니다.");
	                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
	                    $("#divInputId").addClass("has-success")
	                    $("#divInputId").removeClass("has-error")
	                    $("#m_pwd").focus();
	                    //아이디가 중복하지 않으면  idck = 1 
	                    idck = 1;
	                    
	                }
	            },
	            error : function(error) {
	                
	                alert("error : " + error);
	            }
	        });
	    });
		$("#registerBtn").click(function(){
			// 입력값 유효성 체크
				if(!chkData("#m_id", "아이디를")) return;
				else if(!chkData("#m_pwd", "비밀번호를")) return;
				else if(!chkData("#m_name", "이름을")) return;
				else if(!chkData("#m_mail", "메일을")) return;
				else if(!chkData("#m_pnb", "휴대폰번호를")) return;
				else if(!chkData("#m_addr", "주소를")) return;
				else if(!chkData("#m_addr2", "주소를")) return;
				else if(!chkData("#m_addr3", "주소를")) return;
				else if(confirm("회원가입을 하시겠습니까?")){
			        if(idck==0){
			            alert('아이디 중복체크를 해주세요');
			            return false;
			        }else{
					alert("회원가입을 축하합니다")
					$("#register").attr({
						"method":"post",
						"action":"/member/register"
					});
					
					$("#register").submit();
				}
			}
		});
	/* 취소 버튼 클릭 시 폼 리셋 */
	$("#registerCancelBtn").click(function(){
		$("#register").each(function(){
			this.reset();
		});
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
		<form id ="register" name ="register" class="form-horizonta" style="width: 50%; margin: auto;">
		<!-- <form action="/member/register" method="post"> -->
			<div class="form-group has-feedback" id = "divInputId">
				<label class="control-label" for="m_id">아이디</label><br /> <input 
					class="form-control"  type="text" id="m_id" name="m_id" style="width: 85%; display: inline;">
				<input type="button" class="btn btn-default" value="중복확인" id="idck" name="idck"/>	
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="m_pwd">비밀번호</label> <input
					class="form-control" type="password" id="m_pwd" name="m_pwd" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="m_name">이름</label> <input
					class="form-control" type="text" id="m_name" name="m_name" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="m_nick">닉네임</label> <input
					class="form-control" type="text" id="m_nick" name="m_nick" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="m_mail">이메일</label> <input
					class="form-control" type="text" id="m_mail" name="m_mail" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="m_pnb">휴대폰번호</label> <input
					class="form-control" type="text" id="m_pnb" name="m_pnb" />
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
			    <input class="form-control" placeholder="상세주소" name="m_addr3" id="m_addr3" type="text"  />
			</div>
			<div class="form-group has-feedback">
				<input type="button" value="회원가입" id="registerBtn" class="btn btn-success" />
				<input type="button" value="취소" id="registerCancelBtn" class="cencle btn btn-danger" />
			</div>
		</form>
	</section>

</body>

</html>