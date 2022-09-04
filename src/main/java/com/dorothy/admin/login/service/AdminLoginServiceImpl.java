package com.dorothy.admin.login.service;

import org.springframework.stereotype.Service;

import com.dorothy.admin.login.dao.AdminLoginDAO;
import com.dorothy.admin.login.vo.AdminLoginVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminLoginServiceImpl implements AdminLoginService {

	private AdminLoginDAO adminLoginDAO;

	@Override
	public AdminLoginVO loginProcess(AdminLoginVO login) {
		AdminLoginVO adminLogin = adminLoginDAO.loginProcess(login);
		
		return adminLogin;
	}
}