package com.dorothy.admin.order.customOrder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dorothy.admin.goods.service.AdminGoodsService;
import com.dorothy.admin.order.customOrder.service.AdminCustomOrderService;

import com.dorothy.common.vo.PageDTO;

import com.dorothy.member.goods.vo.MemberGoodsVO;
import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/admin/board/customOrder/*")
@Log4j
public class AdminCustomOrderController {

	@Setter(onMethod_ = @Autowired)
	private AdminCustomOrderService adminCustomOrderService;
	
	@Setter(onMethod_ = @Autowired)
	private AdminGoodsService adminGoodsService;

	
	/***********************************************************
	 * 관리자 커스텀 제품 주문 게시판 글 목록 구현
	 * 요청 URL : http://localhost:8081/admin/board/customOrder/customOrderList
	 ***********************************************************/
	@RequestMapping(value="/customOrderList", method = RequestMethod.GET)
	public String customOrderList(@ModelAttribute("data") CustomOrderBoardVO cobvo, Model model) {
		log.info("admin customOrderList 호출 성공");

		// 전체 레코드 조회
		List<CustomOrderBoardVO> customOrderList = adminCustomOrderService.customOrderList(cobvo);
		model.addAttribute("customOrderList", customOrderList);
		
		// 전체 레코드수 구현
		int total = adminCustomOrderService.customOrderListCnt(cobvo);
		
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(cobvo, total));
		
		int count = total - (cobvo.getPageNum() - 1) * cobvo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/board/customOrder/customOrderList"; // /WEB-INF/views/admin/board/customOrder/customOrderList.jsp
		
	}
	
	/***********************************************************
	 * 관리자 커스텀 제품 주문 게시판 글 상세보기 구현
	 * 요청 URL : http://localhost:8081/board/customOrder/customOrderDetail
	 ***********************************************************/
	@RequestMapping(value="/customOrderDetail", method = RequestMethod.GET)
	public String customOrderDetail(@ModelAttribute("data") CustomOrderBoardVO cobvo, Model model) {
		log.info("customOrderDetail 호출 성공");

		CustomOrderBoardVO customOrderDetail = adminCustomOrderService.customOrderDetail(cobvo);
		model.addAttribute("customOrderDetail", customOrderDetail);
		
		return "admin/board/customOrder/customOrderDetail"; // /WEB-INF/views/admin/board/customOrder/customOrderDetail.jsp
	}
	
	/***********************************************************
	 * 관리자 커스텀 제품 주문 게시판 가격 수정 폼 출력
	 * 요청 URL : http://localhost:8081/board/customOrder/customOrderPriceupdate
	 
	 ***********************************************************/
	@RequestMapping(value="/customOrderPriceupdate", method = RequestMethod.POST)
	public String customOrderPriceupdate(@ModelAttribute("data") CustomOrderBoardVO cobvo, Model model) {
		log.info("customOrderPriceupdate 호출 성공");
		log.info(cobvo);
		
		log.info("c_num" + cobvo.getC_num());
		
		/* 가격 업데이트 */
		int updateData = adminCustomOrderService.customOrderPriceupdate(cobvo);
		log.info(updateData);
		
		return "redirect:/admin/board/customOrder/customOrderDetail?c_num="+cobvo.getC_num();
		
	}
	
	/***********************************************************
	 * 관리자 커스텀 제품 상품등록
	 * 요청 URL : http://localhost:8081/board/customOrder/customOrderGoodsInsert
	 * @throws Exception 
	 ***********************************************************/
	
	@RequestMapping(value="/customOrderGoodsInsert", method = RequestMethod.POST)
	public String customOrderGoodsInsert( MemberGoodsVO mgvo, Model model) throws Exception {
		log.info("customOrderGoodsInsert 호출 성공");
		
		log.info(mgvo);
		
		/* 커스텀 제품 상품 등록 */
		int resultData = adminGoodsService.customOrderGoodsInsert(mgvo);
		log.info(resultData);
		
		return "redirect:/admin/goods/goodsList";
		
		
	}
	
	
	
}
