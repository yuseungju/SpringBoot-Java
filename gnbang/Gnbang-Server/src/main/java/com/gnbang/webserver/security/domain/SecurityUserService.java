package com.gnbang.webserver.security.domain;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnbang.webserver.mapper.UserRoleMapper;

//securityConfig에  UserDetailsService형태로 자동주입됨
@Service
public class SecurityUserService implements UserDetailsService {
	@Autowired
	private UserRoleMapper userRoleMapper;

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public UserAndRole getUser(String username) throws Exception {
		UserAndRole userAndRoleVO = userRoleMapper.getUserAndRole(username);
		return userAndRoleVO;
	}

	@Override
	public UserDetails loadUserByUsername(String username) {
		UserAndRole user = null;
		try {
			user = userRoleMapper.getUserAndRole(username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return new SecurityUser(user);
	}
}
