package com.dorothy.member.payment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.payment.service.PaymentService;
import com.dorothy.member.payment.vo.PaymentDTO;
import com.dorothy.member.payment.vo.PaymentVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/payment")
@AllArgsConstructor
public class PaymentController {
	private PaymentService paymentService;
	
	/***********************************************************
	 * 결제 페이지 호출
	 * 요청 URL : http://localhost:8080/payment/paymentPage
	 ***********************************************************/
	@RequestMapping(value="paymentPage")
	public String paymentPage(HttpServletRequest request, Model model) {
		log.info("paymentPage 호출 성공");
		
		String codeArr = request.getParameter("codeList");
		
		List<MemberCartVO> cartList = paymentService.getCart(codeArr);
		model.addAttribute("cartList", cartList);
		
		return "member/payment/payment";
	}
	
	/***********************************************************
	 * 주문번호 생성
	 * 요청 URL : http://localhost:8080/payment/makeUid
	 ***********************************************************/
	@ResponseBody
	@RequestMapping(value="/makeUid", method = RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String makeUid() {
		log.info("makeUid 호출 성공");
		
		String p_merchant_uid = paymentService.makeUid();
		
		return p_merchant_uid;
	}
	
	/***********************************************************
	 * 결제 완료
	 * 요청 URL : http://localhost:8080/payment/paymentSuccess
	 ***********************************************************/
	@RequestMapping(value="paymentSuccess")
	public String paymentSuccess(@ModelAttribute("data") PaymentDTO pdto, Model model) {
		log.info("paymentSuccess 호출 성공");
		log.info(pdto.getGc_num());
		log.info(pdto.getP_merchant_uid());
		
		PaymentVO pvo = new PaymentVO();
		pvo.setP_merchant_uid(pdto.getP_merchant_uid());
		pvo.setM_id(pdto.getM_id());
		pvo.setP_price(pdto.getP_price());
		pvo.setP_name(pdto.getP_name());
		pvo.setP_state(pdto.getP_state());
		
		int result1 = paymentService.paymentSuccess(pvo);
		int result2 = paymentService.orderInsert(pdto);
		
		log.info("result1 = " + result1);
		log.info("result2 = " + result2);
		return "Dorothy";
	}
}
