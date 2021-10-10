package com.gnbang.webserver.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.dto.UserAgentVO;
import com.gnbang.webserver.dto.UserVO;
import com.gnbang.webserver.pojo.social.JoinFacebook;

public interface JoinMapper {
	
	//joinservice에서 사용
	UserVO getUser(String email); //email과 같은 사용자 get
	void addUser_agent(UserAgentVO user_agentVO); //중개사 정보추가
	void addUser(UserVO userVO);//회원 추가
	void addRole(@Param("roleNo") Integer roleNo, @Param("userNo") Integer userNo);//권한 추가
	Integer getRoleNo(String role);//권한에 해당되는 key값을 get
	Integer getUserNo();//최근등록된 회원의 번호를 get
}
