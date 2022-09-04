package com.dorothy.member.board.review.service;

import java.util.List;

import com.dorothy.member.board.review.vo.BoardReviewVO;

public interface BoardReviewService {
	public List<BoardReviewVO> boardReviewList(BoardReviewVO brvo);
	public int boardReviewListCnt(BoardReviewVO brvo);
	public BoardReviewVO boardReviewDetail(BoardReviewVO brvo);
	public int boardReviewInsert(BoardReviewVO brvo) throws Exception;
	public int boardReviewDelete(BoardReviewVO brvo) throws Exception;
	public BoardReviewVO reviewUpdateForm(BoardReviewVO brvo);
	public int boardReviewUpdate(BoardReviewVO brvo) throws Exception;
	
	
}
