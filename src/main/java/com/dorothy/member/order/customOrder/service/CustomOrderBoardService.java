package com.dorothy.member.order.customOrder.service;

import java.util.List;

import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

public interface CustomOrderBoardService {
	public List<CustomOrderBoardVO> customOrderList(CustomOrderBoardVO cobvo);
	public int customOrderListCnt(CustomOrderBoardVO cobvo);
	public CustomOrderBoardVO customOrderDetail(CustomOrderBoardVO cobvo);
	public int customOrderInsert(CustomOrderBoardVO cobvo) throws Exception;
	public int customOrderDelete(CustomOrderBoardVO cobvo) throws Exception;
	public CustomOrderBoardVO customOrderUpdateForm(CustomOrderBoardVO cobvo);
	public int customOrderUpdate(CustomOrderBoardVO cobvo) throws Exception;
	
	
	
	
}
