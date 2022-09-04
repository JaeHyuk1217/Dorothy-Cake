package com.dorothy.admin.reply.qna.vo;

import lombok.Data;

@Data
public class AdminReplyVO {
	private int rq_num = 0;			// 게시판 댓글 번호
	private int q_num = 0;			// 게시판 글 번호
	private String ad_id = "";		// 게시판 댓글 관리자 아이디
	private String rq_content = ""; // 게시판 댓글 내용
	private String rq_date = "";	// 게시판 댓글 작성일
}



