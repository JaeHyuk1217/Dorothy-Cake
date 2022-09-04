package com.dorothy.admin.board.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.review.dao.AdminReplyReviewDao;
import com.dorothy.common.file.FileUploadUtil;

import com.dorothy.member.board.review.dao.BoardReviewDao;
import com.dorothy.member.board.review.vo.BoardReviewVO;

import lombok.Setter;

@Service
public class AdminBoardReviewServiceImpl implements AdminBoardReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardReviewDao boardReviewDao;
	
	@Setter(onMethod_ = @Autowired)
	private AdminReplyReviewDao adminReplyReviewDao;
	
	// 관리자 리뷰게시판 글 목록 구현
	@Override
	public List<BoardReviewVO> boardReviewList(BoardReviewVO brvo) {
		List<BoardReviewVO> adminBoardReviewList = null;
		
		adminBoardReviewList = boardReviewDao.boardReviewList(brvo);
		return adminBoardReviewList;
	}

	// 전체 레코드 수 구현
	@Override
	public int boardReviewListCnt(BoardReviewVO brvo) {
		return boardReviewDao.boardReviewListCnt(brvo);
	}

	// 관리자 리뷰게시판 글 상세보기 구현
	@Override
	public BoardReviewVO boardReviewDetail(BoardReviewVO brvo) {
		BoardReviewVO brDetail = null;
		brDetail = boardReviewDao.boardReviewDetail(brvo);
		if(brDetail != null) {
			brDetail.setR_content(brDetail.getR_content().toString().replaceAll("\n", "<br />"));
		}
		
		return brDetail;
	}

	// 관리자 자유게시판 글 전체 삭제 구현
	@Override
	public int deleteAll(String[] numArr) throws Exception {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int r_num = Integer.parseInt(numArr[i]);
			BoardReviewVO brvo = boardReviewDao.deleteVO(r_num);
			
			if(!brvo.getR_file().isEmpty()) {
				FileUploadUtil.fileDelete(brvo.getR_file());
			}
			
			if(brvo.getR_readcnt() > 0) {
				adminReplyReviewDao.replyAllDelete(brvo.getR_num());
			}
			
			result += boardReviewDao.boardReviewDelete(brvo);
		}
		
		return result;
	}
	
	// 상세페이지 글 삭제 구현
	@Override
	public int boardReviewDelete(BoardReviewVO brvo) throws Exception {
		int result = 0;
			
		if(!brvo.getR_file().isEmpty()){
			FileUploadUtil.fileDelete(brvo.getR_file());
		}
			
		if(brvo.getR_readcnt() > 0) {
			adminReplyReviewDao.replyAllDelete(brvo.getR_num());
		}
			
		result = boardReviewDao.boardReviewDelete(brvo);
			return result;
		}

	@Override
	public int replyCnt(int r_num) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

	
}
