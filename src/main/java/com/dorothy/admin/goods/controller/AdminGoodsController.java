package com.dorothy.admin.goods.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.admin.goods.service.AdminGoodsService;
import com.dorothy.common.excel.ListExcelView;
import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.goods.vo.MemberGoodsVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/admin/goods")
@AllArgsConstructor
@Log4j
public class AdminGoodsController {
	
	private AdminGoodsService adminGoodsService;
	
	@RequestMapping(value="/goodsList", method = RequestMethod.GET)
	public String goodsList(@ModelAttribute("data") MemberGoodsVO gvo, Model model){
		log.info("goodsList 호출 성공");

		List<MemberGoodsVO> goodsList = adminGoodsService.goodsList(gvo);
		model.addAttribute("goodsList", goodsList);
		
		// 전체 레코드 수
		int total = adminGoodsService.goodsListCnt(gvo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(gvo, total));
		
		return "admin/goods/goodsList"; // /WEB-INF/views/member/goods/goodsList.jsp
	}
	
	@RequestMapping(value="/goodsDetail", method = RequestMethod.GET)
	public String goodsDetail(@ModelAttribute("data") MemberGoodsVO gvo, Model model) {
		log.info("goodsDetail 호출 성공");
		
		MemberGoodsVO detail = adminGoodsService.goodsDetail(gvo);
		model.addAttribute("detail", detail);
		
		return "admin/goods/goodsDetail"; // /WEB-INF/views/admin/goods/goodsDetail.jsp
	}
	
	@RequestMapping(value="/goodsDelete", method = RequestMethod.POST)
	public String goodsDelete(@ModelAttribute MemberGoodsVO gvo, RedirectAttributes ras) throws Exception {
		log.info("goodsDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminGoodsService.goodsDelete(gvo);
		ras.addFlashAttribute("GoodsVO", gvo);
		
		if(result == 1) {
			url = "/admin/goods/goodsList";
		}else {
			url = "/admin/goods/goodsDetail";
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value="/deleteAll", method = RequestMethod.POST)
	public String deleteAll(HttpServletRequest request) throws Exception {
		log.info("deleteAll 호출 성공");
		
		String[] numArr = request.getParameterValues("numArr");
		
		adminGoodsService.deleteAll(numArr);
		
		return "/admin/goods/goodsList";		
	}
	
	@RequestMapping(value="/goodsUpdateForm")
	public String goodsUpdateForm(@ModelAttribute("data") MemberGoodsVO gvo, Model model) throws Exception {
		log.info("goodsUpdateForm 호출 성공");
		log.info("g_code : " +gvo.getG_code());
		
		MemberGoodsVO updateData = adminGoodsService.goodsUpateForm(gvo);
		
		model.addAttribute("updateData", updateData);
		
		return "admin/goods/goodsUpdateForm";
	}
	
	@RequestMapping(value="/goodsUpdate", method = RequestMethod.POST)
	public String goodsUpdate(@ModelAttribute MemberGoodsVO gvo, RedirectAttributes ras) throws Exception {
		log.info("goodsUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminGoodsService.goodsUpdate(gvo);
		ras.addFlashAttribute("data", gvo);
		
		if(result == 1) {
			url = "/admin/goods/goodsDetail";
		}else {
			url = "/admin/goods/goodsUpdateForm";
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value="/goodsInsert", method = RequestMethod.POST)
	public String goodsInsert(MemberGoodsVO gvo, Model model) throws Exception {
		log.info("goodsInsert 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminGoodsService.goodsInsert(gvo);
		if(result == 1) {
			url = "/admin/goods/goodsList";
		}else {
			url = "/admin/goods/goodsInsertForm";
		}
		
		return "redirect:" + url;
	}
	
	@RequestMapping(value="/goodsInsertForm")
	public String goodsInsertForm(@ModelAttribute("data") MemberGoodsVO gvo) {
		log.info("goodsInsertForm 호출 성공");
		
		return "admin/goods/goodsInsertForm"; // /WEB-INF/views/admin/goods/goodsInsertForm.jsp
	}
	
	@RequestMapping(value="/goodsExcel", method=RequestMethod.GET)
	public ModelAndView goodsExcel(@ModelAttribute MemberGoodsVO gvo) {
		log.info("goodsExcel 호출");
		
		List<MemberGoodsVO> goodsList = adminGoodsService.goodsListExcel(gvo);
		
		ModelAndView mv = new ModelAndView(new ListExcelView());
		mv.addObject("goodsList", goodsList);
		mv.addObject("template", "goods.xlsx");
		mv.addObject("file_name", "goods");
		
		return mv;
	}
}
