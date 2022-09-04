package com.dorothy.member.reply.customOrder.service;

import java.util.List;

import com.dorothy.admin.reply.customOrder.vo.CustomOrderReplyVO;

public interface ReplyCustomOrderService {
	List<CustomOrderReplyVO> replyCustomOrderList(Integer c_num);
}
