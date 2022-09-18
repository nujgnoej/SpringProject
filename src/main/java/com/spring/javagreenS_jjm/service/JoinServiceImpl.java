package com.spring.javagreenS_jjm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jjm.dao.JoinDAO;
import com.spring.javagreenS_jjm.vo.JoinVO;

@Service
public class JoinServiceImpl implements JoinService {

	@Autowired
	JoinDAO	joinDAO;
	
	@Override
	public JoinVO getJoinIdCheck(String mid) {
		return joinDAO.getJoinIdCheck(mid);
	}
	
	@Override
	public JoinVO getJoinEmailCheck(String email) {
		return joinDAO.getJoinEmailCheck(email);
	}
	

	@Override
	public void setJoinInputOk(JoinVO vo) {
		joinDAO.setJoinInputOk(vo);
	}

	@Override
	public String getIdSearch(String name, String email) {
		return joinDAO.getIdSearch(name, email);
	}

	@Override
	public JoinVO getPwdSearch(String mid, String email) {
		return joinDAO.getPwdSearch(mid, email);
	}

	@Override
	public void setPwdChange(String mid, String encode) {
		joinDAO.setPwdChange(mid, encode);
	}

	@Override
	public void setJoinInfoUpdateOk(JoinVO vo) {
		joinDAO.setJoinInfoUpdateOk(vo);
	}

	@Override
	public void setMemPointUpdate(String mid) {
		joinDAO.setMemPointUpdate(mid);
	}
}
