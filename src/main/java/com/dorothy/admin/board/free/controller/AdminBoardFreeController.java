package com.dorothy.admin.board.free.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.admin.board.free.service.AdminBoardFreeService;
import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.board.free.vo.BoardFreeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/admin/board/free/*")
@Log4j
public class AdminBoardFreeController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminBoardFreeService adminBoardService;
	
	/***********************************************************
	 * 관리자 자유게시판 글 목록 구현
	 * 요청 URL : http://localhost:8080/admin/board/free/boardFreeList
	 ***********************************************************/
	@RequestMapping(value="/boardFreeList", method = RequestMethod.GET)
	public String boardFreeList(@ModelAttribute("data") BoardFreeVO bfvo, Model model) {
		log.info("admin boardFreeList 호출 성공");
		
		List<BoardFreeVO> boardFreeList = adminBoardService.boardFreeList(bfvo);
		model.addAttribute("boardFreeList", boardFreeList);
		
		// 전체 레코드수 구현
		int total = adminBoardService.boardFreeListCnt(bfvo);
		model.addAttribute("pageMaker", new PageDTO(bfvo, total));
		
		int count = total - (bfvo.getPageNum() - 1) * bfvo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/board/free/boardFreeList"; // /WEB-INF/views/admin/board/free/boardFreeList.jsp
	}
	
	/***********************************************************
	 * 관리자 자유게시판 글 상세보기 구현
	 * 요청 URL : http://localhost:8080/admin/board/free/boardFreeList
	 ***********************************************************/
	@RequestMapping(value="/boardFreeDetail", method = RequestMethod.GET)
	public String boardFreeDetail(@ModelAttribute("data") BoardFreeVO bfvo, Model model) {
		log.info("admin boardFreeDetail 호출 성공");
		
		BoardFreeVO bfDetail = adminBoardService.boardFreeDetail(bfvo);
		model.addAttribute("bfDetail", bfDetail);
		
		return "admin/board/free/boardFreeDetail";
	}
	
	/***********************************************************
	 * 관리자 자유게시판 선택한 글 삭제 구현
	 * 요청 URL : http://localhost:8080/admin/board/free/deleteAll
	 ***********************************************************/
	@RequestMapping(value="/deleteAll", method = RequestMethod.POST)
	public String deleteAll(HttpServletRequest request) throws Exception {
		log.info("deleteAll 호출 성공");
		
		String[] numArr = request.getParameterValues("numArr");
		
		adminBoardService.deleteAll(numArr);
		
		return "/admin/board/free/boardFreeList";		
	}
	/***********************************************************
	 * 관리자 자유게시판 상세페이지 글 삭제 구현
	 * 요청 URL : http://localhost:8080/admin/board/free/boardFreeDelete
	 ***********************************************************/
	@RequestMapping(value="boardFreeDelete", method = RequestMethod.POST)
	public String boardFreeDelete(@ModelAttribute BoardFreeVO bfvo, RedirectAttributes ras) throws Exception {
		log.info("admin boardFreeDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminBoardService.boardFreeDelete(bfvo);
		ras.addFlashAttribute("boardFreeVO", bfvo);
		
		if(result == 1) {
			url = "/admin/board/free/boardFreeList";
		}else {
			url = "/admin/board/free/boardFreeDetail";
		}
		
		return "redirect:" + url;
	}
}
