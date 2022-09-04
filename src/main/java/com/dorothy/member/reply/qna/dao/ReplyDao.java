package com.dorothy.member.reply.qna.dao;

import java.util.List;

import com.dorothy.member.reply.qna.vo.ReplyVO;



public interface ReplyDao {
	public List<ReplyVO> replyList(Integer q_num);
	public int replyInsert(ReplyVO rvo);
	public int replyDelete(Integer rq_num);
	public int replyUpdate(ReplyVO rvo);
	public int replyCnt(int q_num);
}
