package com.dorothy.member.reply.qna.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int rq_num = 0;
	private int q_num = 0;
	private String ad_id = "";
	private String rq_content = "";
	
	private String rq_date = "";
}
