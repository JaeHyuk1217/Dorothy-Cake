package com.dorothy.member.order.orderInfo.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = false)
@Data
public class OrderInfoDTO extends OrderInfoVO{
	private String m_name;
	private String p_name;
	private int p_price;
	private String p_state;
	private String m_pnb;
	private String m_addr;
	private String m_mail;
	private String p_date;
	private String p_pay_method;
}
