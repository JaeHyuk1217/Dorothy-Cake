package com.dorothy.admin.order.customOrder.service;

import java.util.List;

import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

public interface AdminCustomOrderService {
	public List<CustomOrderBoardVO> customOrderList(CustomOrderBoardVO cobvo);
	public int customOrderListCnt(CustomOrderBoardVO cobvo);
	public CustomOrderBoardVO customOrderDetail(CustomOrderBoardVO cobvo);
	public int customOrderPriceupdate(CustomOrderBoardVO cobvo);
	
	

}
