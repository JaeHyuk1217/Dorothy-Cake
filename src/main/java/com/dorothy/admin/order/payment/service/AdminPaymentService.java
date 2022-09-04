package com.dorothy.admin.order.payment.service;

import java.util.List;

import com.dorothy.member.payment.vo.PaymentVO;

public interface AdminPaymentService {
	public List<PaymentVO> paymentList(PaymentVO pvo);
	public int paymentListCnt(PaymentVO pvo);
	public int paymentCancel(PaymentVO pvo);
	public List<PaymentVO> paymentListExcel(PaymentVO pvo);
}
