package com.kspat.util.common;



import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

/**
 * File Download Util.
 */
public class DownloadUtil {
	// download buffer size
	/** The Constant BUFFER_SIZE. */
	private static final int BUFFER_SIZE = 8192;	// 8KB
	// character encoding
	/** The Constant CHARSET. */
	private static final String CHARSET = "euc-kr";

	/**
	 *  지정된 파일을 다운로드 한다.
	 *
	 * @param request the request
	 * @param response the response
	 * @param file the file
	 * @return the string
	 * @throws ServletException the servlet exception
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	public static String download(HttpServletRequest request, HttpServletResponse response, File file, String orgName)
			throws ServletException, IOException {
		String mimeType = request.getSession().getServletContext().getMimeType(file.getName());
		if (file == null || !file.exists() || file.length() <= 0) {
			return "ERROR : The File Does Not Exist.";
		} else if (file.isDirectory()) {
			return "ERROR : It is Not File, is Directory.";
		}

		InputStream is = null;
		try {
			is = new FileInputStream(file);
			download(request, response, is, file.getName(), file.length(), mimeType,orgName);
		} finally {
			try {
				is.close();
			} catch (Exception ex) { }
		}

		return "success";
	}



	/**
	 * 해당 입력 스트림으로부터 오는 데이터를 다운로드 한다.
	 *
	 * @param request the request
	 * @param response the response
	 * @param is : 입력 스트림
	 * @param fileName : 파일 이름
	 * @param fileSize : 파일 크기
	 * @param mimeType : MIME 타입 지정
	 * @throws ServletException the servlet exception
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is, String fileName, long fileSize, String mimeType,String orgName)
			throws ServletException, IOException {
		String mime = mimeType;
		if (StringUtils.isEmpty(mime)) {
			mime = "application/octet-stream;";
		}

		byte[] buffer = new byte[BUFFER_SIZE];
		response.setContentType(mime + "; charset=" + CHARSET);

		// 아래 부분에서 euc-kr 을 utf-8 로 바꾸거나 URLEncoding을 안하거나 등의 테스트를 해서 한글이 정상적으로 다운로드 되는 것으로 지정한다.
		String userAgent = request.getHeader("User-Agent");
		if (userAgent.indexOf("MSIE 5.5") > -1) {	// MS IE 5.5 이하
			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(orgName, "UTF-8") + ";");
		} else if (userAgent.indexOf("MSIE") > -1) {	// IE 6.x 이상
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(orgName, "UTF-8") + ";");
		} else {	// 그 외 브라우저
			response.setHeader("Content-Disposition", "attachment; filename=" + new String(orgName.getBytes(CHARSET), "latin1") + ";");
		}

		if (fileSize > 0) {
			// 파일 사이즈가 정확하지 않을 때는 지정하지 않음0.
			response.setHeader("Content-Length", "" + fileSize);
		}

		BufferedInputStream fin = null;
		BufferedOutputStream fout = null;

		try {
			fin = new BufferedInputStream(is);
			fout = new BufferedOutputStream(response.getOutputStream());
			int read = 0;
			while ((read = fin.read(buffer)) != -1) {
				fout.write(buffer, 0, read);
			}
		} finally {
			try {
				fout.close();
			} catch (Exception ex) { }

			try {
				fin.close();
			} catch (Exception ex) { }
		}
	}

}
