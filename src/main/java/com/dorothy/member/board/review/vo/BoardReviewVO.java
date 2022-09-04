package com.dorothy.member.board.review.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BoardReviewVO extends CommonVO {
	private int r_num = 0; // 리뷰게시판 글번호
	private String m_id = "";	// 리뷰게시판 글 작성자 아이디
	private String r_title = ""; // 리뷰게시판 글제목
	private String r_content = ""; // 리뷰게시판 글내용
	private String r_date = ""; // 리뷰게시판 글 작성일
	private int r_readcnt = 0; // 리뷰게시판 글 조회수
	private int r_replycnt = 0; // 리뷰게시판 글의 댓글 개수
	
	private MultipartFile file; // 파일 업로드를 위한 필드
	private String r_file="";  // 서버에 저장할 이미지 파일 명
	private String r_thumbnail = ""; // 실제 서버에 저장할 썸네일 이미지 파일명
	

}
