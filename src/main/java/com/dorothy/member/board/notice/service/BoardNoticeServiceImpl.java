package com.dorothy.member.board.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dorothy.member.board.notice.dao.BoardNoticeDao;
import com.dorothy.member.board.notice.vo.BoardNoticeVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardNoticeServiceImpl implements BoardNoticeService{
	
	private BoardNoticeDao boardNoticeDao;
	
	@Override
	public List<BoardNoticeVO> boardNoticeList(BoardNoticeVO nvo) {
		List<BoardNoticeVO> list = null;
		list = boardNoticeDao.boardNoticeList(nvo);
		return list;
	}

	@Override
	public int boardNoticeListCnt(BoardNoticeVO nvo) {
		return boardNoticeDao.boardNoticeListCnt(nvo);
	}

	@Override
	public BoardNoticeVO boardNoticeDetail(BoardNoticeVO nvo) {
		BoardNoticeVO bnDetail = null;
		
		boardNoticeDao.readcntUpdate(nvo);
		
		bnDetail = boardNoticeDao.boardNoticeDetail(nvo);
		if(bnDetail != null) {
			bnDetail.setN_content(bnDetail.getN_content().toString().replaceAll("\n", "<br />"));
		}
		
		return bnDetail;
	}
	
}
