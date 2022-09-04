package com.dorothy.admin.order.customOrder.dao;

import java.util.List;

import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

public interface AdminCustomOrderDao {
	public List<CustomOrderBoardVO> customOrderList(CustomOrderBoardVO cobvo);
	public int customOrderListCnt(CustomOrderBoardVO cobvo);
	public CustomOrderBoardVO customOrderDetail(CustomOrderBoardVO cobvo);
	
}
