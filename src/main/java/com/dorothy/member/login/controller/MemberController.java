package com.dorothy.member.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.member.login.service.MemberService;
import com.dorothy.member.login.vo.MemberVO;



@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	@Inject
	MemberService service;

	
	// 회원 가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get register");
	}
	
	// 회원 가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("post register");
		
		service.register(vo);
		
		return "redirect:/";
		
	}
	// 아이디 중복체크
	@RequestMapping("/idcheck")
	@ResponseBody
	public Map<Object, Object> idcheck(@RequestBody String m_id) throws Exception {

		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = service.idcheck(m_id); 
		map.put("cnt", count);

		return map;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getLogin() throws Exception {
		logger.info("get login");
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		logger.info("post login");
		String url="";
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		
		if(login != null) {
			session.setAttribute("member", login);
			url="/";
		}else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			url = "login";
		}
		return "redirect:"+url;
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		
		session.invalidate();
		
		return "redirect:/";
	}
	//마이 페이지 이동
	@RequestMapping(value="/member/MyPage", method = RequestMethod.GET)
	public String mypage() throws Exception{
		logger.info("get mypage");
		
		return "member/MyPage";
	}
	
	// 회원정보 수정
	@RequestMapping(value="/member/profileUpdate", method = RequestMethod.GET)
	public String memberUpdateView() throws Exception{
		logger.info("get profile");
		
		return "member/profileUpdate";
	}

	@RequestMapping(value="/memberUpdate", method = RequestMethod.POST)
	public String memberUpdate(MemberVO vo, HttpSession session) throws Exception{
		
		service.memberUpdate(vo);
		
		session.invalidate();
		
		return "redirect:/member/login";
	}
	
	
}
