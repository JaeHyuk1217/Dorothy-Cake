package com.dorothy.member.cart.service;

import java.util.List;

import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.login.vo.MemberVO;

public interface MemberCartService {

	public List<MemberCartVO> cartList(MemberVO mvo);
	public int cartInsert(MemberCartVO mvco);
	public int deleteAll(String[] numArr);
	public int cartUpdate(MemberCartVO mvco);
	public int getCartNum();

}
