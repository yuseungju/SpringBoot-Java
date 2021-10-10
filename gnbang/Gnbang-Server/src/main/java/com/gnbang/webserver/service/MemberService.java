package com.gnbang.webserver.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gnbang.webserver.config.GlobalValue;
import com.gnbang.webserver.dto.RoomItemCartListVO;
import com.gnbang.webserver.dto.RoomPhotoVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.mapper.MemberMapper;
import com.gnbang.webserver.upload.FTPFile;
import com.gnbang.webserver.upload.FTPUtil;
import com.gnbang.webserver.upload.UploadStatus;

@Service
public class MemberService {
	private final static Logger logger = LoggerFactory.getLogger(RoomService.class);

	@Autowired
	private MemberMapper memberMapper;

	//중개사 회원정보 수정
	public void modifyAgent(UserVO userVo) {
		
	}
	//비밀번호 일치여부 확인 
	public boolean checkPassword(String email, String password) {
		String encodedPassword = memberMapper.getEncodePassword(email).getPassword();//인코딩되어 저장된 비밀번호 가져옴
		if(new BCryptPasswordEncoder().matches(password, encodedPassword))//입력비밀번호와 기존비밀번호확인
			return true;
		else 
			return false;
	}
	//이메일에 해당되는  회원을 탈퇴상태로 수정
	public boolean secession(String email) {
		if(0 < memberMapper.updateLeaveDate(email))
			return true;
		return false;
	}
	// 비밀번호 수정
	public boolean changePassword(String email, String password) {
		// 회원 비밀번호 암호화
		String encodedPassword = new BCryptPasswordEncoder().encode(password);
		// 암호화 비밀번호 수정
		if(0 < memberMapper.updatePassword(email,encodedPassword))
			return true;
		return false;
	}
	public String uploadPhotoToServer(MultipartFile uploadfile, HttpServletRequest request, int loginNo){
		String pathGNServer = uploadPhotoToGNServer(uploadfile, request, loginNo);//강남방 서버 업로드
		String errCheck = pathGNServer;
		if(!pathGNServer.equals("ErrSize") && !pathGNServer.equals("ErrExtension")){//강남방 서버로 업로드 성공시
			logger.debug("success: upload profile photo to GN server");
			errCheck="success";
			//강남방서버 -> ftp서버 
			String pathFTPServer = uploadFromGNServerToFTP(request, loginNo, pathGNServer);
			enrollPhotoPath(loginNo, pathFTPServer);
		}else{
			logger.debug("fail: upload profile photo to GN server");
		}
		return errCheck;
	}
	//프로필사진 업로드 
	private String uploadPhotoToGNServer(MultipartFile uploadfile, HttpServletRequest request, int loginNo) {
		// (저장공간)디렉토리명 규칙 적용 - 100 단위의 폴더이름
		String dirSubPer000000 = String.format("%07d", Integer.parseInt((int) (loginNo / 1000000) + "000000"));
		String dirSubPer0000 = String.format("%07d", Integer.parseInt((int) (loginNo / 10000) + "0000"));
		String dirSubPer00 = String.format("%07d", Integer.parseInt((int) (loginNo / 100) + "00"));
		String dirSubPer = String.format("%07d", Integer.parseInt((int) (loginNo / 1) + ""));
		String dirSub =  dirSubPer000000 + "/" + dirSubPer0000 + "/" + dirSubPer00
				+ "/" + dirSubPer;// 워터마크 저장되는 서버경로(파일명제외)

		// 확장자
		String extension;
		extension = uploadfile.getOriginalFilename().
				substring(uploadfile.getOriginalFilename().lastIndexOf("."));

		// 파일이름
		String fileName = uploadfile.getOriginalFilename();
		fileName = UUID.randomUUID().toString() + extension;

		//저장될 위치
		String orginalDirPath = GlobalValue.serverUserDir + dirSub
				+ "/";// 원본이미지 저장될 경로(파일명 제외)
		String orginalPath = orginalDirPath + fileName;// 원본이미지 저장될 경로(파일명포함 전체)
	
		// 파일 용량 제한
		if (10485760 < uploadfile.getSize())// 10*1024*1024(10MB)를 넘으면 
			return "ErrSize";
		// 확장자 추출 후 적합성 확인
		if (!(extension.equals(".jpg") || extension.equals(".JPG")))
			// ||// extension.equals(".PNG")||// extension.equals(".png")
			return "ErrExtension";
		
		//강남방 서버 파일업로드
		try {
			// 임시 디렉토리 생성
			File targetDir = new File(orginalDirPath);
			if (!targetDir.exists()) {// 폴더가없으면
				targetDir.mkdirs();
			}
			// 임시 파일 저장
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(orginalPath)));
			stream.write(uploadfile.getBytes());
			stream.close();
		} catch (Exception e) {
		}
		return orginalPath;
	}
	private String uploadFromGNServerToFTP(HttpServletRequest request, int loginNo,
			String srcPath) {
		// (저장공간)디렉토리명 규칙 적용 - 100 단위의 폴더이름
		String dirSubPer000000 = String.format("%07d", Integer.parseInt((int) (loginNo / 1000000) + "000000"));
		String dirSubPer0000 = String.format("%07d", Integer.parseInt((int) (loginNo / 10000) + "0000"));
		String dirSubPer00 = String.format("%07d", Integer.parseInt((int) (loginNo / 100) + "00"));
		String dirSubPer = String.format("%07d", Integer.parseInt((int) (loginNo / 1) + ""));
		String dirSub =  GlobalValue.ftpDir + "/user/" + dirSubPer000000 + "/" + dirSubPer0000 + "/" + dirSubPer00
				+ "/" + dirSubPer;// 워터마크 저장되는 ftp경로(파일명제외)

		String dstPath;// 앞으로 저장될 이미지의 경로(파일명포함)
		String fileName;// 파일명
		String pathFTP ="";

		// ftp연결 및 디렉토리 설정
		FTPUtil ftpUtil = FTPUtil.getInstance("112.175.245.57", 21, "gnb01", "gnbp01");
		boolean success;
		success = ftpUtil.connect();
		if (!success) {
			logger.debug("connect failed ");
			return null;
		}
		// 디렉토리 생성
		success = ftpUtil.createDirectory(dirSub);

		// 서버에존재하는 원터마크들을 저장 : 서버(워터마크) -> ftp(워터마크)
		// 파일명 추출
		int index = (srcPath.lastIndexOf("/") + 1);
		if ((srcPath.lastIndexOf("/") + 1) < (srcPath.lastIndexOf("\\") + 1))
			index = (srcPath.lastIndexOf("\\") + 1);
		fileName = srcPath.substring(index);

		// 저장될 전체경로 설정(파일명포함)
		dstPath = dirSub + "/" + fileName;
		logger.debug("my  server  , source        srcPath img save full path :" + srcPath);
		logger.debug("ftp server  , destination   dstPath img save full path :" + dstPath);
		FTPFile file = new FTPFile(srcPath, dstPath);
	
		ftpUtil.addUploadQueue(file);
		do {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} while (ftpUtil.checkStatus(file) == UploadStatus.NOT_YET);

		pathFTP = dstPath;// ftp저장경로 보관
		UploadStatus uploadStatus = ftpUtil.checkStatus(file);
		ftpUtil.clearList(file);
		
		return pathFTP;
	}
	//프로필 사진경로를 저장
	private void enrollPhotoPath(Integer loginNo, String photoPath) {
		memberMapper.updatePhotoUrl(loginNo, photoPath);//회원의 사진경로를 지정한다.
	}
	//프로필 사진경로를 가져옴
	public String getPhotoUrl(int loginNo) {
		return memberMapper.getPhotoUrl(loginNo);
	}
	//연락처를 가져옴
	public String getPhone(int loginNo) {
		return memberMapper.getPhone(loginNo);
	}
	//연락처를 수정
	public void updatePhone(int loginNo, String phone) { 
		memberMapper.updatePhone(loginNo, phone);
	}
	//고객번호를 통해 고객정보를 가져옴
	public RoomItemCartListVO getCartUserAboutCartListNo(Integer RoomItemCartListNo) {
		logger.debug("getCartUserAboutAgentNo  agentNo : " + RoomItemCartListNo);
		return memberMapper.getCartListAboutCartListNo(RoomItemCartListNo);
	}
	
	//사용기기 맥주소 번호를 회원에게 지정
	public void enrollMacAddress(int agentNo, String mac_address) {
		memberMapper.updateMacAddress(agentNo, mac_address);
	}
	//사용기기 맥주소 번호를 가져옴
	public String getMacAddress(int loginNo) {
		return memberMapper.getMacAddress(loginNo);
	}
	//사용기기 pc비교후 인증된 토큰을 설정
	public void enrollPcToken(int agentNo, String pc_token) {
		memberMapper.updatePcToken(agentNo, pc_token);
	}/*
	//사용기기 인증후의 토큰값을 가져옴
	public String getPcToken(int loginNo) {
		return memberMapper.getPcToken(loginNo);
	}*/
}
