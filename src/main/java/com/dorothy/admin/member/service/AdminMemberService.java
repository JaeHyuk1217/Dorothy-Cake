package com.dorothy.admin.member.service;

import java.util.List;

import com.dorothy.member.login.vo.MemberVO;

public interface AdminMemberService {
	public List<MemberVO> adminMemberList(MemberVO vo);
	public int adminMemberListCnt(MemberVO vo);
	
	//회원 추방
	public int adminMemberUpdate(MemberVO vo)throws Exception;

}
