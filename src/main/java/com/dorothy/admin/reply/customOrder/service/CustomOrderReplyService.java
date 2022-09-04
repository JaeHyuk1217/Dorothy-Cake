package com.dorothy.admin.reply.customOrder.service;

import java.util.List;

import com.dorothy.admin.reply.customOrder.vo.CustomOrderReplyVO;

public interface CustomOrderReplyService {
	public List<CustomOrderReplyVO> replyCustomOrderList(Integer c_num);
	public int replyCustomOrderInsert(CustomOrderReplyVO corvo);
	public int replyCustomOrderDelete(int rc_num);
	public int replyCustomOrderUpdate(CustomOrderReplyVO corvo);
	
}
