package com.dorothy.member.payment.service;

import java.util.List;

import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.payment.vo.PaymentDTO;
import com.dorothy.member.payment.vo.PaymentVO;

public interface PaymentService {
	public String makeUid();
	public List<MemberCartVO> getCart(String codeArr);
	public int paymentSuccess(PaymentVO pvo);
	public int orderInsert(PaymentDTO pdto);
}
