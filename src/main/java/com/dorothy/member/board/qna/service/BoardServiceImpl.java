package com.dorothy.member.board.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.admin.reply.qna.dao.AdminReplyDao;
import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.qna.dao.BoardDao;
import com.dorothy.member.board.qna.vo.BoardVO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.Setter;



@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardDao boardDao;
	
	@Setter(onMethod_ = @Autowired)
	private AdminReplyDao replyDao;
	
	// 글 목록 구현
	@Override
	public List<BoardVO> boardList(BoardVO bvo) {
		List<BoardVO> list = null;
		list = boardDao.boardList(bvo);
		return list;
	}
	
	@Override
	public List<BoardVO> boardMyList(BoardVO bvo) {
		List<BoardVO> list = null;
		/* list = boardDao.boardMyList(bvo); */
		return list;
	}
	
	// 전체 레코드 수 구현
	@Override
	public int boardListCnt(BoardVO bvo) {
		return boardDao.boardListCnt(bvo);
	}
	
	

	// 글 입력 구현
	@Override
	public int boardInsert(BoardVO bvo) throws Exception {
		int result = 0;
		
		/* 예외를 발생시킬 코드 작성
		bvo.setB_num(0);
		if(bvo.getB_num() == 0) {
			throw new IllegalArgumentException("0번 글은 등록할 수 없습니다.");
		} */
		
		if(bvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(bvo.getFile(), "qna");
			bvo.setQ_file(fileName);
			
			
		}
		result = boardDao.boardInsert(bvo);
		return result;
	}
	
	// 글 상세 구현
	@Override
	public BoardVO boardDetail(BoardVO bvo) {
		BoardVO detail = null;
		
		boardDao.readcntUpdate(bvo);
		
		detail = boardDao.boardDetail(bvo);
		if(detail != null) {
			detail.setQ_content(detail.getQ_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}

	// 비밀번호 확인 구현
	@Override
	public int pwdConfirm(BoardVO bvo) {
		int result = 0;
		result = boardDao.pwdConfirm(bvo);
		return result;
	}
	
	// 글 삭제 구현
	@Override
	public int boardDelete(BoardVO bvo) throws Exception {
		int result = 0;
		
		if(!bvo.getQ_file().isEmpty()) {
			FileUploadUtil.fileDelete(bvo.getQ_file());
			/* FileUploadUtil.fileDelete(bvo.getQ_thumb()); */
		}
		
		if(bvo.getQ_replycnt() > 0) {
			replyDao.replyAllDelete(bvo.getQ_num());
		}
		result = boardDao.boardDelete(bvo);
		return result;
		
		/*
		 * if(bvo.getQ_replycnt() > 0) { 
		 * replyDao.replyAllDelete(bvo.getQ_num());
		 * }
		 */
	}
	// 자유게시판 글 수정 폼에 기존 데이터 전달
	@Override
	public BoardVO updateForm(BoardVO bvo) {
		BoardVO updateData = null;
		updateData = boardDao.boardDetail(bvo);
		return updateData;
	}
	
	// 글 수정 구현
	@Override
	public int boardUpdate(BoardVO bvo) throws Exception {
		int result = 0;
		
		if(!bvo.getFile().isEmpty()) { // 새롭게 업로드할 파일이 존재하면
			if(!bvo.getQ_file().isEmpty()) { // 기존 파일이 존재하면
				FileUploadUtil.fileDelete(bvo.getQ_file());
				//FileUploadUtil.fileDelete(bvo.getQ_thumb());
			}
			
			String fileName = FileUploadUtil.fileUpload(bvo.getFile(), "qna");
			bvo.setQ_file(fileName);
			
			/*
			 * String thumbName = FileUploadUtil.makeThumbnail(fileName);
			 * bvo.setQ_thumb(thumbName);
			 */
		}
		result = boardDao.boardUpdate(bvo);
		return result;
	}

	@Override
	public List<BoardVO> myList(MemberVO mvo) {
		List<BoardVO> list = null;
		list = boardDao.myList(mvo);
		return list;
	}

	/*
	 * @Override public int replyCnt(int q_num) { // TODO Auto-generated method stub
	 * return 0; }
	 */

	/*
	 * 해당 게시물의 댓글 존재 여부 확인 댓글이 존재하면 댓글수를 반환하고 존재하지 않으면 0을 반환
	 */
	/*
	 * @Override public int replyCnt(int q_num) { int result = 0; result =
	 * replyDao.replycnt(q_num); return result; }
	 */
/*	@Override
	public List<BoardVO> myBoardList(BoardVO bvo) {
		List<BoardVO> list = null;
		list = boardDao.boardList(bvo);
		return list;
	*/
/* } */
	
}
