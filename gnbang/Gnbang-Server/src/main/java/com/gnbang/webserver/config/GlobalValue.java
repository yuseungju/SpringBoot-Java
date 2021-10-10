package com.gnbang.webserver.config;
/*
 * 테스트에서 서버에 올릴때 필요한 작업 
 * 서버(도메인)로 맞줘진 api키 적용
 * 이미지 서버 저장경로를 실재 경로로 적용(test상위경로가 없어짐)
 * */

public class GlobalValue{
	
	    //local 테스트용 localhost:8080
		//jsp: agentShow, detail, enroll_overlap_check, enroll_informaion에서 사용
		public static final String mapApi ="af637caf9dd27d7d6f35e3c10c842759";
		
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String kakaoApi ="abc738713afad871436c98e830e85057";
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String facebookApi ="1834443770127455";
		//java: RoomService 에서 사용
		public static final String ftpDir = "/test";//저장되는 ftp상위 경로를 test로 설정. /test/photo ...
		
		public static final String serverPhotoDir = "/mnt/test/photo/";//매물사진이 저장되는 원본상위 경로 (로컬 임의 위치 지정 가능)
		public static final String serverUserDir = "/mnt/test/user/";//프로필사진이 저장되는 원본상위 경로 (로컬 임의 위치 지정 가능)
		
		//java: emailService의 sendPasswordLink(email)에서 사용
		public static final String passwordLink = "http://localhost:8080/";//새비밀번호 입력창의 상위링크

		
/*	
 	//서버  테스트용(업로드는 test폴더를 두고 확인) http://xn--939au0gp6l.net
	//!주의  - 서버테스트시 서버의 db값 수정됨
		//jsp: agentShow, detail, enroll_overlap_check, enroll_informaion에서 사용
		public static final String mapApi ="7b3d028d19b3124b73ccfe1c2104fa9e";
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String kakaoApi ="154f43ad3eb6f583dea1a79705505d6d";
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String facebookApi ="1085398554901946";
		public static final String ftpDir = "/test";//ftp상위경로로
		public static final String serverPhotoDir = "/mnt/test/photo/";//매물사진이 저장되는 원본상위 경로 
		public static final String serverUserDir = "/mnt/test/user/";//프로필사진이 저장되는 원본상위 경로
		
		//java: emailService의 sendPasswordLink(email)에서 사용
		public static final String passwordLink = "http://xn--939au0gp6l.net/";//새비밀번호 입력창의 상위링크

*/
/*	//!주의 !주의 - db값, ftp업로드, 서버업로드 내용 수정됨
	//서버제공용 http://xn--939au0gp6l.c
		//jsp: agentShow, detail, enroll_overlap_check, enroll_informaion에서 사용
		public static final String mapApi ="7b3d028d19b3124b73ccfe1c2104fa9e";
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String kakaoApi ="154f43ad3eb6f583dea1a79705505d6d";
		//jsp: mainTemplate, basicTemplate 에서 사용
		public static final String facebookApi ="1085398554901946";
		public static final String ftpDir = "";//ftp상위경로로   (!업로드 주의)
		public static final String serverPhotoDir = "/mnt/photo/";//매물사진이 저장되는 원본상위 경로   (!업로드  주의)
		public static final String serverUserDir = "/mnt/user/";//프로필사진이 저장되는원본상위 경로   (!업로드  주의)
		//java: emailService의 sendPasswordLink(email)에서 사용
		public static final String passwordLink = "http://xn--939au0gp6l.com/";//새비밀번호 입력창의 상위링크
*/
		//기타 고정 정보 설정
		public static final String agentManager = "김혜옥";//중개 담당
		public static final String agentManagerContact = "010-8844-2886";//중개 담당 연락처
		public static final String agentRepresentative = "정기준";//중개 대표
		public static final String agentRepresentativeContact = "010-8844-2886";//중개 대표 연락처
		public static final String gnbangCorporationContact = "010-8844-2886";//회사 법인 연락처
		public static final String gnbangAddress = "강남구 논현로 152길 35";//회사 주소
}

