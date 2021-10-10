package com.gnbang.webserver.pojo.social;

import java.io.Serializable;

import com.gnbang.webserver.pojo.LoggableElement;

public class JoinKakao extends LoggableElement implements Serializable {

	private static final long serialVersionUID = 20170111L;

	long id;
	Properties properties;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}
}
