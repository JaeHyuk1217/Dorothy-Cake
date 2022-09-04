package com.dorothy.member.payment.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.member.cart.dao.MemberCartDao;
import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.order.orderInfo.dao.OrderInfoDao;
import com.dorothy.member.payment.dao.PaymentDao;
import com.dorothy.member.payment.vo.OrderDTO;
import com.dorothy.member.payment.vo.PaymentDTO;
import com.dorothy.member.payment.vo.PaymentVO;

import lombok.Setter;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Setter(onMethod_ = @Autowired)
	private PaymentDao paymentDao;
	
	@Setter(onMethod_ = @Autowired)
	private MemberCartDao cartDao;
	
	@Setter(onMethod_ = @Autowired)
	private OrderInfoDao orderDao;
	
	// 주문번호 생성
	@Override
	public String makeUid() {
		String p_merchant_uid = paymentDao.makeUid();
		return p_merchant_uid;
	}
	
	//카트 정보 받기
	@Override
	public List<MemberCartVO> getCart(String codeArr) {
		String[] code = codeArr.split(",");
		
		List<MemberCartVO> cartList = new ArrayList<MemberCartVO>();
		
		for(int i = 0 ; i < code.length ; i++) {
			int gc_num = Integer.parseInt(code[i]);
			MemberCartVO cvo = cartDao.getCart(gc_num);
			cartList.add(cvo);
			
			cartDao.cartDelete(cvo);
		}
		return cartList;
	}
	
	// 결제 성공
	@Override
	public int paymentSuccess(PaymentVO pvo) {
		int result = paymentDao.paymentSuccess(pvo);
		
		return result;
	}
	
	// 주문번호 저장
	@Override
	public int orderInsert(PaymentDTO pdto) {
		String p_merchant_uid = pdto.getP_merchant_uid();
		String m_id = pdto.getM_id();
		String[] code = pdto.getGc_num().split(",");
		int result = 0;
		
		for(int i = 0 ; i < code.length ; i++) {
			int gc_num = Integer.parseInt(code[i]);
			MemberCartVO cvo = cartDao.getCart(gc_num);
			OrderDTO order = new OrderDTO();
			order.setP_merchant_uid(p_merchant_uid);
			order.setM_id(m_id);
			order.setG_name(cvo.getG_name());
			order.setG_size(cvo.getG_size());
			order.setGc_amount(cvo.getGc_amount());
			order.setG_price(cvo.getG_price());
			result = orderDao.orderInsert(order);
		}
		
		return result;
	}
}
