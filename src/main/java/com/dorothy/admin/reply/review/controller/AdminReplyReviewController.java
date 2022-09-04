package com.dorothy.admin.reply.review.controller;

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

import com.dorothy.admin.reply.review.service.AdminReplyReviewService;
import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/admin/replies/review")
@RestController
@Log4j
@AllArgsConstructor
public class AdminReplyReviewController {
	
	private AdminReplyReviewService adminReplyReviewService;
	
	/**************************************************************
	 * 댓글 목록 구현
	 * @return List<AdminReplyReviewVO>
	 **************************************************************/
	@GetMapping(value="/all/{r_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<AdminReplyReviewVO> replyReviewList(@PathVariable("r_num") Integer r_num) {
		log.info("admin replyReviewList 호출 성공");
		
		List<AdminReplyReviewVO> replyList = null;
		replyList = adminReplyReviewService.replyReviewList(r_num);
		return replyList;
		
	}
	
	/**************************************************************
	 * 댓글 쓰기 구현
	 * @return String
	 **************************************************************/
	@PostMapping(value = "/replyReviewInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyReviewInsert(@RequestBody AdminReplyReviewVO rrvo) {
		log.info("replyReviewInsert 호출 성공");
		log.info("AdminReplyReviewVO : " + rrvo);
		
		int result = 0;
		result = adminReplyReviewService.replyReviewInsert(rrvo);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/**************************************************************
	 * 댓글 삭제 구현
	 * @return String
	 **************************************************************/
	@DeleteMapping(value = "/{rr_num}", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyReviewDelete(@PathVariable("rr_num") int rr_num) {
		log.info("replyReviewDelete 호출 성공");
		log.info("rr_num : " + rr_num);
		
		int result = adminReplyReviewService.replyReviewDelete(rr_num);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/**************************************************************
	 * 댓글 수정 구현
	 * @return String
	 **************************************************************/
	@PutMapping(value = "/{rr_num}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyReviewUpdate(@PathVariable("rr_num") Integer rr_num, @RequestBody AdminReplyReviewVO rrvo) { 
		log.info("replyReviewUpdate 호출 성공");
	  
		rrvo.setRr_num(rr_num);
		int result = adminReplyReviewService.replyReviewUpdate(rrvo);
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
