/* 함수명 : chkSubmit(유효성 체크 대상, 메시지 내용)
 * 출력영역 : alert으로.
 * 예시 : if(!chkSubmit($('#keyword'), "검색어를")) return;
 **/
 function chkSubmit(item, msg) {
	if(item.val().replace(/\s/g,"") == ""){
		alert(msg + " 입력해 주세요");
		item.val("");
		item.focus();
		return false;
	} else{
		return true;
	}
}
/* 함수명 : chkData(유효성 체크 대상, 메시지 내용)
 * 출력영역 : alert으로.
 * 예시 : if(!chkData("#keyword", "검색어를")) return;
 **/
 function chkData(item, msg) {
	if($(item).val().replace(/\s/g,"") == ""){
		alert(msg + " 입력해 주세요");
		$(item).val("");
		$(item).focus();
		return false;
	} else{
		return true;
	}
}

/* 함수명 : checkForm(유효성 체크 대상, 메시지 내용)
 * 출력영역 : placeholder 속성을 이용
 * 예시 : if(!checkForm("#keyword", "검색어를")) return;
 **/

function checkForm(item, msg){
	let meassage = "";
	if($(item).val().replace(/\s/g,"") == ""){
		message = msg + " 입력해주세요."
		$(item).attr("placeholder", message);
		return false;
	} else {
		return true;
	}
}

/* 함수명 : formCheck(유효성 체크 대상, 메시지 내용)
 * 출력영역 : 매개변수 두 번째 출력영역에
 * 예시 : if(!formCheck("#keyword", '#msg', "검색어를")) return;
 **/

function formCheck(main, item, msg){
	if($(main).val().replace(/\s/g,"") == ""){
		$(item).css("color", "#000099").html(msg + " 입력해 주세요");
		$(main).val("");
		return false;
	} else {
		return true;
	}
}

/*함수명 : chkFile(파일명)
설명 : 이미지 파일 여부를 확인하기 위해 확장자 확인 함수*/
function chkFile(item){
	/*배열내의 값을 찾아서 인덱스를 반환(요소가 없을 경우 -1 반환)
	jQuery.inArray(찾을값, 검색 대상의 배열)
	pop() : 배열의 마지막 요소를 제거한 후, 제거한 요소를 반환
	*/
	
	let ext = $(item).val().split('.').pop().toLowerCase();
	if(jQuery.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1){
		alert("gif, png, jpg, jpeg 파일만 업로드할 수 있습니다.");
		$(item).val("");
		return false;
	} else {
		return true;
	}
}
