package com.dorothy.member.cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dorothy.member.cart.service.MemberCartService;
import com.dorothy.member.cart.vo.MemberCartVO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/cart/*")
@AllArgsConstructor
public class MemberCartController {
	private MemberCartService memberCartService;
	
	@RequestMapping(value="/cartList", method = RequestMethod.GET)
	public String cartList(@ModelAttribute("data") MemberCartVO mvco, HttpServletRequest req, Model model) {
		log.info("cartList 호출 성공");

		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		
		List<MemberCartVO> cartList = memberCartService.cartList(mvo);
		model.addAttribute("cartList", cartList);
		
		int count = cartList.size();
		model.addAttribute("count", count);
		
		return "member/cart/cartList"; // /WEB-INF/views/member/cart/cartList.jsp
	}
	
	@RequestMapping(value="/goCart", method= RequestMethod.POST)
	public String goCart(@ModelAttribute("data") MemberCartVO mvco, HttpServletRequest req, Model model) {
		log.info("goCart 호출");
		String goPage = "";
		
		int result = 0;
		
		result = memberCartService.cartInsert(mvco);
		log.info(mvco.toString());
		if(result == 1) {
			goPage = cartList(mvco, req, model);
		}else {
			goPage = "member/goods/goodsDetail?" + mvco.getG_code();
		}
		
		return goPage;
	}
	
	@RequestMapping(value="/deleteAll", method = RequestMethod.POST)
	public String deleteAll(HttpServletRequest request) throws Exception {
		log.info("deleteAll 호출 성공");
		
		String[] numArr = request.getParameterValues("numArr");
		
		memberCartService.deleteAll(numArr);
		
		return "member/cart/cartList";		
	}
	
	@RequestMapping(value="/cartUpdate", method = RequestMethod.POST)
	public String cartUpdate(HttpServletRequest request) throws Exception {
		log.info("cartUpdate 호출 성공");
		
		int gc_num = Integer.parseInt(request.getParameter("changeGc_num"));
		int gc_amount = Integer.parseInt(request.getParameter("changeGc_amount"));
		
		MemberCartVO mvco = new MemberCartVO();
		mvco.setGc_num(gc_num);
		mvco.setGc_amount(gc_amount);
		
		memberCartService.cartUpdate(mvco);
		
		return "redirect:/member/cart/cartList";		
	}
	
	@RequestMapping(value="/goPayment", method = RequestMethod.POST)
	public String goPayment(@ModelAttribute("data") MemberCartVO mvco, HttpServletRequest req, Model model) {
		log.info("goPayment 호출 성공");
		
		memberCartService.cartInsert(mvco);
		int num = memberCartService.getCartNum();
		String gc_num = Integer.toString(num);
		

		req.setAttribute("codeList", gc_num);
		String data = (String) req.getAttribute("codeList");
		
		log.info(data);
		return "/member/cart/passData";
	}

}
