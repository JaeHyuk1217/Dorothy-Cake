package com.dorothy.admin.order.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.payment.dao.PaymentDao;
import com.dorothy.member.payment.vo.PaymentVO;

import lombok.Setter;

@Service
public class AdminPaymentServiceImpl implements AdminPaymentService {
	
	@Setter(onMethod_ = @Autowired)
	private PaymentDao paymentDao;
	
	@Override
	public List<PaymentVO> paymentList(PaymentVO pvo) {
		List<PaymentVO> list = null;
		list = paymentDao.paymentList(pvo);
		return list;
	}

	@Override
	public int paymentListCnt(PaymentVO pvo) {
		return paymentDao.paymentListCnt(pvo);
	}

	@Override
	public int paymentCancel(PaymentVO pvo) {
		int result = paymentDao.paymentCancel(pvo);
		return result;
	}

	@Override
	public List<PaymentVO> paymentListExcel(PaymentVO pvo) {
		List<PaymentVO> paymentList = paymentDao.paymentListExcel(pvo);
		return paymentList;
	}

}
