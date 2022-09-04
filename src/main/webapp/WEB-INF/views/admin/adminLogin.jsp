<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>관리자 페이지</title>
    
    <link rel="icon" href="/resources/images/common/icon.png">

    <!-- Bootstrap core CSS -->
    <link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/resources/include/dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
   <!--  <link rel="stylesheet" type="text/css" href="/resources/include/css/admin.css" /> -->
    <script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="/resources/include/js/common.js"></script>
    <script type="text/javascript">
    	$(function(){
    		let errorMsg = "${errorMsg}";
    		if(errorMsg!=""){
    			alert(errorMsg);
    			errorMsg = "";
    		}
    		
    		$("#loginBtn").click(function(){
				//입력값 체크
				if(!chkData("#ad_id", "아이디를"))return;
				else if(!chkData("#ad_pwd", "비밀번호를")) return;
				else {
					$("#loginForm").attr({
						"method":"post",
						"action":"/admin/login"
					});
					$("#loginForm").submit();
				}
			});
    	});
    	
    </script>
  </head>

  <body>
    <div class="container">
      <form class="form-signin" id="loginForm" style="width: 30%; position :absolute; top:30%; left:50%; transform: translate(-50%, -50%)">
        <h2 class="form-signin-heading text-center">관리자 로그인</h2><br /><br /><br />
        <label for="adminid" class="sr-only">아이디</label>
        <input type="text" id="ad_id" name="ad_id" class="form-control" placeholder="아이디">
        
        <label for="ad_pwd" class="sr-only">비밀번호</label>
        <input type="password" id="ad_pwd" name="ad_pwd" class="form-control" placeholder="비밀번호">
        <button class="btn btn-success btn-block" type="button" id="loginBtn">로그인</button>
		<br /><br /><br />
        <a href="/">
      		<button class="btn btn-success btn-block" type="button" id="mainBtn">메인으로 가기</button>
      	</a>
      </form>
    </div> <!-- /container -->

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
