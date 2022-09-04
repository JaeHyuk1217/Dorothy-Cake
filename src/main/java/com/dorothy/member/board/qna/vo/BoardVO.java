package com.dorothy.member.board.qna.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

/* equals와 hashCode 메소드 자동 생성 시 부모 클래스의 필드까지 감안할지 안 할지에 대해서 설정 시
 * callSuper = true로 설정하면 부모 클래스 필드 값들도 동일한지 체크하며,
 * callSuper = false로 설정(기본값)하면 자신 클래스의 필드 값들만 고려한다. */
@Data
@EqualsAndHashCode(callSuper = false)
public class BoardVO extends CommonVO {
	private int q_num = 0;
	private String m_id = "";  // 닉네임 대체?
	private String q_title = "";
	private String q_content = "";
	private String q_date = "";
	private String q_category = "";
	private String q_status = "";
	/* private String q_pwd = ""; */
	private int q_readcnt = 0;
	private int q_replycnt = 0; // qna 글의 댓글 개수
	 
	private MultipartFile file; // 파일 업로드를 위한 필드
	//private String q_thumb = ""; // 실제 서버에 저장할 썸네일 이미지 파일명
	private String q_file = ""; // 실제 서버에 저장할 파일명
}
