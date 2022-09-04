package com.dorothy.admin.reply.review.vo;

import lombok.Data;

@Data
public class AdminReplyReviewVO {
	private int rr_num =0; // 댓글번호
	private String rr_content =""; // 댓글 내용
	private String rr_date =""; // 댓글 작성일
	private int r_num =0; // 리뷰글번호
	private String ad_id =""; // 관리자 아이디

}
