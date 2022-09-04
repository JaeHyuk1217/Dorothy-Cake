package com.dorothy.member.reply.free.vo;

import lombok.Data;

@Data
public class ReplyFreeVO {
	private int rf_num = 0;			// 자유게시판 댓글 번호
	private int f_num = 0;			// 자우게시판 글 번호
	private String m_id = "";		// 자유게시판 댓글 작성자 아이디
	private String rf_content = ""; // 자유게시판 댓글 내용
	private String rf_date = "";	// 자유게시판 댓글 작성일
}
