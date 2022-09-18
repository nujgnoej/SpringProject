package com.spring.javagreenS_jjm.service;

import com.spring.javagreenS_jjm.vo.JoinVO;

public interface JoinService {

	public JoinVO getJoinIdCheck(String mid);
	
	public JoinVO getJoinEmailCheck(String email);

	public void setJoinInputOk(JoinVO vo);

	public String getIdSearch(String name, String email);

	public JoinVO getPwdSearch(String mid, String email);

	public void setPwdChange(String mid, String encode);

	public void setJoinInfoUpdateOk(JoinVO vo);

	public void setMemPointUpdate(String mid);

}
