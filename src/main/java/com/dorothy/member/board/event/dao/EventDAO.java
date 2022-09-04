package com.dorothy.member.board.event.dao;

import java.util.List;

import com.dorothy.member.board.event.vo.EventVO;

public interface EventDAO {
	public List<EventVO> eventList(EventVO evo);
	public int eventListCnt(EventVO evo); 
	public int eventInsert(EventVO evo);
	public EventVO eventDetail(EventVO evo);
	public int readCntUpdate(EventVO evo);
	public int eventUpdate(EventVO evo);
	public int eventDelete(EventVO evo);
	public EventVO deleteVO(int e_num);
	public int eventDelete(int e_num);
}
