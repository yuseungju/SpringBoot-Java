package com.gnbang.webserver.mapper;

import org.apache.ibatis.annotations.Param;

public interface LoginMapper {
	String getPassword(@Param("email") String email);
	String getEmail(@Param("email") String email);//이메일이 존재하면 이메일을 가져옴(중복체크시사용)
}
