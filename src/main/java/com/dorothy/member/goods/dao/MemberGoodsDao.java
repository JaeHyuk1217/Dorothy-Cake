package com.dorothy.member.goods.dao;

import java.util.List;

import com.dorothy.member.goods.vo.MemberGoodsVO;

public interface MemberGoodsDao {
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo);
	public List<MemberGoodsVO> goodsListLetter(MemberGoodsVO gvo);
	public List<MemberGoodsVO> goodsListAddition(MemberGoodsVO gvo);
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo);
}
