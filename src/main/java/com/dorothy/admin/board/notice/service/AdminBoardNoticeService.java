package com.dorothy.admin.board.notice.service;

import java.util.List;

import com.dorothy.member.board.notice.vo.BoardNoticeVO;

public interface AdminBoardNoticeService {

	public List<BoardNoticeVO> boardNoticeList(BoardNoticeVO nvo);
	public int boardNoticeListCnt(BoardNoticeVO nvo);
	public BoardNoticeVO boardNoticeDetail(BoardNoticeVO nvo);
	public int boardNoticeDelete(BoardNoticeVO nvo) throws Exception;
	public int deleteAll(String[] numArr) throws Exception;
	public int noticeInsert(BoardNoticeVO nvo) throws Exception;
	public BoardNoticeVO noticeUpateForm(BoardNoticeVO nvo);
	public int noticeUpdate(BoardNoticeVO nvo) throws Exception;

}
