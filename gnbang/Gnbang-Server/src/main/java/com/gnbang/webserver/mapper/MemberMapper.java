package com.gnbang.webserver.mapper;

import org.apache.ibatis.annotations.Param;

import com.gnbang.webserver.dto.RoomItemCartListVO;
import com.gnbang.webserver.dto.UserVO;

public interface MemberMapper {
	UserVO getEncodePassword(@Param("email") String email);//이메일에 해당되는 비밀번호를 가져옴
	String getPhone(@Param("no") Integer no);//회원번호에 해당되는 연락처를 가져옴 
	void updatePhone(@Param("no") Integer no, @Param("phone") String phone);//회원번호에 해당되는 연락처를 수정
	
	Integer updateLeaveDate(@Param("email") String email);//회원을 탈퇴상태로 수정
	Integer updatePassword(@Param("email") String email, @Param("password") String password);//비밀번호 수정
	void updatePhoneInUserAboutUserNo(@Param("loginNo") Integer loginNo, @Param("phone") Integer phone);//사용자의 연락처를 수정
	void updatePhotoUrl(@Param("loginNo") Integer loginNo, @Param("photoUrl") String photoUrl);//회원의 프로필사진 경로를 지정
	String getPhotoUrl(@Param("loginNo") Integer loginNo);//회원이 등록한 프로필 사진경로를 get
	RoomItemCartListVO getCartListAboutCartListNo(@Param("roomItemCartListNo") Integer roomItemCartListNo);//관심고객폴더 번호에 해당되는 관심고객폴더를 가져옴
	void updateMacAddress(@Param("loginNo") Integer loginNo,@Param("mac_address") String mac_address);//사용자의 사용 맥주소를 변경
	String getMacAddress(@Param("loginNo") Integer loginNo);//사용자의 사용 맥주소를 가져옴
	void updatePcToken(@Param("loginNo") Integer loginNo, @Param("pc_token") String pc_token);//사용자 유효토큰을 설정
	
	
	/*//사용자의 사용 토큰을 수정
	String getPcToken(@Param("loginNo") Integer loginNo);//사용자의 사용 토큰을  가져옴
*/}
