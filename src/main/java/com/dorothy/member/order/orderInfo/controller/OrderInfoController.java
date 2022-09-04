package com.dorothy.member.order.orderInfo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.login.vo.MemberVO;
import com.dorothy.member.order.orderInfo.service.OrderInfoService;
import com.dorothy.member.order.orderInfo.vo.OrderInfoDTO;
import com.dorothy.member.order.orderInfo.vo.OrderInfoVO;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping(value="/member/order/*")
@AllArgsConstructor
public class OrderInfoController {
	
	private OrderInfoService orderInfoService;
	
	/***********************************************************
	 * 주문 리스트
	 * 요청 URL : http://localhost:8080/member/order/orderInfoList
	 ***********************************************************/
	@RequestMapping(value="/orderInfoList", method = RequestMethod.GET)
	public String orderInfoList(@ModelAttribute("data") OrderInfoVO  ovo,  HttpServletRequest req, Model model) {
		log.info("OrderInfoList 호출 성공");
		
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		
		int total = orderInfoService.orderInfoListCnt(ovo);
		model.addAttribute("pageMaker", new PageDTO(ovo, total));
		
		int count = total - (ovo.getPageNum()-1) * ovo.getAmount();
		model.addAttribute("count", count);
		
		List<OrderInfoVO> orderInfoList = orderInfoService.orderInfoList(mvo);
		model.addAttribute("orderInfoList", orderInfoList);
		
		return "member/order/orderInfoList";
	}
	
	/***********************************************************
	 * 주문 상세보기 구현
	 * 요청 URL : http://localhost:8080/member/order/orderInfoDetail
	 ***********************************************************/
	@RequestMapping(value="/orderInfoDetail", method=RequestMethod.GET)
//	@GetMapping("/orderInfoDetail")
	public String orderInfoDetail(@ModelAttribute("data") OrderInfoVO ovo, Model model) {
		log.info("orderInfoDetail 호출 성공");
		
		
		OrderInfoDTO detail = orderInfoService.orderInfoDetail(ovo);
		model.addAttribute("detail", detail);
		
		return "member/order/orderInfoDetail";
	}
}
