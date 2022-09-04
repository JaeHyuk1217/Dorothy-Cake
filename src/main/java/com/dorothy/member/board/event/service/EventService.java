package com.dorothy.member.board.event.service;

import java.util.List;

import com.dorothy.member.board.event.vo.EventVO;

public interface EventService {
	public List<EventVO> eventList(EventVO evo);
	public int eventListCnt(EventVO evo);
	public int eventInsert(EventVO evo) throws Exception;
	public EventVO eventDetail(EventVO evo);
	public EventVO updateForm(EventVO evo);
	public int eventUpdate(EventVO evo) throws Exception;
	public int eventDelete(EventVO evo) throws Exception;
}