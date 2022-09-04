package com.dorothy.member.reply.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.reply.free.dao.ReplyFreeDao;
import com.dorothy.member.reply.free.vo.ReplyFreeVO;

import lombok.Setter;

@Service
public class ReplyFreeServiceImpl implements ReplyFreeService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyFreeDao replyFreeDao;
	
	// 댓글 목록 구현
	@Override
	public List<ReplyFreeVO> replyFreeList(Integer f_num) {
		List<ReplyFreeVO> replyList = null;
		replyList = replyFreeDao.replyFreeList(f_num);
		return replyList;
	}
	
	// 댓글 쓰기 구현
	@Override
	public int replyFreeInsert(ReplyFreeVO rfvo) {
		int result = 0;
		result = replyFreeDao.replyFreeInsert(rfvo);
		return result;
	}
	
	// 댓글 삭제 구현
	@Override
	public int replyFreeDelete(int rf_num) {
		int result = 0;
		result = replyFreeDao.replyFreeDelete(rf_num);
		return result;
	}
	
	// 댓글 수정 구현
	@Override
	public int replyFreeUpdate(ReplyFreeVO rfvo) {
		int result = 0;
		result = replyFreeDao.replyFreeUpdate(rfvo);
		return result;
	}
	
	// 해당하는 글의 댓글 전체 삭제
	@Override
	public int replyAllDelete(int f_num) {
		int result = 0;
		result = replyFreeDao.replyAllDelete(f_num);
		return result;
	}

}
