package com.dorothy.admin.board.qna.service;

import java.util.List;

import com.dorothy.member.board.qna.vo.BoardVO;



public interface AdminBoardService {

	public List<BoardVO> boardList(BoardVO bvo);
	public int boardListCnt(BoardVO bvo);
	/* public List<BoardVO> boardListExcel(BoardVO bvo); */
	public BoardVO boardDetail(BoardVO bvo);
	public int boardDelete(BoardVO bvo) throws Exception;
	public int replyCnt(int q_num);
	public int deleteAll(String[] numArr) throws Exception; 
	

}
