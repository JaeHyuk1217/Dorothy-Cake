package com.dorothy.member.board.review.dao;

import java.util.List;

import com.dorothy.member.board.review.vo.BoardReviewVO;

public interface BoardReviewDao {
	public List<BoardReviewVO> boardReviewList(BoardReviewVO brvo);
	public int boardReviewListCnt(BoardReviewVO brvo);
	public BoardReviewVO boardReviewDetail(BoardReviewVO brvo);
	public int readcntUpdate(BoardReviewVO brvo);
	public int boardReviewInsert(BoardReviewVO brvo);
	public int boardReviewDelete(BoardReviewVO brvo);
	public int boardReviewUpdate(BoardReviewVO brvo);
	public BoardReviewVO deleteVO(int r_num);
}
