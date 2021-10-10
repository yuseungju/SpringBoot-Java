package com.gnbang.webserver.pojo.social;

import java.io.Serializable;

import com.gnbang.webserver.pojo.LoggableElement;
import com.google.gson.annotations.SerializedName;

public class Properties extends LoggableElement implements Serializable {

	private static final long serialVersionUID = 20170111L;

	String nickname;
	@SerializedName("profile_image")
	String profileImage;
	@SerializedName("thumbnail_image")
	String thumbnailImage;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getThumbnailImage() {
		return thumbnailImage;
	}

	public void setThumbnailImage(String thumbnailImage) {
		this.thumbnailImage = thumbnailImage;
	}
}
