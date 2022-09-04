package com.dorothy.admin.board.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.free.dao.BoardFreeDao;
import com.dorothy.member.board.free.vo.BoardFreeVO;
import com.dorothy.member.reply.free.dao.ReplyFreeDao;

import lombok.Setter;

@Service
public class AdminBoardFreeServiceImpl implements AdminBoardFreeService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardFreeDao boardFreeDao;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyFreeDao replyFreeDao;
	
	// 관리자 자유게시판 글 목록 구현
	@Override
	public List<BoardFreeVO> boardFreeList(BoardFreeVO bfvo) {
		List<BoardFreeVO> adminFreeList = null;
		
		adminFreeList = boardFreeDao.boardFreeList(bfvo);
		return adminFreeList;
	}
	
	// 전체 레코드 수 구현
	@Override
	public int boardFreeListCnt(BoardFreeVO bfvo) {
		return boardFreeDao.boardFreeListCnt(bfvo);
	}

	// 관리자 자유게시판 글 상세보기 구현
	@Override
	public BoardFreeVO boardFreeDetail(BoardFreeVO bfvo) {
		BoardFreeVO bfDetail = null;
		bfDetail = boardFreeDao.boardFreeDetail(bfvo);
		if(bfDetail != null) {
			bfDetail.setF_content(bfDetail.getF_content().toString().replaceAll("\n", "<br />"));
		}
		
		return bfDetail;
	}
	
	// 관리자 자유게시판 글 전체 삭제 구현
	@Override
	public int deleteAll(String[] numArr) throws Exception {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int f_num = Integer.parseInt(numArr[i]);
			BoardFreeVO bfvo = boardFreeDao.deleteVO(f_num);
			
			if(!bfvo.getF_file().isEmpty()) {
				FileUploadUtil.fileDelete(bfvo.getF_file());
			}
			
			if(bfvo.getF_replycnt() > 0) {
				replyFreeDao.replyAllDelete(bfvo.getF_num());
			}
			
			result += boardFreeDao.boardFreeDelete(bfvo);
		}
		
		return result;
	}

	
	// 상세페이지 글 삭제 구현
	@Override
	public int boardFreeDelete(BoardFreeVO bfvo) throws Exception {
		int result = 0;
		
		if(!bfvo.getF_file().isEmpty()){
			FileUploadUtil.fileDelete(bfvo.getF_file());
		}
		
		if(bfvo.getF_replycnt() > 0) {
			replyFreeDao.replyAllDelete(bfvo.getF_num());
		}
		
		result = boardFreeDao.boardFreeDelete(bfvo);
		return result;
	}

}
