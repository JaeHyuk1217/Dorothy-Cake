package com.dorothy.admin.board.review.service;

import java.util.List;

import com.dorothy.member.board.review.vo.BoardReviewVO;

public interface AdminBoardReviewService {

	public List<BoardReviewVO> boardReviewList(BoardReviewVO brvo);
	public int boardReviewListCnt(BoardReviewVO brvo);
	public int replyCnt(int r_num);
	public BoardReviewVO boardReviewDetail(BoardReviewVO brvo);
	public int deleteAll(String[] numArr) throws Exception;
	public int boardReviewDelete(BoardReviewVO brvo) throws Exception;
	

}
