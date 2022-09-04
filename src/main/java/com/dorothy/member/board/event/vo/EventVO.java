package com.dorothy.member.board.event.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventVO extends CommonVO {
	private int    e_num 	=0; 
	private String e_title 	=""; 
	private String e_content=""; 
	private String e_date ="";
	private String ad_id = "";
	
	private MultipartFile file;
	private String e_thumb  ="";
	private String e_file   =""; 
}
