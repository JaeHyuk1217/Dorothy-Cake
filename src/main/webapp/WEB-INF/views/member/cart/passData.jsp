<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
	$(function(){
		let codeArr = [];
		let data = ${codeList};
		codeArr.push(data);
		$("#codeList").val(codeArr);
		
		$("#paymentForm").attr({
			"method":"post",
			"action":"/payment/paymentPage"
		});
		$("#paymentForm").submit();
	})
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form id="paymentForm">
			<input type="hidden" name="codeList" id="codeList" />
		</form>
	</div>
</body>
</html>