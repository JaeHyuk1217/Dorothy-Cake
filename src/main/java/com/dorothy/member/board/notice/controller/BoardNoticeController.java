package com.dorothy.member.board.notice.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.board.notice.service.BoardNoticeService;
import com.dorothy.member.board.notice.vo.BoardNoticeVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/notice/*")
@AllArgsConstructor
public class BoardNoticeController {
	
	private BoardNoticeService boardNoticeService;
	
	@RequestMapping(value="/boardNoticeList", method = RequestMethod.GET)
	public String boardNoticeList(@ModelAttribute("data") BoardNoticeVO nvo, Model model) {
		log.info("boardNoticeList 호출 성공");
		
		// 전체 레코드 조회
		List<BoardNoticeVO> boardNoticeList = boardNoticeService.boardNoticeList(nvo);
		model.addAttribute("boardNoticeList", boardNoticeList);
		
		// 전체 레코드 수
		int total = boardNoticeService.boardNoticeListCnt(nvo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(nvo, total));
		
		return "member/board/notice/boardNoticeList"; // /WEB-INF/views/member/board/notice/boardNoticeList.jsp
	}
	
	@RequestMapping(value="/boardNoticeDetail", method = RequestMethod.GET)
	public String boardNoticeDetail(@ModelAttribute("data") BoardNoticeVO nvo, Model model) {
		log.info("boardNoticeDetail 호출 성공");
		
		BoardNoticeVO bnDetail = boardNoticeService.boardNoticeDetail(nvo);
		model.addAttribute("bnDetail", bnDetail);
		
		return "member/board/notice/boardNoticeDetail";
	}
}
