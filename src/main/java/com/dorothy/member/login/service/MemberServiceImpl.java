package com.dorothy.member.login.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.dorothy.member.login.dao.MemberDAO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Inject MemberDAO dao;
	
	//회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		dao.register(vo);
		
	}
	//로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	}
	//마이 페이지
	@Override
	public MemberVO mypage(MemberVO vo) throws Exception {
		return dao.mypage(vo);
	}
	
	//회원정보 수정
	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		dao.memberUpdate(vo);
		
	}
	@Override
	public int idcheck(String m_id) throws Exception {
		return dao.idcheck(m_id);
	}

}
