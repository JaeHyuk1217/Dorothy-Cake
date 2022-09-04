package com.dorothy.admin.board.free.service;

import java.util.List;

import com.dorothy.member.board.free.vo.BoardFreeVO;

public interface AdminBoardFreeService {
	public List<BoardFreeVO> boardFreeList(BoardFreeVO bfvo);
	public int boardFreeListCnt(BoardFreeVO bfvo);
	public BoardFreeVO boardFreeDetail(BoardFreeVO bfvo);
	public int boardFreeDelete(BoardFreeVO bfvo) throws Exception;
	public int deleteAll(String[] numArr) throws Exception;
}
