package com.dorothy.common.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 화면에서 보여지는 페이지의 시작 번호
	private int endPage; // 화면에서 보여지는 페이지의 끝 번호
	private boolean prev, next; // 이전과 다음 링크 표시 여부
	
	private int total;
	private CommonVO cvo;
	
	public PageDTO(CommonVO cvo, int total) {
		this.cvo = cvo;
		this.total = total;
		
		/* 페이지 끝 번호 */
		this.endPage = (int)(Math.ceil(cvo.getPageNum() / 10.0)) * 10;
		
		/* 페이지 시작 번호 */
		this.startPage = this.endPage - 9;
		
		/* 끝 페이지 */
		int realEnd = (int)(Math.ceil((total * 1.0) / cvo.getAmount()));
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		/* 이전(prev) 구하기 */
		this.prev = this.startPage > 1;
		
		/* 다음(next) 구하기 */
		this.next = this.endPage < realEnd;
	}
}
