package com.gnbang.webserver.dto;

import com.gnbang.webserver.pojo.LoggableElement;

/*address_code 테이블
   CREATE TABLE `address_code` (
	`si`    VARCHAR(10) NULL, -- 시
	`gungu` VARCHAR(10) NULL, -- 구
	`dong`  VARCHAR(10) NULL, -- 동
	`code`  BIGINT(12)  NULL  -- 주소 고유 번호
);

 */
public class AddressCodeVO extends LoggableElement {
	String si;
	String gungu;
	String dong;
	long code;

	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		this.si = si;
	}

	public String getGungu() {
		return gungu;
	}

	public void setGungu(String gungu) {
		this.gungu = gungu;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public long getCode() {
		return code;
	}

	public void setCode(long code) {
		this.code = code;
	}

	@Override
	public boolean equals(Object o) {
		AddressCodeVO s = (AddressCodeVO) o;
		if (gungu.equals(s.getGungu()) && code == s.getCode()
				&& si.equals(s.getSi()) && dong.equals(s.getDong())) {
			return true;
		}
		else {
			return false;
		}
	}
}
