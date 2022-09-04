package com.dorothy.admin.reply.qna.service;

import java.util.List;

import com.dorothy.admin.reply.qna.vo.AdminReplyVO;





public interface AdminReplyService {
	public List<AdminReplyVO> replyList(Integer q_num);
	public int replyInsert(AdminReplyVO rvo);
	public int replyDelete(int rq_num);
	public int replyUpdate(AdminReplyVO rvo);
	public int replyAllDelete(int q_num);
	
}