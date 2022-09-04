package com.dorothy.member.board.free.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BoardFreeVO extends CommonVO {
	private int f_num = 0;		// 자유게시판 글 번호
	private String m_id = "";	// 자유게시판 글 작성자 아이디
	private String f_title = ""; // 자유게시판 글 제목
	private String f_content = ""; // 자유게시판 글 내용
	private String f_date = "";  // 자유게시판 글 작성일
	private int f_readcnt = 0;  // 자유게시판 글 조회수
	private int f_replycnt = 0; // 자유게시판 글의 댓글 개수
	
	private MultipartFile file; // 파일 업로드를 위한 필드
	private String f_file="";  // 서버에 저장할 이미지 파일 명
}
