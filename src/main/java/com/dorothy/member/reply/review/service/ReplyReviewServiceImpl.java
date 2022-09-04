package com.dorothy.member.reply.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.review.dao.AdminReplyReviewDao;
import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

import lombok.Setter;

@Service
public class ReplyReviewServiceImpl implements ReplyReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminReplyReviewDao adminReplyReviewDao;

	// 댓글 목록 구현
	@Override
	public List<AdminReplyReviewVO> replyReviewList(Integer r_num) {
		List<AdminReplyReviewVO> replyList = null;
		replyList = adminReplyReviewDao.replyReviewList(r_num);
		return replyList;
	}

}
