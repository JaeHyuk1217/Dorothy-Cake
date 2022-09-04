package com.dorothy.member.payment.vo;

import com.dorothy.member.cart.vo.MemberCartVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class OrderDTO extends MemberCartVO {
	private int o_num;
	private String p_merchant_uid;
}
