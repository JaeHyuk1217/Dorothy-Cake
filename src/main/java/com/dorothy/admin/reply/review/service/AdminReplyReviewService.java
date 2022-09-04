package com.dorothy.admin.reply.review.service;

import java.util.List;

import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

public interface AdminReplyReviewService {
	public List<AdminReplyReviewVO> replyReviewList(Integer r_num);
	public int replyReviewInsert(AdminReplyReviewVO rrvo);
	public int replyReviewDelete(int rr_num);
	public int replyReviewUpdate(AdminReplyReviewVO rrvo);
}
