package com.gnbang.webserver.security.domain;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gnbang.webserver.mapper.TokenMapper;
import com.gnbang.webserver.object.CartUser;
import com.gnbang.webserver.object.CartUserDetail;
import com.gnbang.webserver.object.LessorInfor;
import com.gnbang.webserver.object.SearchRoomSumary;

@Service
public class MyRoleAndTokenService {
	@Autowired
	private  TokenMapper tokenMapper;
	
	//호출시 컴퓨터 또는 모바일인지 여부를 설정하여 반환
	public String getCurrentConnectType(/*HttpServletRequest request*/){
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		String currentConnectType;
		String header = request.getHeader("User-Agent").toLowerCase().replaceAll("", "");
	    if (header.indexOf("mobile") != -1)//모바일이면
	    	currentConnectType = "mobile";
	    else //모바일이 아니면 pc이면
	    	currentConnectType = "pc";
		return currentConnectType;
	}
	//로그인 회원의 번호를 가져옴
	public Integer getLoginNo(){
		int loginNo =  -1;
		try{ 
			MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginNo = user.getNo();
		}catch(Exception E){
		}
		return loginNo;
	}
	//로그인한 회원의 권한이 맞는지확인
	public boolean hasRole(String role){
		//로그인하지않았으면 권한 없음(일치 불가)
		Integer loginNo = getLoginNo();
 		if(loginNo == -1)
			return false;
 		//로그인한 회원의 권한일치 여부확인
		MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		for (GrantedAuthority grantedAuthority : user.getAuthorities()) {
			if(grantedAuthority.getAuthority().equals(role))
				return true;
		}
		return false;
	}
	//로그인한 회원의 권한이름들을 문자열로 가져옴
	public ArrayList<String> getRoles(){
		ArrayList<String> roleList =  new  ArrayList<String>();
		//로그인하지않았으면 권한 없음(검색 불가)
		Integer loginNo = getLoginNo();
 		if(loginNo == -1)
			return roleList;
 		//로그인한 회원의 권한이름들을 가져옴(ROLE_USER, ROLE_AGENT..등)
		MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();//회원이 가지는 정보들을 전부가져옴
		for (GrantedAuthority grantedAuthority : user.getAuthorities()) //권한들의 개수만큼
			roleList.add(grantedAuthority.getAuthority().toString());//권한을 문자열로 가져옴
		return roleList;
	}
	//서버와 클라이언트  토큰을 비교해 기기인증 결과를 가져옴
	public  boolean isAuthenticableClientToken(String clientToken/*, HttpServletRequest request*/){
		//로그인 안했으면 유효하지않음
		Integer loginNo = getLoginNo();
 		if(loginNo == -1)
			return false;
 		//중개사권한이 아니면 유효성 없음
		if(!hasRole("ROLE_AGENT"))
			return false;
		
 		//연결 기기 종류에 따른 유효성검사
 		String currentConnectType = getCurrentConnectType(/*request*/);
		if(currentConnectType.equals("pc")){//pc접속이면
			//토큰이 존재하지않으면 유효하지않음 (어떠한 로그인으로도 인증 한적없는 pc)
			if(clientToken == null)
				return false;
			if(clientToken.length() < 1)
				return false;
			//서버측과 클라이언트측의 토큰값비교
			String serverToken = getServerPcToken();
			if(clientToken.equals(serverToken))//서버측과 클라이언트측의 토큰값이 맞으면 
				return true;//유효
			else //서버측과 클라이언트측의 토큰값이 다르면(인증한 pc와 다른 pc)
				return false;//유효하지않음
		}
		else if(currentConnectType.equals("mobile")){//모바일접속이면
			/*//앱인증 이전 
			if(loginNo == 15)*/
				return true;//임시로 가능하도록
		}
		return false;
	}
	//검색된 매물의 주요정보를 토큰인증에 따라 일부  제한
	public void limitSearchRoomSumaryListAboutRole(
			ArrayList<SearchRoomSumary> searchRoomSumary, String clientToken/*, HttpServletRequest request*/){
		if(!isAuthenticableClientToken(clientToken/*, request*/)){
			for(int a=0; a< searchRoomSumary.size(); a++){
				searchRoomSumary.get(a).setLast_address("");
				searchRoomSumary.get(a).setSub_address(0);
				searchRoomSumary.get(a).setMain_address(0);
				searchRoomSumary.get(a).setContact_phone_1("");
				searchRoomSumary.get(a).setContact_phone_2("");
				searchRoomSumary.get(a).setContact_phone_3("");
				searchRoomSumary.get(a).setContact_who_1("");
				searchRoomSumary.get(a).setContact_who_2("");
				searchRoomSumary.get(a).setContact_who_3("");
			}
		}
	}
	//검색된 임대인연락처의 정보를 일부 제한
	public void limitLessorInfor(LessorInfor lessorInfor, String clientToken) {
		if(!isAuthenticableClientToken(clientToken/*, request*/)){
			lessorInfor.setContact_who_1("");
			lessorInfor.setContact_who_2("");
			lessorInfor.setContact_who_3("");
			lessorInfor.setContact_phone_1("pc인증 필요");
			lessorInfor.setContact_phone_2("");
			lessorInfor.setContact_phone_3("");
		}
	}
	//검색된 관심매물의 주요정보를 토큰인증에 따라 일부 제한
	public void limitCartUserListAboutRole(
			ArrayList<CartUser> cartUser, String clientToken/*, HttpServletRequest request*/){
		if(!isAuthenticableClientToken(clientToken/*, request*/)){
			for(int a=0; a< cartUser.size(); a++){
				cartUser.get(a).setSub_address(0);
				cartUser.get(a).setLast_address("");
				cartUser.get(a).setMain_address(0);
			}
		}
	}
	//검색된 관심고객폴더에 해당되는 매물정보의 정보 일부 제한
	public void limitCartUserDetail(ArrayList<CartUserDetail> cartUserDetail, String clientToken) {
		if(!isAuthenticableClientToken(clientToken/*, request*/)){
			for(int a=0; a< cartUserDetail.size(); a++){
				cartUserDetail.get(a).setSub_address(0);
				cartUserDetail.get(a).setLast_address("");
				cartUserDetail.get(a).setMain_address(0);
			}
		}
	}
	//접속중인 회원의 등록 pc의 토큰값을 db로부터 가져옴(서버 토큰값)
	public  String getServerPcToken(){
		Integer loginNo = getLoginNo();
		if(loginNo == -1)
			return "";
		String serverPcToken = tokenMapper.getPcToken(loginNo);
		if(serverPcToken == null)
			return "";
		if(serverPcToken.length() < 1)
			return "";
		return serverPcToken;
	}
}
