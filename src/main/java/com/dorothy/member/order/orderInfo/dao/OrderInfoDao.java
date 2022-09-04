package com.dorothy.member.order.orderInfo.dao;

import java.util.List;

import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoDTO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;
import com.dorothy.member.payment.vo.OrderDTO;





public interface OrderInfoDao {
	public int orderInsert(OrderDTO order);
	public List<OrderInfoVO> orderInfoList(MemberVO mvo);
	public List<OrderInfoVO> adminOrderInfoList(OrderInfoVO ovo);
	
	public int orderInfoListCnt(OrderInfoVO ovo);

	public OrderInfoDTO orderInfoDetail(OrderInfoVO ovo);
	public List<OrderInfoVO> orderListExcel(OrderInfoVO ovo);
	
}
