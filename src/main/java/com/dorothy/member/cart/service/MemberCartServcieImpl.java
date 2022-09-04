package com.dorothy.member.cart.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dorothy.member.cart.dao.MemberCartDao;
import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberCartServcieImpl implements MemberCartService {
	
	private MemberCartDao memberCartDao;
	@Override
	public List<MemberCartVO> cartList(MemberVO mvo) {
		List<MemberCartVO> list = memberCartDao.cartList(mvo);
		return list;
	}
	@Override
	public int cartInsert(MemberCartVO mvco) {
		int result = 0;
		
		result = memberCartDao.cartInsert(mvco);
		
		return result;
	}
	@Override
	public int deleteAll(String[] numArr) {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int gc_num = Integer.parseInt(numArr[i]);
			MemberCartVO mvco = new MemberCartVO();
			mvco.setGc_num(gc_num);
			
			result += memberCartDao.cartDelete(mvco);
		}
		
		return result;
	}
	@Override
	public int cartUpdate(MemberCartVO mvco) {
		int result = 0;
		
		result = memberCartDao.cartUpdate(mvco);
		
		return result;
	}
	@Override
	public int getCartNum() {
		
		return memberCartDao.getCartNum();
	}

}
