package com.dorothy.member.login.service;

import com.dorothy.member.login.vo.MemberVO;

public interface MemberService {
	
	// 회원 가입
	public void register(MemberVO vo) throws Exception;
	
	// 로그인
	public MemberVO login(MemberVO vo) throws Exception;
	
	//마이페이지
	public MemberVO mypage(MemberVO vo) throws Exception;
	
	//회원정보수정
	public void memberUpdate(MemberVO vo) throws Exception;
	
	//아이디 중복체크
	public int idcheck(String m_id) throws Exception;

}
