package com.dorothy.member.board.notice.dao;

import java.util.List;

import com.dorothy.member.board.notice.vo.BoardNoticeVO;

public interface BoardNoticeDao {

	public int boardNoticeListCnt(BoardNoticeVO nvo);
	public List<BoardNoticeVO> boardNoticeList(BoardNoticeVO nvo);
	public BoardNoticeVO boardNoticeDetail(BoardNoticeVO nvo);
	public void readcntUpdate(BoardNoticeVO nvo);
	public BoardNoticeVO deleteVO(int f_num);
	public int boardNoticeDelete(BoardNoticeVO nvo);
	public int noticeInsert(BoardNoticeVO nvo);
	public int noticeUpdate(BoardNoticeVO nvo);

}
