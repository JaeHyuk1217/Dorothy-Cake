package com.dorothy.member.cart.vo;

import lombok.Data;

@Data
public class MemberCartVO {
	private int gc_num;
	private int g_code;
	private int gc_amount;
	private int g_price;
	private String m_id;
	
	private String g_name;
	private String g_file;
	private int g_size;
}
