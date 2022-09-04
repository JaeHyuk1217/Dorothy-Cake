package com.dorothy.admin.member.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.admin.member.service.AdminMemberService;
import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/member")
@AllArgsConstructor
public class AdminMemberController {
	private AdminMemberService adminMemberService;
	
	/*회원 목록 리스트 출력*/
	@RequestMapping(value="/adminMemberList", method = RequestMethod.GET)
	public String adminMemberList(@ModelAttribute("data") MemberVO vo, Model model) {
		log.info("adminMemberList 출력");
		
		List<MemberVO> adminMemberList = adminMemberService.adminMemberList(vo);
		model.addAttribute("adminMemberList", adminMemberList);
		log.info("adminMemberList"+ adminMemberList);
		
		int total = adminMemberService.adminMemberListCnt(vo);

		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		return "admin/member/adminMemberList"; // /WEB-INF/views/admin/member/adminMemberList.jsp
	}
	
	/*회원 강제추방*/
	@RequestMapping(value="/adminMemberUpdate", method = RequestMethod.POST)
	public String adminMemberUpdate(@ModelAttribute MemberVO vo, RedirectAttributes ras) throws Exception {
		log.info("get adminMemberUpdate");
		
		int result = 0;
		String url ="";
		
		result = adminMemberService.adminMemberUpdate(vo);
		ras.addFlashAttribute("data", vo);
		
		/* return "admin/member/adminMemberList"; */
		
		if(result == 1) {
			url = "/admin/member/adminMemberList";
		}else {
			url = "/admin/member/adminMemberList";
		}
		
		return "redirect:" + url;
		
	}

}
