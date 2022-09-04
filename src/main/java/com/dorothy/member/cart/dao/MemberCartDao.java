package com.dorothy.member.cart.dao;

import java.util.List;

import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.login.vo.MemberVO;

public interface MemberCartDao {
	public List<MemberCartVO> cartList(MemberVO mvo);
	public int cartInsert(MemberCartVO mvco);
	public MemberCartVO getCart(int gc_num);
	public int cartDelete(MemberCartVO mvco);
	public int cartUpdate(MemberCartVO mvco);
	public int getCartNum();

}
