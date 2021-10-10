package com.gnbang.webserver.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnbang.webserver.controller.JoinController;
import com.gnbang.webserver.dto.UserAgentVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.service.JoinService;
import com.google.gson.Gson;
import com.gnbang.webserver.dto.UserAgentVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.mapper.JoinMapper;
import com.gnbang.webserver.pojo.social.JoinFacebook;
import com.gnbang.webserver.pojo.social.JoinKakao;

//JoinController에서 사용
@Service
public class JoinService {

	private final static Logger logger = LoggerFactory.getLogger(JoinService.class);

	@Autowired
	private JoinMapper joinMapper;

	// input: 가입할 중개사 데이터
	// process: 중개사 데이터 db( table: user_agent) 삽입
	public void addUserAgent(UserVO userVO, UserAgentVO user_agentVO) {
		// 중개사의 정보를 일반과 중개사정보 설정
		userVO.setAgreement(true);// 동의상태 : TRUE
		userVO.setLevel(0);
		userVO.setType(4);

		// 회원 비밀번호 암호화
		String encodedPassword = new BCryptPasswordEncoder().encode(userVO.getPassword());
		userVO.setPassword(encodedPassword);

		// 중개사 회원 등록
		Integer userNo;
		synchronized (this) {
			joinMapper.addUser(userVO);// 일반적인 회원정보를 추가
			userNo = joinMapper.getUserNo();// 지금 등록한 일반적인 회원의 번호를 가져옴
		}
		user_agentVO.setUser_no(userNo);
		joinMapper.addUser_agent(user_agentVO);// 회원의 중개사만의 정보 추가

		// 중개사 회원 권한 등록
		Integer roleNo = joinMapper.getRoleNo("ROLE_USER");// 권한리스트에서 권한의 번호를 가져옴
		joinMapper.addRole(roleNo, userNo);// 권한 번호와 등록사용자 번호를 권한테이블에 삽입
	}

	// input: 가입할 임대인 회원 데이터
	// process: 임대인회원 데이터 db( table: user table) 삽입
	public void addUserLessor(UserVO userVO) {
		// 회원 기본정보 설정
		userVO.setAgreement(true);// 동의상태 : TRUE
		userVO.setLevel(0);
		userVO.setType(3);

		// 회원 비밀번호 암호화
		String encodedPassword = new BCryptPasswordEncoder().encode(userVO.getPassword());
		userVO.setPassword(encodedPassword);

		// 권환과 회원을 등록
		Integer userNo;
		synchronized (this) {
			joinMapper.addUser(userVO);// 사용자 등록
			userNo = joinMapper.getUserNo();// 지금 등록한 회원의 번호를 가져옴
		}
		Integer roleNo = joinMapper.getRoleNo("ROLE_LESSOR");// 권한리스트에서 권한의 번호
															// 가져옴
		joinMapper.addRole(roleNo, userNo);// 권한 번호와 등록한회원 번호를 권한테이블에 삽입
	}

	// input: 가입할 일반회원 데이터
	// process: 일반회원 데이터 db( table: user table) 삽입
	public void addUser(UserVO userVO) {
		// 회원 기본정보 설정
		userVO.setAgreement(true);// 동의상태 : TRUE
		userVO.setLevel(0);
		userVO.setType(0);

		// 회원 비밀번호 암호화
		String encodedPassword = new BCryptPasswordEncoder().encode(userVO.getPassword());
		userVO.setPassword(encodedPassword);

		// 권환과 회원을 등록
		Integer userNo;
		synchronized (this) {
			joinMapper.addUser(userVO);// 사용자 등록
			userNo = joinMapper.getUserNo();// 지금 등록한 회원의 번호를 가져옴
		}
		Integer roleNo = joinMapper.getRoleNo("ROLE_USER");// 권한리스트에서 권한의 번호 가져옴
		joinMapper.addRole(roleNo, userNo);// 권한 번호와 등록한회원 번호를 권한테이블에 삽입
	}

	// input: 가입할 일반회원 카카오 id 데이터
	// process: 카카오톡정보로 일반회원 데이터 db( table: user table) 삽입
	public void addKakaoUser(UserVO userVO) {
		if (userVO.getEmail().equals("0"))
			return;// kakao에서 로그인 이메일을 못 가져왔으면
		if (joinMapper.getUser(userVO.getEmail()) != null)
			return;// 강남방에 가입했던 회원이면

		// 회원 기본정보 설정
		userVO.setAgreement(true);// 동의상태 : TRUE
		userVO.setLevel(0);
		userVO.setType(2);
		userVO.setPassword("social");
		System.out.println(userVO);

		System.out.println(userVO);
		// 권환과 회원을 등록
		Integer userNo;
		synchronized (this) {
			joinMapper.addUser(userVO);// 사용자 등록
			userNo = joinMapper.getUserNo();// 지금 등록한 회원의 번호를 가져옴
		}
		Integer roleNo = joinMapper.getRoleNo("ROLE_USER");// 권한리스트에서 권한의 번호 가져옴
		joinMapper.addRole(roleNo, userNo);// 권한 번호와 등록한회원 번호를 권한테이블에 삽입
	}

	// input: 가입할 일반회원 페이스북 데이터
	// process: 페이스북정보로 일반회원 데이터 db( table: user table) 삽입
	public void addFacebookUser(UserVO userVO) {
		if (userVO.getEmail().equals("0"))//Facebook에서 로그인 이메일을 못 가져왔으면
			return;
		if (joinMapper.getUser(userVO.getEmail()) != null)
			return;// 강남방에 가입했던 회원이면

		// 회원 기본정보 설정
		userVO.setAgreement(true);// 동의상태 : TRUE
		userVO.setLevel(0);
		userVO.setType(1);
		userVO.setPassword("social");
		logger.info(userVO.toString());

		System.out.println(userVO);
		// 권환과 회원을 등록
		Integer userNo;
		synchronized (this) {
			joinMapper.addUser(userVO);// 사용자 등록
			userNo = joinMapper.getUserNo();// 지금 등록한 회원의 번호를 가져옴
		}
		Integer roleNo = joinMapper.getRoleNo("ROLE_USER");// 권한리스트에서 권한의 번호 가져옴
		joinMapper.addRole(roleNo, userNo);// 권한 번호와 등록한회원 번호를 권한테이블에 삽입
	}

}
