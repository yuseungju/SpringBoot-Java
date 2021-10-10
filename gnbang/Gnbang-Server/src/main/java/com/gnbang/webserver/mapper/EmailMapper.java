package com.gnbang.webserver.mapper;

import org.apache.ibatis.annotations.Param;


public interface EmailMapper {
	String getPassword(@Param("email") String email); //중개사 정보추가
	
}
