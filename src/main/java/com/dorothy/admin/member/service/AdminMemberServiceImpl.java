package com.dorothy.admin.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.member.dao.AdminMemberDao;
import com.dorothy.member.login.vo.MemberVO;

import lombok.Setter;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberDao adminMemberDao;
	
	@Override
	public List<MemberVO> adminMemberList(MemberVO vo) {
		List<MemberVO> list = null;
		list = adminMemberDao.adminMemberList(vo);
		return list;
	}

	@Override
	public int adminMemberListCnt(MemberVO vo) {
		return adminMemberDao.adminMemberListCnt(vo);
	}
	//회원추방
	@Override
	public int adminMemberUpdate(MemberVO vo) throws Exception {
		int result = 0;
		
		result = adminMemberDao.adminMemberUpdate(vo);
		return result;
	}
	

}
