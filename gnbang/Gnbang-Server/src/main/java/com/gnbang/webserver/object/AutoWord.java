package com.gnbang.webserver.object;

import com.gnbang.webserver.pojo.LoggableElement;

//자동완성 단어의 정보
public class AutoWord extends LoggableElement {
	String firstWord;//자동완성 처음 단어값
	String secondWord;//공백이후 자동완성 단어 두번쨰 단어 값
	String thirdWord;//공백이후 자동완성 세번째 단어값
	String code;//주소/지하철/매물번호에 따른 각 고유값(key)
	String kind;//주소/ 지하철/ 매물번호중 하나의값


	public AutoWord(String firstWord, String secondWord, String thirdWord, String code, String kind) {
		super();
		this.firstWord = firstWord;
		this.secondWord = secondWord;
		this.thirdWord = thirdWord;
		this.code = code;
		this.kind = kind;
	}

	public String getFirstWord() {
		return firstWord;
	}

	public void setFirstWord(String firstWord) {
		this.firstWord = firstWord;
	}

	public String getSecondWord() {
		return secondWord;
	}

	public void setSecondWord(String secondWord) {
		this.secondWord = secondWord;
	}

	public String getThirdWord() {
		return thirdWord;
	}

	public void setThirdWord(String thirdWord) {
		this.thirdWord = thirdWord;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}
	
}
