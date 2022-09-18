package com.spring.javagreenS_jjm.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_jjm.dao.ProductDAO;
import com.spring.javagreenS_jjm.vo.ProductTypeVO;
import com.spring.javagreenS_jjm.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDAO productDAO;


	@Override
	public ArrayList<ProductVO> getProductList(int startIndexNo, int pageSize) {
		return productDAO.getProductList(startIndexNo, pageSize);
	}
	
	@Override
	public ArrayList<ProductTypeVO> getProductType() {
		return productDAO.getProductType();
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckProductInput(MultipartHttpServletRequest mFile, ProductVO vo) {
		// 먼저 기본(메인)그림파일은 'ckeditor/product'폴더에 업로드 시켜준다.
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);		// 서버에 저장될 파일명을 결정해준다.
				writeFile(file, sFileName);		// 서버에 파일 저장처리하기
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				
				fileSizes += file.getSize();
			}
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 			   0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javagreenS_jjm/data/admin/211229124318_4.jpg"
		// <img alt="" src="/javagreenS_jjm/data/admin/product/211229124318_4.jpg"
		
		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 admin/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		// content박스의 내용중 그림이 없으면 돌아간다.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/admin/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "product/" + imgFile;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// 이미지 복사작업이 종료되면 실제로 저장된 'ckeditor/product'폴더명을 vo에 set시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/admin/", "/data/admin/product/"));

		// 파일 복사작업이 모두 끝나면 vo에 담긴내용을 상품의 내역을 DB에 저장한다.
		productDAO.imgCheckProductInput(vo);
	}

	// 저장되는 파일명의 중복을 방지하기위해 새로 파일명을 만들어준다.
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}
	
	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}
	
	// 실제 파일(ckeditor폴더)을 'ckeditor/product'폴더로 복사처리하는곳
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ProductVO getProductInfo(int idx) {
		return productDAO.getProductInfo(idx);
	}

	@Override
	public void productImgDelete(int idx, int imgIdx, String fName, String fSName) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		String[] fNames = fName.split("/");
		String[] fSNames = fSName.split("/");
		
		String realPathFile = realPath + fSNames[imgIdx];
		new File(realPathFile).delete();
		
		String uFName = fName.replace(fNames[imgIdx]+"/", "");
		String uFSName = fSName.replace(fSNames[imgIdx]+"/", "");
		
		productDAO.productImgDelete(idx, uFName, uFSName);
	}

	// 제품수정처리(productUpdate)하기위해 ckeditor에서 올린 이미지파일을 삭제처리한다.
	@Override
	public void imgDelete(String content) {
		//  		   0         1         2         3         4         5         6
		// 			   012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javagreenS_jjm/data/admin/product/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		if(content.indexOf("src=\"/") == -1) return;		// content박스의 내용중 그림이 없으면 돌아간다.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		
		int position = 40;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			
			fileDelete(oriFilePath);	// product폴더에 존재하는 파일을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg =nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	}


	// 원본이미지를 삭제처리한다.(resources/data/admin/product 폴더에서 삭제처리)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void imgCheck(String content) {
		//      0		  1         2         3         4         5         6
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javagreenS_jjm/data/admin/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		
		// 이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "product/" + imgFile;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// product폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg =nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	@Override
	public void setProductUpdate(ProductVO vo, MultipartHttpServletRequest mFile) {
		// 먼저 기본(메인)그림파일은 'ckeditor/product'폴더에 업로드 시켜준다.
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String oFileNames = vo.getFName();
			String sFileNames = vo.getFSName();
			int fileSizes = vo.getFSize();
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);		// 서버에 저장될 파일명을 결정해준다.
				if(oFileName.equals("")) {			// 수정창에서 메인이미지 추가를 안하면 DB에 그대로 저장
					vo.setFName(oFileNames);
					vo.setFSName(sFileNames);
					vo.setFSize(fileSizes);
				}
				else {
					writeFile(file, sFileName);		// 서버에 파일 저장처리하기
					oFileNames += oFileName + "/";
					sFileNames += sFileName + "/";
					fileSizes += file.getSize();
					vo.setFName(oFileNames);
					vo.setFSName(sFileNames);
					vo.setFSize(fileSizes);
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		productDAO.setProductUpdate(vo);
	}

	@Override
	public void setProductDelete(int idx) {
		productDAO.setProductDelete(idx);
	}

	@Override
	public void productImgAllDelete(ProductVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		String[] fSNames = vo.getFSName().split("/");
		
		for(int i=0; i<fSNames.length; i++) {
			String realPathFile = realPath + fSNames[i];
			new File(realPathFile).delete();
		}
	}

	@Override
	public void quantityOrder(int idx, int orderQuantity) {
		productDAO.quantityOrder(idx, orderQuantity);
	}
}
