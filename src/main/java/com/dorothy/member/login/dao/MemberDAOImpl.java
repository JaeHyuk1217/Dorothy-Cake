package com.dorothy.member.login.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import com.dorothy.member.login.vo.MemberVO;

public class MemberDAOImpl implements MemberDAO {

	@Inject SqlSession sql;
	
	@Override
	public void register(MemberVO vo) throws Exception {
		sql.insert("Member.register", vo);
		
	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		
		return sql.selectOne("Member.login", vo);
	}

	@Override
	public MemberVO mypage(MemberVO vo) throws Exception {
		return null;
	}

	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		sql.update("Member.memberUpdate", vo);
	}
	
	// 아이디 중복체크
	@Override
	public int idcheck(String m_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
