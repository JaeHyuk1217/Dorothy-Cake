package com.dorothy.member.board.notice.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class BoardNoticeVO extends CommonVO{
	private int n_num;
	private String n_title;
	private String n_date;
	private String n_content;
	private String n_file;
	private String ad_id;
	private int n_readcnt;
	
	private MultipartFile file; // 파일 업로드를 위한 필드
}
