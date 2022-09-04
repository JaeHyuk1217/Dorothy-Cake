package com.dorothy.member.payment.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class PaymentDTO extends PaymentVO {
	private String gc_num;
}
