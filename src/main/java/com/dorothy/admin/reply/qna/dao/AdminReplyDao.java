package com.dorothy.admin.reply.qna.dao;

import java.util.List;

import com.dorothy.admin.reply.qna.vo.AdminReplyVO;




public interface AdminReplyDao {
	public List<AdminReplyVO> replyList(Integer q_num);
	public int replyInsert(AdminReplyVO rvo);
	public int replyDelete(int rq_num);
	public int replyUpdate(AdminReplyVO rvo);
	public int replyAllDelete(int q_num);
	public int statusUpdate(AdminReplyVO rvo);
	public int replyCnt(int q_num); 
}
