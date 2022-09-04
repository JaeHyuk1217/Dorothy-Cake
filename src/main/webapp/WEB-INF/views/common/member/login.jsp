<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/memberLogin.css" />
<script type="text/javascript">
		$(function(){
			$("#registerBtn").click(function(){
				location.href = "/member/register";
			});
			$("#logoutBtn").click(function(){
				location.href = "/member/logout";
			});
		});
    </script>
  </head>

  <body>
    <div id="wrap">
  <div id="sign-up">
    <div class="group">
    	<h2>LOGIN</h2>
    	<br />
      <form name='homeForm' method="post" action="/member/login" action="/admin/login">
        <div class="insert-area">
          <label for="user-id">
            <input type="text" id="m_id" name="m_id" placeholder="아이디" class="form-ctrl" >
          </label>
          <label for="password" class="tit">
            <input type="password" id="m_pwd" name="m_pwd" class="form-ctrl"  placeholder="비밀번호">
          </label>
        </div>
        <button type="submit">로그인</button>
        <button type="button" id ="registerBtn">회원가입</button>
        <div class="login-option">
          <div class="input-checkbox">
            <input type="checkbox" name="" id="auto-login">
            <label for="autoLogin">로그인상태유지</label>
            <input type="checkbox" name="" id="secure-login">
            <label for="secure-login">보안접속</label>
          </div>
		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>
        </div>
      </form>
    </div>
  </div>
</div>
</html>
