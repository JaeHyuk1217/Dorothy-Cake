package com.dorothy.member.goods.vo;

import org.springframework.web.multipart.MultipartFile;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MemberGoodsVO extends CommonVO {
	private int g_code;				//상품코드
	private String g_name;			//상품이름
	private int g_type;				//상품종류 0: 프리미엄케이크, 1: 레터링케이크
	private int g_price;			//상품가격
	private String g_file;			//첨부파일 - 이미지
	private int g_size;				//상품사이즈 0: 미니, 1: 1호 가격 + 10000원
	private int g_recommend;		//추천태그 0 : 없음, 1 : 있음
	private int g_new;				//신상품태그 0 : 없음, 1 : 있음
	private int g_custom;			//커스텀유무 0 : 기성품, 1 : 커스텀
	
	private MultipartFile file;
}
