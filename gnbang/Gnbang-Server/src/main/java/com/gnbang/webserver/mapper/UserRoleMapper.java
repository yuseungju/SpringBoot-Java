package com.gnbang.webserver.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.security.domain.UserAndRole;

import antlr.collections.List;

public interface UserRoleMapper {
	UserAndRole getUserAndRole(String username);
}
