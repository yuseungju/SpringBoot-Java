package com.gnbang.webserver.security.domain;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SecurityUser extends MyUser{//내가만든 user을 업캐스팅해서 스프링에서 사용하게함
	private static final long serialVersionUID = 7369103590269799780L;
	private UserAndRole user;
	private String currentConnectType;//접속중인 기기 종류(pc,모바일)
	private final static Logger logger = LoggerFactory.getLogger(SecurityUser.class);
	
	public SecurityUser(UserAndRole user){//내user 클래스를 받아 부모의 user로 넘겨줌 (정보 설정 작업)
		super(user.getEmail(), user.getPassword() , user.getName(), user.getNo(), user.getLevel(), user.getType(), user.getDate(),
				 user.getMac_address(), AuthorityUtils.createAuthorityList(user.getRole().toString()));
		this.user = user;
	}
	
	public UserAndRole getUser(){
		return user;
	}
	public Role getRole(){
		return user.getRole();
	}
	
	//호출시 컴퓨터 또는 모바일인지 여부를 설정하여 반환
	public String getCurrentConnectType(){
		if(currentConnectType == null){
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
			        .getRequestAttributes()).getRequest();
			String header = request.getHeader("User-Agent").toLowerCase().replaceAll("", "");
		    if (header.indexOf("mobile") != -1) {//모바일이면
				logger.debug("login mobile");
		    	currentConnectType = "mobile";
		    } else {//모바일이 아니면 pc이면
				logger.debug("login pc");
		    	currentConnectType = "pc";
		    }
		}
		return currentConnectType;
	}
}
