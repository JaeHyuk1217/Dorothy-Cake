package com.dorothy.member.board.free.service;

import java.util.List;

import com.dorothy.member.board.free.vo.BoardFreeVO;

public interface BoardFreeService {
	public List<BoardFreeVO> boardFreeList(BoardFreeVO bfvo);
	public int boardFreeListCnt(BoardFreeVO bfvo);
	public BoardFreeVO boardFreeDetail(BoardFreeVO bfvo);
	public int boardFreeInsert(BoardFreeVO bfvo) throws Exception;
	public int boardFreeDelete(BoardFreeVO bfvo) throws Exception;
	public BoardFreeVO freeUpateForm(BoardFreeVO bfvo);
	public int boardFreeUpdate(BoardFreeVO bfvo) throws Exception;
}
