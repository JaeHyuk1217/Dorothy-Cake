package com.dorothy.admin.order.orderInfo.service;

import java.util.List;

import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;


public interface AdminOrderInfoService {
	public List<OrderInfoVO> orderInfoList(MemberVO mvo);
	public OrderInfoVO orderInfoDetail(OrderInfoVO ovo);
	
	public int orderInfoListCnt(OrderInfoVO ovo);

	public List<OrderInfoVO> orderListExcel(OrderInfoVO ovo);
	public List<OrderInfoVO> adminOrderInfoList(OrderInfoVO ovo);
	


	

}
