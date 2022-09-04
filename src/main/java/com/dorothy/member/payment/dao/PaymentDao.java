package com.dorothy.member.payment.dao;

import java.util.List;

import com.dorothy.member.payment.vo.PaymentVO;

public interface PaymentDao {
	public String makeUid();
	public List<PaymentVO> paymentList(PaymentVO pvo);
	public int paymentListCnt(PaymentVO pvo);
	public int paymentSuccess(PaymentVO pvo);
	public int paymentCancel(PaymentVO pvo);
	public List<PaymentVO> paymentListExcel(PaymentVO pvo); 
}
