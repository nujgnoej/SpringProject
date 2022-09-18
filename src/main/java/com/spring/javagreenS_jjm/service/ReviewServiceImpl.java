package com.spring.javagreenS_jjm.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_jjm.dao.ReviewDAO;
import com.spring.javagreenS_jjm.vo.BaesongVO;
import com.spring.javagreenS_jjm.vo.ProductVO;
import com.spring.javagreenS_jjm.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public ArrayList<BaesongVO> getOrderInfo(int orderIdx) {
		return reviewDAO.getOrderInfo(orderIdx);
	}

	@Override
	public void setReviewInput(MultipartFile file, ReviewVO vo) {
		try {
			String oFileName = file.getOriginalFilename();
			int fSize = (int) file.getSize();
			UUID uid = UUID.randomUUID();
			String fName = uid + "_" + oFileName;
			vo.setFSName(fName);
			vo.setFSize(fSize);
			writeFile(file, fName);		// 서버에 파일 저장처리하기
		} catch (IOException e) {
			e.printStackTrace();
		}
		reviewDAO.setReviewInput(vo);
	}
	
	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public ReviewVO getReviewInfo(int orderIdx) {
		return reviewDAO.getReviewInfo(orderIdx);
	}

	@Override
	public void reviewImgDelete(int orderIdx, String fSName) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
		
		String realPathFile = realPath + fSName;
		new File(realPathFile).delete();
		
		reviewDAO.productImgDelete(orderIdx);
	}

	@Override
	public void setReviewUpdate(MultipartFile file, ReviewVO vo) {
		try {
			String oFileName = vo.getFSName();
			int oFSize = vo.getFSize();
			String sFileName = file.getOriginalFilename();
			int sFSize = (int) file.getSize();
			if(sFileName.equals("")) {			// 수정창에서 메인이미지 추가를 안하면 DB에 그대로 저장
				vo.setFSName(oFileName);
				vo.setFSize(oFSize);
			}
			else {
				UUID uid = UUID.randomUUID();
				String fName = uid + "_" + sFileName;
				vo.setFSName(fName);
				vo.setFSize(sFSize);
				writeFile(file, fName);		// 서버에 파일 저장처리하기
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		reviewDAO.setReviewUpdate(vo);
	}

	@Override
	public void setReviewDelete(ReviewVO vo, int orderIdx) {
		// 이미지 삭제
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
		String fSName = vo.getFSName().replace("\\", "");
		String realPathFile = realPath + fSName;
		new File(realPathFile).delete();
		
		// DB업데이트
		reviewDAO.setReviewDelete(orderIdx);
	}

	@Override
	public ArrayList<ReviewVO> getReviewList(int startIndexNo, int pageSize) {
		return reviewDAO.getReviewList(startIndexNo, pageSize);
	}

	@Override
	public ProductVO getProductInfo(String commodity) {
		return reviewDAO.getProductInfo(commodity);
	}
	
}
