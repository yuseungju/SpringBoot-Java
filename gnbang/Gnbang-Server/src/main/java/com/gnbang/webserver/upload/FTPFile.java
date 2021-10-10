package com.gnbang.webserver.upload;

public class FTPFile {
	
	public FTPFile(String inputFile, String outputFile) {
		super();
		this.inputFile = inputFile;
		this.outputFile = outputFile;
	}

	String inputFile;
	String outputFile;

	public String getInputFile() {
		return inputFile;
	}

	public void setInputFile(String inputFile) {
		this.inputFile = inputFile;
	}

	public String getOutputFile() {
		return outputFile;
	}

	public void setOutputFile(String outputFile) {
		this.outputFile = outputFile;
	}
}
