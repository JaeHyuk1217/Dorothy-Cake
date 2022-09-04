<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><tiles:getAsString name="title" /></title>
    
    <link rel="icon" href="/resources/images/common/icon.png">

    <!-- Bootstrap core CSS -->
    <link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
<!--     <link href="/resources/include/dist/css/dashboard.css" rel="stylesheet"> -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/resources/include/dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/resources/include/css/admin.css" />
    <script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="/resources/include/js/common.js"></script>
    <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.17/tailwind.min.css">
	<!--폰트어썸-->
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/include/css/admin.css" />
  </head>
  <body>
	<div class="All-box flex">
		<tiles:insertAttribute name="left" />	
	<div class="w-full">
	<tiles:insertAttribute name="header" />	
				<!--요소 시작-->
		<div class="Side-Box hei-51 bg-4F6884 flex items-center px-6">
			<div class="flex items-center text-white">
				
				
			</div>
			<div class="flex-1"></div>
			<div>
				<div class="flex items-center">
					<span class="text-base text-white mr-1"> <i
						class="fas fa-users"></i>
					</span> 
					<span class="text-white font-bold"><tiles:getAsString name="title" /></span><span
						class="text-sm text-white font-bold">
					</span>
				</div>
			</div>
			<div class="flex-1"></div>
			<div class="flex">
				<div class="flex text-sm text-white font-bold">
					<div class="flex mr-1">
						<span></span> <span></span>
					</div>
					<div class="flex mr-1">
						<span></span> <span></span>
					</div>
					<div class="mr-1">
						<span></span>
					</div>
				</div>
				<div class="text-sm text-white font-bold">
					<span></span>
				</div>
			</div>
		</div>
		
		<div class="Ele-All-Box w-full">
		<tiles:insertAttribute name="main" />
		</div>

	</div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="/resources/include/dist/js/bootstrap.min.js"></script>
    <script src="/resources/include/dist/assets/js/docs.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
