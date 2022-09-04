package com.dorothy.admin.goods.dao;

import java.util.List;

import com.dorothy.member.goods.vo.MemberGoodsVO;
import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

public interface AdminGoodsDao {
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo);
	public int goodsListCnt(MemberGoodsVO gvo);
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo);
	public int goodsDelete(MemberGoodsVO gvo);
	public MemberGoodsVO goodsUpateForm(MemberGoodsVO gvo);
	public int goodsUpdate(MemberGoodsVO gvo);
	public int goodsInsert(MemberGoodsVO gvo);
	public MemberGoodsVO deleteVO(int g_code);
	public List<MemberGoodsVO> goodsListExcel(MemberGoodsVO gvo);
	public int customOrderGoodsInsert(MemberGoodsVO mgvo);
	public int getCode(CustomOrderBoardVO cobvo);
}
