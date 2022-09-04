package com.dorothy.member.reply.review.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dorothy.admin.reply.review.vo.AdminReplyReviewVO;
import com.dorothy.member.reply.review.service.ReplyReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping(value="/replies/review")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyReviewController {
	
	private ReplyReviewService replyReviewService;
	
	/**************************************************************
	 * 댓글 목록 구현
	 * @return List<AdminReplyReviewVO>
	 **************************************************************/
	@GetMapping(value="/all/{r_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<AdminReplyReviewVO> replyReviewList(@PathVariable("r_num") Integer r_num){
		log.info("replyReviewList 호출 성공");
		
		List<AdminReplyReviewVO> replyList = null;
		replyList = replyReviewService.replyReviewList(r_num);
		return replyList;
		
	}

}
