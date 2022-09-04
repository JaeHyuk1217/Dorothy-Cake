package com.dorothy.admin.event.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.admin.event.service.AdminEventService;
import com.dorothy.common.vo.PageDTO;
//import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.board.event.vo.EventVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/admin/board/*")
@Log4j
public class AdminEventController {
	
	@Setter(onMethod_=@Autowired)
	private AdminEventService adminEventService;
	
	/*글목록 구현*/
	@RequestMapping(value="/event/adminEventList", method=RequestMethod.GET)
	public String adminEventList(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("get adminEventList");
		
		List<EventVO> adminEventList = adminEventService.eventList(evo);
		model.addAttribute("adminEventList", adminEventList);
		
		/*전체 레코드 수 구현*/
		int total = adminEventService.eventListCnt(evo);
		model.addAttribute("pageMaker", new PageDTO(evo, total));
		
		int count = total - (evo.getPageNum()-1) * evo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/board/event/adminEventList";
	}
	
	/**************************************************************************
	 * 글쓰기 폼 출력
	 **************************************************************************/
	@RequestMapping(value="/event/adminEventWrite")
	public String adminEventWrite(@ModelAttribute("data") EventVO evo) {
		log.info("adminEventWrite 호출 성공");
		
		return "admin/board/event/adminEventWrite";
	}
	/**************************************************************************
	 * 글쓰기 구현
	 **************************************************************************/
	@RequestMapping(value="/eventInsert", method = RequestMethod.POST)
	public String eventInsert(EventVO evo, Model model) throws Exception{
		log.info("eventInsert 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminEventService.eventInsert(evo);
		if(result==1) {
			url="/admin/board/event/adminEventList";
		} else {
			url="/admin/board/event/adminEventWrite";
		}
		return "redirect:"+url;
	}
	/*상세 페이지 구현*/
	@RequestMapping(value="/event/adminEventDetail", method = RequestMethod.GET)
	public String adminEventDetail(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("get adminEventDetail");
		
		EventVO Detail = adminEventService.eventDetail(evo);
		model.addAttribute("Detail", Detail);
		
		return "admin/board/event/adminEventDetail";
	}
	
	/*체크박스 삭제 구현*/
	@RequestMapping(value="/event/deleteAll", method = RequestMethod.GET)
	public String deleteAll(HttpServletRequest request) throws Exception {
		log.info("get deleteAll");
		
		String[] numArr = request.getParameterValues("numArr");
		
		adminEventService.deleteAll(numArr);
		
		return "admin/board/event/adminEventList";		
	}
	
	/*체크박스 삭제 구현*/
	@RequestMapping(value="eventDelete", method = RequestMethod.POST)
	public String eventDelete(@ModelAttribute EventVO evo, RedirectAttributes ras) throws Exception {
		log.info("admin boardFreeDelete 호출");
		
		int result = 0;
		String url = "";
		
		result = adminEventService.eventDelete(evo);
		ras.addFlashAttribute("eventVO", evo);
		
		if(result == 1) {
			url = "admin/board/event/adminEventList";
		}else {
			url = "admin/board/event/adminEventDetail";
		}
		
		return "redirect:" + url;
	}
	/*수정 출력*/
	@RequestMapping(value="/event/adminEventUpdate")
	public String adminEventUpdate(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("adminEventUpdate 호출 성공");
		log.info("e_num : " +evo.getE_num());
		
		EventVO updateData = adminEventService.adminEventUpdate(evo);
		model.addAttribute("updateData", updateData);
		
		return "admin/board/event/adminEventUpdate";
	}
	
	/*글 수정 구현*/
	@RequestMapping(value="/event/eventUpdate", method=RequestMethod.POST)
	public String eventUpdate(@ModelAttribute EventVO evo, RedirectAttributes ras) throws Exception{
		log.info("eventUpdate 호출 성공");
		
		int result = 0;
		String url="";
		
		result = adminEventService.eventUpdate(evo);
		ras.addFlashAttribute("data", evo);
		
		if(result==1) {
			//아래 url은 수정후 상세페이지로 이동
			url="adminEventList";
		}else {
			url="adminEventUpdate";
		}
		
		return "redirect:"+url; // redirect:  << 이후 공백이생기면 오류
	}
}
