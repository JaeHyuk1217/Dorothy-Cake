package com.dorothy.admin.reply.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.reply.free.dao.ReplyFreeDao;
import com.dorothy.member.reply.free.vo.ReplyFreeVO;

import lombok.Setter;

@Service
public class AdminReplyFreeServiceImpl implements AdminReplyFreeService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyFreeDao replyFreeDao;
	
	@Override
	public List<ReplyFreeVO> replyFreeList(Integer f_num) {
		List<ReplyFreeVO> replyList = null;
		replyList = replyFreeDao.replyFreeList(f_num);
		return replyList;
	}

}
