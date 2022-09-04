package com.dorothy.member.login.vo;

import java.sql.Date;

import com.dorothy.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberVO extends CommonVO {
	
	private String m_id;
	private String m_pwd;
	private String m_name;
	private String m_nick;
	private String m_mail;
	private String m_pnb;
	private String m_addr;
	private String m_addr2;
	private String m_addr3;
	private Date m_date;
	private int m_state;
	public int m_states() {
		// TODO Auto-generated method stub
		return 0;
	}

}
