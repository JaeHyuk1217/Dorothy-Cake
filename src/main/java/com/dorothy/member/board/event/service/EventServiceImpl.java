package com.dorothy.member.board.event.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.event.dao.EventDAO;
import com.dorothy.member.board.event.vo.EventVO;


import lombok.Setter;

//import lombok.extern.log4j.Log4j;

//@Log4j
@Service
public class EventServiceImpl implements EventService {
	
	@Setter(onMethod_=@Autowired)
	private EventDAO eventDAO;
	
	// 글목록 구현
	@Override
	public List<EventVO> eventList(EventVO evo){
		List<EventVO> list= null;
		list = eventDAO.eventList(evo);
		return list;
	}
	/* 글 상세 구현*/
	@Override
	public EventVO eventDetail(EventVO evo) {
		EventVO detail = null;
		
		detail = eventDAO.eventDetail(evo);
		if(detail != null) {
			detail.setE_content(detail.getE_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	/*@Override
	public EventVO eventDetail(EventVO evo) {
		EventVO detail = eventDAO.eventDetail(evo);
		return detail;
	}*/
	
	// 레코드수 구현
	@Override
	public int eventListCnt(EventVO evo) {
		return eventDAO.eventListCnt(evo);
	}
	
	// 글입력 구현
	@Override
	public int eventInsert(EventVO evo) throws Exception {
		int result = 0;
		
		if(evo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(evo.getFile(), "event"); // board_1658205347977_cat.jpg
			evo.setE_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName); // thumbnail_board_1658205347977_cat.jpg
			evo.setE_thumb(thumbName);
		}
		result = eventDAO.eventInsert(evo);
		return result;
	}

	
	@Override
	public EventVO updateForm(EventVO evo) {
		EventVO updateData = null;
		updateData = eventDAO.eventDetail(evo);
		return updateData;
	}
	// 글 수정
	@Override
	public int eventUpdate(EventVO evo) throws Exception {
		int result = 0;
		if(!evo.getFile().isEmpty()) {			
			if(!evo.getE_file().isEmpty()) {	
				FileUploadUtil.fileDelete(evo.getE_file());
				FileUploadUtil.fileDelete(evo.getE_thumb());
			}
			
			String fileName = FileUploadUtil.fileUpload(evo.getFile(), "board");
			evo.setE_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			evo.setE_thumb(thumbName); 
		}
		result = eventDAO.eventUpdate(evo);
		return result;
	}
	
	/* 글 삭제 구현 */
	@Override
	public int eventDelete(EventVO evo) throws Exception{
		int result = 0;
		if(!evo.getE_file().isEmpty()) {
			FileUploadUtil.fileDelete(evo.getE_file());
			FileUploadUtil.fileDelete(evo.getE_thumb());
		}
		result = eventDAO.eventDelete(evo.getE_num());
		return result;
	}
}
