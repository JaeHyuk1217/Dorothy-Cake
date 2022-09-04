package com.dorothy.admin.order.orderInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.dao.OrderInfoDao;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;


import lombok.Setter;
@Service
public class AdminOrderInfoServiceImpl implements AdminOrderInfoService {
	
	
	@Setter(onMethod_ = @Autowired)
	private OrderInfoDao orderInfoDao;

	@Override
	public List<OrderInfoVO> orderInfoList(MemberVO mvo) {
		List<OrderInfoVO> list = null;
		list = orderInfoDao.orderInfoList(mvo); 
		return list;
	}

	@Override
	public int orderInfoListCnt(OrderInfoVO ovo) {
		return orderInfoDao.orderInfoListCnt(ovo);
	}

	@Override
	public OrderInfoVO orderInfoDetail(OrderInfoVO ovo) {
		
		
		return orderInfoDao.orderInfoDetail(ovo);
		
		
	}

	@Override
	public List<OrderInfoVO> orderListExcel(OrderInfoVO ovo) {
		List<OrderInfoVO> orderList = orderInfoDao.orderListExcel(ovo);
		return orderList;
	}

	@Override
	public List<OrderInfoVO> adminOrderInfoList(OrderInfoVO ovo) {
		List<OrderInfoVO> list = null;
		list = orderInfoDao.adminOrderInfoList(ovo); 
		return list;
	}

	

}
