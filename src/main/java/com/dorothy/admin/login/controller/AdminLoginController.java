package com.dorothy.admin.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.admin.login.service.AdminLoginService;
import com.dorothy.admin.login.vo.AdminLoginVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@SessionAttributes("adminLogin")
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
class AdminLoginController {
	
	private AdminLoginService adminLoginService;
	
	
	public AdminLoginVO adminLogin() {
		return new AdminLoginVO();
	}
	
	/*濡쒓렇�씤 �솕硫�*/
	@GetMapping("/login")
	public String loginForm() {
		log.info("admin 濡쒓렇�씤 �솕硫� �샇異�");
		
		return "admin/adminLogin"; //WEB-INF/views/admin/adminLogin.jsp濡� �룷�썙�뱶
	}
	/*濡쒓렇�씤 泥섎━*/
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public void getLogin() throws Exception {
		log.info("get login");

	}
	@PostMapping("/login")
	public String loginProcess(AdminLoginVO login, Model model, RedirectAttributes ras) {
		String url = "";
		AdminLoginVO adminLogin = adminLoginService.loginProcess(login);
		
		if(adminLogin != null) {
			model.addAttribute("adminLogin", adminLogin);
			url = "/admin/goods/goodsList";
		}else {
			ras.addFlashAttribute("errorMsg", "濡쒓렇�씤 �떎�뙣");
			url = "/admin/adminLogin";
		}
		return "redirect:"+url;
	}
	
	/* 濡쒓렇 �븘�썐*/
	@RequestMapping("/adminMain")
	public String logout(SessionStatus sessionStatus) {
		log.info("admin 濡쒓렇�븘�썐 泥섎━");
		sessionStatus.setComplete();
		return "redirect:/admin/login";
	}

}