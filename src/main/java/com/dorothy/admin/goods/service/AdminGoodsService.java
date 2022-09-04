package com.dorothy.admin.goods.service;

import java.io.IOException;
import java.util.List;

import com.dorothy.member.goods.vo.MemberGoodsVO;
import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

public interface AdminGoodsService {
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo);
	public int goodsListCnt(MemberGoodsVO gvo);
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo);
	public int goodsDelete(MemberGoodsVO gvo) throws Exception;
	public MemberGoodsVO goodsUpateForm(MemberGoodsVO gvo) throws Exception;
	public int goodsUpdate(MemberGoodsVO gvo) throws Exception;
	public int goodsInsert(MemberGoodsVO gvo) throws Exception;
	public int deleteAll(String[] numArr) throws IOException;
	public List<MemberGoodsVO> goodsListExcel(MemberGoodsVO gvo);
	public int customOrderGoodsInsert(MemberGoodsVO mgvo) throws Exception;
	public int getCode(CustomOrderBoardVO cobvo);
}
