package com.dorothy.member.cart.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemberCartDTO {
	List<MemberCartVO> orders;
}
