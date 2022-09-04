package com.dorothy.member.order.orderInfo.vo;

import com.dorothy.common.vo.CommonVO;


import lombok.Data;
import lombok.EqualsAndHashCode;
@EqualsAndHashCode(callSuper = false)
@Data
public class OrderInfoVO extends CommonVO {
	private int o_num;
	private String p_merchant_uid;
	private String m_id;
	private String g_name;
	private int g_size;
	private int gc_amount;
	private int g_price;
	private String o_status = "결제완료";
	
}
