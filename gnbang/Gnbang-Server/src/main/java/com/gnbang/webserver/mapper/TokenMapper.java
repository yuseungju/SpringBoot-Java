package com.gnbang.webserver.mapper;

import org.apache.ibatis.annotations.Param;

public interface TokenMapper {
	String getPcToken(@Param("loginNo") Integer loginNo);//사용자의 사용 토큰을  가져옴
}
