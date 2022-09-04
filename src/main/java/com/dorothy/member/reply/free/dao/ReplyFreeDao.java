package com.dorothy.member.reply.free.dao;

import java.util.List;

import com.dorothy.member.reply.free.vo.ReplyFreeVO;

public interface ReplyFreeDao {
	public List<ReplyFreeVO> replyFreeList(Integer f_num);
	public int replyFreeInsert(ReplyFreeVO rfvo);
	public int replyFreeDelete(int rf_num);
	public int replyFreeUpdate(ReplyFreeVO rfvo);
	public int replyAllDelete(int f_num);
}
