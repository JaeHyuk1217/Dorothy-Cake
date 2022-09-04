package com.dorothy.admin.event.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.board.event.dao.EventDAO;
import com.dorothy.member.board.event.vo.EventVO;

import lombok.Setter;

@Service
public class AdminEventServiceImpl implements AdminEventService {
	
	@Setter(onMethod_=@Autowired)
	private EventDAO eventDAO;
	/*리스트*/
	@Override
	public List<EventVO> eventList(EventVO evo) {
		List<EventVO> aList = null;
		
		aList = eventDAO.eventList(evo);
		return aList;
	}
	/*글등록*/
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
	/**상세 페이지*/
	@Override
	public EventVO eventDetail(EventVO evo) {
		EventVO Detail = null;
		Detail = eventDAO.eventDetail(evo);
		if(Detail != null) {
			Detail.setE_content(Detail.getE_content().toString().replaceAll("\n", "<br />"));
		}
		
		return Detail;
	}
	
	@Override
	public int deleteAll(String[] numArr) throws Exception {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int e_num = Integer.parseInt(numArr[i]);
			EventVO evo = eventDAO.deleteVO(e_num);
			
			if(!evo.getE_file().isEmpty()) {
				FileUploadUtil.fileDelete(evo.getE_file());
			}
			 
			
			result += eventDAO.eventDelete(evo);
		}
		
		return result;
	}
	@Override
	public int eventDelete(EventVO evo) throws Exception {
		int result = 0;
		if(!evo.getE_file().isEmpty()){
			FileUploadUtil.fileDelete(evo.getE_file());
		}
		result = eventDAO.eventDelete(evo);
		return result;
	}

	@Override
	public int eventListCnt(EventVO evo) {
		return eventDAO.eventListCnt(evo);
	}
	/*수정 폼 출력*/
	/*
	 * @Override public EventVO updateForm(EventVO evo) { EventVO Eventupdate =
	 * null; Eventupdate = eventDAO.eventDetail(evo); return Eventupdate; }
	 */
	
	/*글 수정*/
	@Override
	public int eventUpdate(EventVO evo) throws Exception {
		int result = 0;
		if(!evo.getFile().isEmpty()) {			// 새롭게 업로드할 파일이 존재하면
			if(!evo.getE_file().isEmpty()) {	// 기존 파일이 존재하면
				FileUploadUtil.fileDelete(evo.getE_file());
				FileUploadUtil.fileDelete(evo.getE_thumb());
			}
			
			String fileName = FileUploadUtil.fileUpload(evo.getFile(), "event");
			evo.setE_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			evo.setE_thumb(thumbName); 
		}
		result = eventDAO.eventUpdate(evo);
		return result;
	}
	@Override
	public EventVO adminEventUpdate(EventVO evo) {
		EventVO eventUpdate = null;
		eventUpdate = eventDAO.eventDetail(evo);
		return eventUpdate;
	}

}
