package com.dorothy.member.reply.review.service;

import java.util.List;

import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

public interface ReplyReviewService {
	List<AdminReplyReviewVO> replyReviewList(Integer r_num);
}
