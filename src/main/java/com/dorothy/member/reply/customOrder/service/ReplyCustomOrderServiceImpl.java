package com.dorothy.member.reply.customOrder.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.customOrder.dao.CustomOrderReplyDao;
import com.dorothy.admin.reply.customOrder.vo.CustomOrderReplyVO;

import lombok.Setter;

@Service
public class ReplyCustomOrderServiceImpl implements ReplyCustomOrderService {
	
	@Setter(onMethod_ = @Autowired)
	private CustomOrderReplyDao customOrderReplyDao;
	
	// 댓글 목록 구현
	@Override
	public List<CustomOrderReplyVO> replyCustomOrderList(Integer c_num) {
		List<CustomOrderReplyVO> replyList = null;
		replyList = customOrderReplyDao.replyCustomOrderList(c_num);
		return replyList;
	}

}
