package com.spring.javagreenS_jjm;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = {"/","/h","/main"}, method = RequestMethod.GET)
	public String home() {
		return "main/main";
	}
	
	// admin에서 글을 올릴때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 그림파일을 저장할 수 있도록 처리한다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
			MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// admin에서 올린(전송한) 파일을, 서버 파일시스템에 실제로 파일을 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);		// 서버에 업로드시킨 그림파일이 저장된다.
		
		// 서버 파일시스템에 저장된 파일을 화면에 보여주기위한 작업.
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/admin/" + originalFilename;
		/* {\\"atom":"12.jpg","변수:1",~~~} */
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	@RequestMapping(value = "/aboutus", method = RequestMethod.GET)
	public String aboutusGet() {
		
		return "main/aboutus";
	}
	
}
