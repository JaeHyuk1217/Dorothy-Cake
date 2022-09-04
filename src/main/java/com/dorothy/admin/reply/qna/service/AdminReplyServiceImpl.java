package com.dorothy.admin.reply.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.qna.dao.AdminReplyDao;
import com.dorothy.admin.reply.qna.vo.AdminReplyVO;



import lombok.Setter;
@Service
public class AdminReplyServiceImpl implements AdminReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminReplyDao replyDao;
	
	// 댓글 목록 구현
	@Override
	public List<AdminReplyVO> replyList(Integer q_num) {
		List<AdminReplyVO> replyList = null;
		replyList = replyDao.replyList(q_num);
		return replyList;
	}
	
	// 댓글 쓰기 구현
	@Override
	public int replyInsert(AdminReplyVO rvo) {
		int result = 0;
		result = replyDao.replyInsert(rvo);

		if (result == 1) {
			replyDao.statusUpdate(rvo); 			
		}
		
		return result;
	}
	
	// 댓글 삭제 구현
	@Override
	public int replyDelete(int rq_num) {
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
	
	// 해당하는 글의 댓글 전체 삭제
	@Override
	public int replyAllDelete(int q_num) {
		int result = 0;
		result = replyDao.replyAllDelete(q_num);
		return result;
	}

}
