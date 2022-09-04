package com.dorothy.member.reply.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.qna.dao.AdminReplyDao;
import com.dorothy.admin.reply.qna.vo.AdminReplyVO;

import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private AdminReplyDao replyDao;
	
	// 댓글 목록 구현
	@Override
	public List<AdminReplyVO> replyList(Integer q_num) {
		List<AdminReplyVO> list = null;
		list = replyDao.replyList(q_num);
		return list;
	}
	
	// 댓글 입력 구현
	@Override
	public int replyInsert(AdminReplyVO rvo) {
		int result = 0;
		result = replyDao.replyInsert(rvo);
		return result;
	}
	
	// 댓글 삭제 구현
	@Override
	public int replyDelete(Integer rq_num) {
		int result = 0;
		result = replyDao.replyDelete(rq_num);
		return result;
	}
	
	// 댓글 수정 구현
	@Override
	public int replyUpdate(AdminReplyVO rvo) {
		int result = 0;
		result = replyDao.replyUpdate(rvo);
		return result;
	}

	

}
