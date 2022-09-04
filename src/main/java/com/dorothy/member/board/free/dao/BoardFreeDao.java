package com.dorothy.member.board.free.dao;

import java.util.List;

import com.dorothy.member.board.free.vo.BoardFreeVO;

public interface BoardFreeDao {
	public List<BoardFreeVO> boardFreeList(BoardFreeVO bfvo);
	public int boardFreeListCnt(BoardFreeVO bfvo);
	public BoardFreeVO boardFreeDetail(BoardFreeVO bfvo);
	public int readcntUpdate(BoardFreeVO bfvo);
	public int boardFreeInsert(BoardFreeVO bfvo);
	public int boardFreeDelete(BoardFreeVO bfvo);
	public int boardFreeUpdate(BoardFreeVO bfvo);
	public BoardFreeVO deleteVO(int f_num);
}
