package com.gnbang.webserver.pojo.social;

import java.io.Serializable;

import com.gnbang.webserver.pojo.LoggableElement;

public class JoinFacebook extends LoggableElement implements Serializable {

	private static final long serialVersionUID = 20170111L;
	
	long id;
	String name;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
