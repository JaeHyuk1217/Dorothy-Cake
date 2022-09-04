package com.dorothy.admin.reply.customOrder.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dorothy.admin.reply.customOrder.service.CustomOrderReplyService;
import com.dorothy.admin.reply.customOrder.vo.CustomOrderReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping(value="/admin/replies/customOrder")
@Log4j
@AllArgsConstructor
public class CustomOrderReplyController {
	
	private CustomOrderReplyService customOrderReplyService;
	
	/**************************************************************
	 * 댓글 목록 구현
	 * @return List<CustomOrderReplyVO>
	 **************************************************************/
	@GetMapping(value="/all/{c_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<CustomOrderReplyVO> replyCustomOrderList(@PathVariable("c_num") Integer c_num){
		log.info("admin replyCustomOrderList 호출 성공");
		
		List<CustomOrderReplyVO> replyList = null;
		replyList = customOrderReplyService.replyCustomOrderList(c_num);
		return replyList;
	}
	
	/**************************************************************
	 * 댓글 쓰기 구현
	 * @return String
	 **************************************************************/
	@PostMapping(value = "/replyCustomOrderInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyCustomOrderInsert(@RequestBody CustomOrderReplyVO corvo) {
		log.info("replyCustomOrderInsert 호출 성공");
		log.info("CustomOrderReplyVO : " + corvo);
		
		int result = 0;
		result = customOrderReplyService.replyCustomOrderInsert(corvo);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/**************************************************************
	 * 댓글 삭제 구현
	 * @return String
	 **************************************************************/
	@DeleteMapping(value = "/{rc_num}", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyCustomOrderDelete(@PathVariable("rc_num") int rc_num) {
		log.info("replyCustomOrderDelete 호출 성공");
		log.info("rc_num : " + rc_num);
		
		int result = customOrderReplyService.replyCustomOrderDelete(rc_num);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/**************************************************************
	 * 댓글 수정 구현
	 * @return String
	 **************************************************************/
	@PutMapping(value = "/{rc_num}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyCustomOrderUpdate(@PathVariable("rc_num") Integer rc_num, @RequestBody CustomOrderReplyVO corvo) { 
		log.info("replyCustomOrderUpdate 호출 성공");
	  
		corvo.setRc_num(rc_num);
		int result = customOrderReplyService.replyCustomOrderUpdate(corvo);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	

}
