package com.gnbang.webserver.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gnbang.webserver.mapper.LoginMapper;

@Service
public class LoginService {

	private final static Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	@Autowired
	private LoginMapper loginMapper;
	
	//비밀번호 일치여부 확인 
	public boolean checkEncodedPassword(String email, String encodePassword) {

		String pwd = loginMapper.getPassword(email);
		int[] chs = pwd.chars().toArray();
		pwd= "";
		for(int a=0; a<chs.length; a++)
			pwd += chs[a]+"_";
		if(encodePassword.equals(pwd))//입력비밀번호와 기존비밀번호확인
			return true;
		else 
			return false;
	}

	//이메일 중복확인
	public  boolean overlapEmail(String email) {
		// TODO Auto-generated method stub
		if(loginMapper.getEmail(email) == null){//중복이아니면
			return false;
		}
		return true;
	}
}