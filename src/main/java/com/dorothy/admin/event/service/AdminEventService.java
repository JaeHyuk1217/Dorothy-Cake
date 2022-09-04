package com.dorothy.admin.event.service;

import java.util.List;

import com.dorothy.member.board.event.vo.EventVO;

public interface AdminEventService {
	public List<EventVO> eventList(EventVO evo);
	public int eventInsert(EventVO evo) throws Exception;
	public EventVO eventDetail(EventVO evo);
	public int eventDelete(EventVO evo) throws Exception;
	public int deleteAll(String[] numArr) throws Exception;
	public int eventListCnt(EventVO evo);
	public int eventUpdate(EventVO evo) throws Exception;
	//public EventVO updateForm(EventVO evo);
	public EventVO adminEventUpdate(EventVO evo);

}
