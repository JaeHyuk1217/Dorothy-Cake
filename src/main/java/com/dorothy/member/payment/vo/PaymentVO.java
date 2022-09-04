package com.dorothy.member.payment.vo;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class PaymentVO extends CommonVO {
	private String p_merchant_uid;		  // 주문번호
	private String m_id;				  // 주문자아이디
	private String p_name;				  // 주문내용
	private int p_price;				  // 결제 금액
	private String p_pg = "nice";		  // 결제사
	private String p_pay_method = "card"; // 결제방법
	private String p_state;				  // 결제상태 
	private String p_date;				  // 결제날짜
}
