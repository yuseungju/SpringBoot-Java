package com.gnbang.webserver.pojo;

import java.io.Serializable;

public class PojoSample extends LoggableElement implements Serializable {
	
	private static final long serialVersionUID = 20170111L;

	int value;
	String str;

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		this.str = str;
	}
}
