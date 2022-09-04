package com.dorothy.policy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/policy")
public class PolicyController {
	@RequestMapping(value="/term")
	public String term() {
		return "member/policy/term";
	}
	
	@RequestMapping(value="/privacy")
	public String privacy() {
		return "member/policy/privacy";
	}
	
	@RequestMapping(value="/emailSecurity")
	public String emailSecurity() {
		return "member/policy/emailSecurity";
	}
}
