package com.dorothy.member.order.orderInfo.service;

import java.util.List;

import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoDTO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;

public interface OrderInfoService {
	public List<OrderInfoVO> orderInfoList(MemberVO mvo);
	public OrderInfoDTO orderInfoDetail(OrderInfoVO ovo);
	
	public int orderInfoListCnt(OrderInfoVO ovo);
}
