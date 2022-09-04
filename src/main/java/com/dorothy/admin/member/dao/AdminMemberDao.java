package com.dorothy.admin.member.dao;

import java.util.List;

import com.dorothy.member.login.vo.MemberVO;

public interface AdminMemberDao {
	public List<MemberVO> adminMemberList(MemberVO vo);
	public int adminMemberListCnt(MemberVO vo);
	public int adminMemberUpdate(MemberVO vo);
}
