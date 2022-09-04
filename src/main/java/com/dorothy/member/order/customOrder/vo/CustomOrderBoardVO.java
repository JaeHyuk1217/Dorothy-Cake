package com.dorothy.member.order.customOrder.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CustomOrderBoardVO extends CommonVO {
	private String m_id =""; // 아이디
	private String m_nick =""; // 닉네임
	private int c_num =0; // 글번호
	private String c_title =""; // 글제목
	private String c_inquiry =""; // 문의상태
	private String c_receiptdate =""; // 원하는 수령일
	private int c_size =0; // 사이즈옵션
	private String c_etc =""; // 추가구성품
	private String c_dessert =""; // 디저트종류
	private String c_content =""; // 주문사항
	private int c_code =0; // 상품코드
	private int c_price =0; // 상품가격
	private int c_amount =0; // 상품수량
	private int c_replycnt = 0; // 커스텀 제품 주문 게시판 글의 댓글 개수
	
	private String g_name = "";
	
	private MultipartFile mfile; // 파일 업로드를 위한 필드
	private String c_file =""; // 서버에 저장할 이미지 파일 명
	
}
