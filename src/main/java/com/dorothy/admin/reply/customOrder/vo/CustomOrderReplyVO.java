package com.dorothy.admin.reply.customOrder.vo;

import lombok.Data;

@Data
public class CustomOrderReplyVO {
	private int rc_num =0; // 댓글번호
	private String rc_content =""; // 댓글 내용
	private String rc_date =""; // 댓글 작성일
	private int c_num =0; // 주문글번호
	private String ad_id =""; // 관리자 아이디
	
}
