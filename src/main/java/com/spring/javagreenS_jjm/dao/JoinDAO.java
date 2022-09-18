package com.spring.javagreenS_jjm.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jjm.vo.JoinVO;

public interface JoinDAO {

	public JoinVO getJoinIdCheck(@Param("mid") String mid);
	
	public JoinVO getJoinEmailCheck(@Param("email") String email);

	public void setJoinInputOk(@Param("vo") JoinVO vo);

	public String getIdSearch(@Param("name") String name, @Param("email") String email);

	public JoinVO getPwdSearch(@Param("mid") String mid, @Param("email") String email);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setJoinInfoUpdateOk(@Param("vo") JoinVO vo);

	public void setMemPointUpdate(@Param("mid") String mid);
	

}
