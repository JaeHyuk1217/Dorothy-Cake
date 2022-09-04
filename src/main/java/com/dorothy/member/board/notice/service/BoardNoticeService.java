package com.dorothy.member.board.notice.service;

import java.util.List;

import com.dorothy.member.board.notice.vo.BoardNoticeVO;

public interface BoardNoticeService {

	public List<BoardNoticeVO> boardNoticeList(BoardNoticeVO nvo);
	public int boardNoticeListCnt (BoardNoticeVO nvo);
	public BoardNoticeVO boardNoticeDetail(BoardNoticeVO nvo);
	
}
