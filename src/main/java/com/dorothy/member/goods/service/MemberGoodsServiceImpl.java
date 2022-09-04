package com.dorothy.member.goods.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dorothy.member.goods.dao.MemberGoodsDao;
import com.dorothy.member.goods.vo.MemberGoodsVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberGoodsServiceImpl implements MemberGoodsService {

	private MemberGoodsDao memberGoodsDao;
	@Override
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo) {
		List<MemberGoodsVO> list = memberGoodsDao.goodsList(gvo);
		return list;
	}
	
	@Override
	public List<MemberGoodsVO> goodsListLetter(MemberGoodsVO gvo) {
		List<MemberGoodsVO> list = memberGoodsDao.goodsListLetter(gvo);
		return list;
	}

	@Override
	public List<MemberGoodsVO> goodsListAddition(MemberGoodsVO gvo) {
		List<MemberGoodsVO> list = memberGoodsDao.goodsListAddition(gvo);
		return list;
	}

	@Override
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo) {
		MemberGoodsVO detail = memberGoodsDao.goodsDetail(gvo);
		return detail;
	}

}
