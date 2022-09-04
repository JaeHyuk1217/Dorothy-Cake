package com.dorothy.admin.board.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.notice.dao.BoardNoticeDao;
import com.dorothy.member.board.notice.vo.BoardNoticeVO;

import lombok.Setter;

@Service
public class AdminBoardNoticeServiceImpl implements AdminBoardNoticeService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardNoticeDao boardNoticeDao;
	
	@Override
	public List<BoardNoticeVO> boardNoticeList(BoardNoticeVO nvo) {
		List<BoardNoticeVO> adminNoticeList = null;
		
		adminNoticeList = boardNoticeDao.boardNoticeList(nvo);
		return adminNoticeList;
	}

	@Override
	public int boardNoticeListCnt(BoardNoticeVO nvo) {
		return boardNoticeDao.boardNoticeListCnt(nvo);
	}

	@Override
	public BoardNoticeVO boardNoticeDetail(BoardNoticeVO nvo) {
		BoardNoticeVO bnDetail = null;
		bnDetail = boardNoticeDao.boardNoticeDetail(nvo);
		if(bnDetail != null) {
			bnDetail.setN_content(bnDetail.getN_content().toString().replaceAll("\n", "<br />"));
		}
		
		return bnDetail;
	}

	@Override
	public int boardNoticeDelete(BoardNoticeVO nvo) throws Exception{
		int result = 0;
		
/*		if(!nvo.getN_file().isEmpty()){
			FileUploadUtil.fileDelete(nvo.getN_file());
		}*/
		
		result = boardNoticeDao.boardNoticeDelete(nvo);
		return result;
	}

	@Override
	public int deleteAll(String[] numArr) throws Exception {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int f_num = Integer.parseInt(numArr[i]);
			BoardNoticeVO nvo = boardNoticeDao.deleteVO(f_num);
			
			if(!nvo.getN_file().isEmpty()) {
				FileUploadUtil.fileDelete(nvo.getN_file());
			}
			
			result += boardNoticeDao.boardNoticeDelete(nvo);
		}
		
		return result;
	}

	@Override
	public int noticeInsert(BoardNoticeVO nvo) throws Exception{
		int result = 0;
		
		if(nvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(nvo.getFile(), "notice");
			nvo.setN_file(fileName);
		}
		
		result = boardNoticeDao.noticeInsert(nvo);
		return result;
	}

	@Override
	public BoardNoticeVO noticeUpateForm(BoardNoticeVO nvo) {
		BoardNoticeVO updateData = null;
		updateData = boardNoticeDao.boardNoticeDetail(nvo);
		return updateData;
	}

	@Override
	public int noticeUpdate(BoardNoticeVO nvo) throws Exception{
		int result = 0;
		
		if(!nvo.getFile().isEmpty()) {
			if(!nvo.getN_file().isEmpty()) {
				FileUploadUtil.fileDelete(nvo.getN_file());
			}
			
			String fileName = FileUploadUtil.fileUpload(nvo.getFile(), "notice");
			nvo.setN_file(fileName);
		}
		result = boardNoticeDao.noticeUpdate(nvo);
		return result;
	}

}
