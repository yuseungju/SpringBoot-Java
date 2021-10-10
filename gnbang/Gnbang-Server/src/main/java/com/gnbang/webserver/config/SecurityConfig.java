package com.gnbang.webserver.config;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.gnbang.webserver.security.domain.SecurityUser;
import com.gnbang.webserver.security.domain.SecurityUserService;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Order( SecurityProperties.ACCESS_OVERRIDE_ORDER)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	public UserDetailsService userDetailsService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
       //auth.userDetailsService(userDetailsService);
        auth.userDetailsService(userDetailsService)
        .passwordEncoder(new BCryptPasswordEncoder());
    }    
    
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http
            .authorizeRequests()
            .antMatchers("/user/**")
            .access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN') or hasRole('ROLE_SUPER')") 
            .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN') or hasRole('ROLE_SUPER')") 
            .antMatchers("/super/**").access("hasRole('ROLE_SUPER')") 
            .and()
            .formLogin()
            .loginProcessingUrl("/security_login_process")//	 로그인 페이지 form action에 입력할 주소 지정
            .failureHandler(new CustomAuthenticationFailureHandler())//로그인 실패 처리
            /*.successHandler(new CustomAuthenticationSuccessHandler())//로그인 성공처리*/           
            .usernameParameter("email")     
            .passwordParameter("password")
            .permitAll()
            .and()
            .logout()
            .logoutUrl("/logout")
            .permitAll().logoutSuccessUrl("/")
	        .and()
	        .csrf().disable();
    }
}

//로그인 실패시 사용 
class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException auth) throws IOException, ServletException {
    	  response.setContentType("text/html;charset=utf-8");
		  PrintWriter out = response.getWriter();
		  out.println("<script>alert('이메일 또는 비밀번호를 다시 확인해주세요.'); location.href='/';</script>"); 
		  out.flush(); 
    }
}
/*
class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler  {
  
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		//권한 획득
		String role = "";
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		for (GrantedAuthority grantedAuthority : authorities) {
			if ((grantedAuthority.getAuthority() + "").equals("ROLE_AGENT")) {
				role = "ROLE_AGENT";
				break;
			} else if (grantedAuthority.equals("ROLE_USER")) {
				role = "ROLE_USER";
				break;
			}
		}

		//pc 모바일 구분
		String currentConnectType ="";
		String header = request.getHeader("User-Agent").toLowerCase().replaceAll("", "");
	    if (header.indexOf("mobile") != -1) {//모바일이면
			logger.debug("mobile");
	    	currentConnectType = "mobile";
	    } else {//모바일이 아니면 pc이면
			logger.debug("pc");
	    	currentConnectType = "pc";
	    }
	    
	    //이미 등록된 사용기기 pc 맥주소를 가져옴
	    SecurityUser springSecurityUser =  (SecurityUser)authentication.getPrincipal();
	    String enrolledMacAddress =  springSecurityUser.getEnrollMacAddress();
		response.setContentType("text/html;charset=utf-8");
		String str = "<script>";
		if(role.equals("ROLE_AGENT")){
			if(currentConnectType.equals("pc")){
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");  
				str +=	"var mac_address = getClientMacAddress();";
				//pc인증프로그램을 설치유도, pc등록유도 
				str +=	"if(mac_address == 'err'){//설치프로그램에 대한 접근에러시";
				str +=	"	 alert('중개사 업무 기능을 이용하기위해서는 pc인증 프로그램을 설치해야 됩니다.');";
				str +=  "    document.location.href=\"/member/agent/hardware_enroll\";";
				//맥주소를 등록한적이 없으면
				str +=  "}else if((" + enrolledMacAddress.length() +" == 0){//등록된 맥주소가 없으면 ";
				str +=  "	 alert('중개사 업무 기능을 이용하기위해서는 pc를 인증해야 합니다.');";
				str +=  "	 document.location.href=\"/member/agent/hardware_enroll\";";
				//pc번호가 다르면 로그아웃 
				str +=	"}else if("+enrolledMacAddress+" != mac_address){";
				str += 	"	 alert('인증된 pc로 로그인하지 않으면 기능이 제한됩니다.');";
				str +=  "		 document.location.href=\"/\";";
				//사용 pc 인증이 완료됐으면 
				str +=	"}else{";
				str +=		 "alert('pc인증 성공');";
				str +=		 "document.cookie = \""+ uuid +"\";";
				str +=	"}";
				//디비 pc_token을 uuid로 설정
				str += "setClientPcToken("+ uuid +");";
			}
		}else{
			
		}
	    str += "</script>";
		PrintWriter out = response.getWriter();
		out.println(str);
		out.flush();
		
		//중개사 로그인 된 상태이면 바로 기기확인
		alert('1');
		alert(<%= request.getAttribute("pc_authorization")%>);
		if(<%= request.isUserInRole("ROLE_AGENT")%>){
			if('${currentConnectType}' == 'pc'){
				//프로그램이 설치안됐으면(중개사 웹프로그램과의 통신에러)
				var mac_address = getClientMacAddress();
				if(mac_address == 'err'){//설치프로그램에 대한 접근에러시
					alert('중개사 업무 기능을 이용하기위해서는 pc인증 프로그램을 설치해야 됩니다.');
			   		document.location.href="/member/agent/hardware_enroll";
				}else if(('${enrolledMacAddress}').length == 0){//등록된 맥주소가 없으면 
			   		alert('중개사 업무 기능을 이용하기위해서는 pc를 인증해야 합니다.');
			   		document.location.href="/member/agent/hardware_enroll";
				}else if('${enrolledMacAddress}' != mac_address){
			   		alert('인증된 pc로 로그인하지 않으면 기능이 제한될 수 있습니다.');
			   		document.location.href="/";
				}else{
					alert('pc인증 성공');
					<% request.setAttribute("pc_authorization", "Authorized");%>
				}
				
				//등록한pc로접속한게 아니라면
				//pc인증프로그램을 설치유도, pc등록유도 
				
				//pc번호가 다르면 
				//로그아웃 
				
				//pc번호가 일치하면
				//로그인상태 유지
			}
		}
	}
        response.sendRedirect("/");
	}

}*/