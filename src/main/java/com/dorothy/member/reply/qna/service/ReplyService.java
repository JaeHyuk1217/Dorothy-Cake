package com.dorothy.member.reply.qna.service;

import java.util.List;

import com.dorothy.admin.reply.qna.vo.AdminReplyVO;




	
public interface ReplyService {	
	public List<AdminReplyVO> replyList(Integer q_num);
	public int replyInsert(AdminReplyVO rvo);
	public int replyDelete(Integer rq_num);
	public int replyUpdate(AdminReplyVO rvo);
}
