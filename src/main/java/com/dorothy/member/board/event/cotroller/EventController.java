package com.dorothy.member.board.event.cotroller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.board.event.service.EventService;
import com.dorothy.member.board.event.vo.EventVO;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/event")
@AllArgsConstructor
public class EventController {
	
	private EventService eventService;
	
	/**글 목록 구현
	@GetMapping("/eventList")
	public String eventList() {
		log.info("admin 로그인 화면 호출");
		
		return "member/event/eventList"; //WEB-INF/views/member/event/eventList.jsp로 포워드
	}*/
	@RequestMapping(value="/eventList", method = RequestMethod.GET)
	public String eventList(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("eventList 호출성공");
		// 전체레코드 조회
		List<EventVO> eventList = eventService.eventList(evo);
		model.addAttribute("eventList", eventList);
		
		//전체 레코드수 반환.
		int total = eventService.eventListCnt(evo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(evo, total));
		
		return "member/event/eventList";
	}
		
	/**************************************************************************
	 * 글쓰기 폼 출력
	 **************************************************************************/
	@RequestMapping(value="/writeForm")
	public String writeForm(@ModelAttribute("data") EventVO evo) {
		log.info("writeForm 호출");
		
		return "member/event/writeForm";
	}
	/**************************************************************************
	 * 글쓰기 구현
	 **************************************************************************/
	@RequestMapping(value="/eventInsert", method = RequestMethod.POST)
	public String eventInsert(EventVO evo, Model model) throws Exception{
		log.info("eventInsert 호출");
		
		int result = 0;
		String url = "";
		
		result = eventService.eventInsert(evo);
		if(result==1) {
			url="/member/event/eventList";
		} else {
			url="/member/event/writeForm";
		}
		return "redirect:"+url;
	}
	
	/**************************************************************************
	 *글 상세보기 
	 **************************************************************************/
	@RequestMapping(value="/eventDetail", method = RequestMethod.GET)
	public String eventDetail(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("eventDetail 호출");
		
		EventVO detail = eventService.eventDetail(evo);
		model.addAttribute("detail", detail);
		log.info("detail" + detail);
		
		return "member/event/eventDetail";
	}
	/*@GetMapping(value="/event/eventDetail")
	public String eventDetail(EventVO evo, Model model) {
		log.info("eventDetail 호출");

		EventVO detail = eventService.eventDetail(evo);
		model.addAttribute("detail", detail);
		log.info("detail" + detail);

		
		return "member/event/eventDetail"; 
	}*/
	
	/**************************************************************************
	 * 글 수정 폼 출력
	 ***************************************************************************/
	@RequestMapping(value="/updateForm")
	public String updateForm(@ModelAttribute("data") EventVO evo, Model model) {
		log.info("updateForm 호출");
		log.info("e_num = " + evo.getE_num());
		
		EventVO updateData = eventService.updateForm(evo);
		
		model.addAttribute("updateData", updateData);
		return "member/event/updateForm";
	}
	
	/**************************************************************************
	 * 글 수정 구현
	 **************************************************************************/
	@RequestMapping(value="/eventUpdate", method=RequestMethod.POST)
	public String eventUpdate(@ModelAttribute EventVO evo, RedirectAttributes ras) throws Exception{
		log.info("eventUpdate 호출");
		
		int result = 0;
		String url="";
		
		result = eventService.eventUpdate(evo);
		ras.addFlashAttribute("data", evo);
		
		if(result==1) {
			
			url="/member/event/eventDetail";
		}else {
			url="/member/event/updateForm";
		}
		
		return "redirect:"+url;
	}
	/**************************************************************************
	 * 글 삭제구현
	 **************************************************************************/
	@RequestMapping(value="/eventDelete")
	public String eventDelete(@ModelAttribute EventVO evo, RedirectAttributes ras) throws Exception{
		log.info("eventDelete 호출");
		
		
		int result = 0;
		String url="";
		
		result = eventService.eventDelete(evo);
		ras.addFlashAttribute("EventVO", evo);
		
		if(result==1) {
			url="/member/event/eventList";
		}else {
			url="/member/event/eventDetail";
		}
		return "redirect:"+url;
	}

}
