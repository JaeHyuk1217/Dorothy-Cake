package com.dorothy.admin.reply.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.review.dao.AdminReplyReviewDao;
import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

import lombok.Setter;

@Service
public class AdminReplyReviewServiceImpl implements AdminReplyReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminReplyReviewDao adminReplyReviewDao;

	// 댓글 목록 구현
	@Override
	public List<AdminReplyReviewVO> replyReviewList(Integer r_num) {
		List<AdminReplyReviewVO> replyList = null;
		replyList = adminReplyReviewDao.replyReviewList(r_num);
		return replyList;
	}

	// 댓글 쓰기 구현
	@Override
	public int replyReviewInsert(AdminReplyReviewVO rrvo) {
		int result = 0;
		result = adminReplyReviewDao.replyReviewInsert(rrvo);
		return result;
	}

	// 댓글 삭제 구현
	@Override
	public int replyReviewDelete(int rr_num) {
		int result = 0;
		result = adminReplyReviewDao.replyReviewDelete(rr_num);
		return result;
	}
	
	// 댓글 수정 구현
	@Override
	public int replyReviewUpdate(AdminReplyReviewVO rrvo) {
		int result = 0;
		result = adminReplyReviewDao.replyReviewUpdate(rrvo);
		return result;
	}

}
