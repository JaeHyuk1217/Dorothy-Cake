package com.dorothy.member.board.qna.service;

import java.util.List;

import com.dorothy.member.board.qna.vo.BoardVO;
import com.dorothy.member.login.vo.MemberVO;



public interface BoardService {
	public List<BoardVO> boardList(BoardVO bvo);
	
	public List<BoardVO> boardMyList(BoardVO bvo);
	
	public int boardListCnt(BoardVO bvo);
	public int boardInsert(BoardVO bvo) throws Exception;
	public BoardVO boardDetail(BoardVO bvo);

	public int pwdConfirm(BoardVO bvo); 
	public int boardDelete(BoardVO bvo) throws Exception;
	public BoardVO updateForm(BoardVO bvo);
	public int boardUpdate(BoardVO bvo) throws Exception;
	/* public int replyCnt(int q_num); */

	public List<BoardVO> myList(MemberVO mvo);
	
	
	/* public List<BoardVO> myBoardList(BoardVO bvo); */
}
