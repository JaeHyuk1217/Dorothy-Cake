package com.dorothy.member.board.qna.dao;

import java.util.List;


import com.dorothy.member.board.qna.vo.BoardVO;
import com.dorothy.member.login.vo.MemberVO;



public interface BoardDao {
	public List<BoardVO> boardList(BoardVO bvo);

	/* public List<BoardVO> myBoardList(BoardVO bvo); */
	
	public int boardListCnt(BoardVO  bvo); // board 테이블의 전체 레코드 수
	public int boardInsert(BoardVO bvo);
	public BoardVO boardDetail(BoardVO bvo);
	public int readcntUpdate(BoardVO bvo);
	public int pwdConfirm(BoardVO bvo);
	public int boardDelete(BoardVO bvo);
	public int boardUpdate(BoardVO bvo);
	public BoardVO deleteVO(int q_num);
	public int boardMyList(BoardVO bvo);

	public List<BoardVO> myList(MemberVO mvo);
}
