package com.dorothy.member.order.orderInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.dao.OrderInfoDao;
import com.dorothy.member.order.orderInfo.vo.OrderInfoDTO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;

import lombok.Setter;

@Service
public class OrderInfoServiceImpl implements OrderInfoService {
	
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
	public OrderInfoDTO orderInfoDetail(OrderInfoVO ovo) {
		OrderInfoDTO oivo = null;
		
	
		
		oivo = orderInfoDao.orderInfoDetail(ovo);
		
		return oivo;
	}

}


