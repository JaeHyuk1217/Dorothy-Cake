package com.dorothy.admin.reply.review.dao;

import java.util.List;

import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

public interface AdminReplyReviewDao {
	public List<AdminReplyReviewVO> replyReviewList(Integer r_num);
	public int replyReviewInsert(AdminReplyReviewVO rrvo);
	public int replyAllDelete(int r_num);
	public int replyReviewDelete(int rr_num);
	public int replyReviewUpdate(AdminReplyReviewVO rrvo);
}
