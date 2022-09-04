package com.dorothy.member.goods.service;

import java.util.List;

import com.dorothy.member.goods.vo.MemberGoodsVO;

public interface MemberGoodsService {
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo);
	public List<MemberGoodsVO> goodsListLetter(MemberGoodsVO gvo);
	public List<MemberGoodsVO> goodsListAddition(MemberGoodsVO gvo);
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo);
}
