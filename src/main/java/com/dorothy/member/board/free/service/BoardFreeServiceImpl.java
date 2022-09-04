package com.dorothy.member.board.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.free.dao.BoardFreeDao;
import com.dorothy.member.board.free.vo.BoardFreeVO;
import com.dorothy.member.reply.free.dao.ReplyFreeDao;

import lombok.Setter;

@Service
public class BoardFreeServiceImpl implements BoardFreeService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardFreeDao boardFreeDao;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyFreeDao replyFreeDao;
	
	// 자유게시판 글 목록 구현
	@Override
	public List<BoardFreeVO> boardFreeList(BoardFreeVO bfvo) {
		List<BoardFreeVO> list = null;
		list = boardFreeDao.boardFreeList(bfvo);
		return list;
	}
	
	// 전체 레코드 수 구현
	@Override
	public int boardFreeListCnt(BoardFreeVO bfvo) {
		return boardFreeDao.boardFreeListCnt(bfvo);
	}

	// 자유게시판 글 상세보기 구현
	@Override
	public BoardFreeVO boardFreeDetail(BoardFreeVO bfvo) {
		BoardFreeVO bfDetail = null;
		
		boardFreeDao.readcntUpdate(bfvo);
		
		bfDetail = boardFreeDao.boardFreeDetail(bfvo);
		if(bfDetail != null) {
			bfDetail.setF_content(bfDetail.getF_content().toString().replaceAll("\n", "<br />"));
		}
		
		return bfDetail;
	}
	
	// 자유게시판 글쓰기 구현
	@Override
	public int boardFreeInsert(BoardFreeVO bfvo) throws Exception {
		int result = 0;
		
		if(bfvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(bfvo.getFile(), "free");
			bfvo.setF_file(fileName);
		}
		
		result = boardFreeDao.boardFreeInsert(bfvo);
		return result;
	}
	
	// 자유게시판 글 삭제 구현
	@Override
	public int boardFreeDelete(BoardFreeVO bfvo) throws Exception {
		int result = 0;
		
		if(!bfvo.getF_file().isEmpty()) {
			FileUploadUtil.fileDelete(bfvo.getF_file());
		}
		
		if(bfvo.getF_replycnt() > 0) {
			replyFreeDao.replyAllDelete(bfvo.getF_num());
		}
		
		result = boardFreeDao.boardFreeDelete(bfvo);
		return result;
	}
	
	// 자유게시판 글 수정 폼에 기존 데이터 전달
	@Override
	public BoardFreeVO freeUpateForm(BoardFreeVO bfvo) {
		BoardFreeVO updateData = null;
		updateData = boardFreeDao.boardFreeDetail(bfvo);
		return updateData;
	}
	
	// 자유게시판 글 수정 구현
	@Override
	public int boardFreeUpdate(BoardFreeVO bfvo) throws Exception {
		int result = 0;
		
		if(!bfvo.getFile().isEmpty()) {
			if(!bfvo.getF_file().isEmpty()) {
				FileUploadUtil.fileDelete(bfvo.getF_file());
			}
			
			String fileName = FileUploadUtil.fileUpload(bfvo.getFile(), "free");
			bfvo.setF_file(fileName);
		}
		result = boardFreeDao.boardFreeUpdate(bfvo);
		return result;
	}
	
}
